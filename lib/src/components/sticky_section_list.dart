import 'package:flutter/widgets.dart';
import 'package:zuraffa_ui/src/theme/theme.dart';
import 'package:zuraffa_ui/src/utils/border.dart';

/// {@template ShadListSection}
/// A section in a [ShadStickySectionList] with a header widget and items.
/// {@endtemplate}
class ShadListSection {
  /// {@macro ShadListSection}
  const ShadListSection({required this.header, required this.items});

  /// The header widget displayed at the top of this section.
  ///
  /// Rendered both inline (within the scrollable content) and as the
  /// sticky title pinned at the top of the viewport when this section
  /// is the active one.
  final Widget header;

  /// The item widgets contained in this section.
  final List<Widget> items;
}

/// {@template ShadStickySectionList}
/// A scrollable list with a single dynamic sticky header that updates
/// based on the current section in view.
///
/// The header at the top changes instantly (no animation) to reflect
/// the section currently being scrolled through. Section headers appear
/// inline within the scrollable content. The active section is detected
/// by measuring the real, live position of each inline header on every
/// scroll frame, so the title switches exactly when a section's header
/// reaches the top of the scroll area — regardless of item heights,
/// async image loads, or viewport resizes.
///
/// Use as the `child` of a `ShadSheet` with `scrollable: false`:
///
/// ```dart
/// showShadSheet(
///   context: context,
///   builder: (context) => ShadSheet(
///     scrollable: false,
///     child: ShadStickySectionList(
///       sections: [
///         ShadListSection(
///           header: Text('Popular'),
///           items: popularProducts
///               .map((p) => ProductCard(product: p))
///               .toList(),
///         ),
///         ShadListSection(
///           header: Text('New Arrivals'),
///           items: newProducts.map((p) => ProductCard(product: p)).toList(),
///         ),
///       ],
///     ),
///   ),
/// );
/// ```
/// {@endtemplate}
class ShadStickySectionList extends StatefulWidget {
  /// {@macro ShadStickySectionList}
  const ShadStickySectionList({
    super.key,
    required this.sections,
    this.controller,
    this.physics,
    this.padding,
    this.headerPadding,
    this.headerBackgroundColor,
    this.headerBorder,
    this.headerAlignment,
    this.inlineHeaderPadding,
    this.inlineHeaderBackgroundColor,
    this.clipBehavior = Clip.hardEdge,
    this.onSectionChanged,
  });

  /// The sections to display in the list.
  final List<ShadListSection> sections;

  /// Optional [ScrollController] for the internal scroll view.
  final ScrollController? controller;

  /// Scroll physics for the list.
  final ScrollPhysics? physics;

  /// {@template ShadStickySectionList.padding}
  /// Padding around the entire scrollable content.
  /// Defaults to [EdgeInsets.zero].
  /// {@endtemplate}
  final EdgeInsetsGeometry? padding;

  /// {@template ShadStickySectionList.headerPadding}
  /// Padding inside the sticky header pinned at the top.
  /// Defaults to `EdgeInsets.fromLTRB(24, 20, 24, 12)`.
  /// {@endtemplate}
  final EdgeInsetsGeometry? headerPadding;

  /// {@template ShadStickySectionList.headerBackgroundColor}
  /// Background color of the sticky header.
  /// Defaults to the theme's background color.
  /// {@endtemplate}
  final Color? headerBackgroundColor;

  /// {@template ShadStickySectionList.headerBorder}
  /// Border surrounding the sticky header.
  /// Defaults to a bottom border using the theme's border color.
  /// {@endtemplate}
  final ShadBorder? headerBorder;

  /// {@template ShadStickySectionList.headerAlignment}
  /// Alignment of the header content within the sticky header bar.
  /// Defaults to [Alignment.centerLeft].
  /// {@endtemplate}
  final AlignmentGeometry? headerAlignment;

  /// {@template ShadStickySectionList.inlineHeaderPadding}
  /// Padding inside the inline section headers within the scroll content.
  /// Defaults to `EdgeInsets.symmetric(horizontal: 24, vertical: 12)`.
  /// {@endtemplate}
  final EdgeInsetsGeometry? inlineHeaderPadding;

  /// {@template ShadStickySectionList.inlineHeaderBackgroundColor}
  /// Background color of the inline section headers.
  /// Defaults to the theme's muted color at 30% alpha.
  /// {@endtemplate}
  final Color? inlineHeaderBackgroundColor;

  /// {@macro flutter.widgets.Clip}
  final Clip clipBehavior;

  /// {@template ShadStickySectionList.onSectionChanged}
  /// Called when the active section changes during scrolling.
  ///
  /// The callback receives the zero-based index of the newly active section.
  /// Useful for tracking which section is currently in view, for example
  /// to prefetch data or update external state.
  /// {@endtemplate}
  final ValueChanged<int>? onSectionChanged;

  @override
  State<ShadStickySectionList> createState() => _ShadStickySectionListState();
}

class _ShadStickySectionListState extends State<ShadStickySectionList> {
  late final ScrollController _scrollController;
  int _currentSectionIndex = 0;

  /// Anchors header measurements to the list viewport rather than the whole
  /// [Column]. Measuring from the viewport keeps header offsets independent
  /// of the sticky bar's height, so a bar height change (e.g. an empty ad
  /// section header) cannot shift the offsets and re-trigger the active
  /// section calculation — the feedback loop that caused rapid flickering.
  final GlobalKey _listViewportKey = GlobalKey();

  final Map<int, _InlineSectionHeaderState> _mountedHeaders = {};

  /// Whether a post-frame re-evaluation is already scheduled. Scroll
  /// notifications arrive before the frame that lays out the scrolled
  /// content, and layout can mount/unmount inline headers — measuring during
  /// the notification uses the previous frame's geometry and can leave the
  /// pinned title stale. Evaluating after the frame instead makes every
  /// decision use the positions the user actually sees.
  bool _postFrameCheckScheduled = false;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.controller ?? ScrollController();
    _scrollController.addListener(_onScroll);
    _schedulePostFrameCheck();
  }

  @override
  void didUpdateWidget(covariant ShadStickySectionList oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Don't clear _mountedHeaders here just because widget.sections changed.
    // If sections change identity (e.g. built dynamically), clearing the map
    // breaks tracking because already-mounted headers won't re-run initState.
    // The headers manage their own presence in the map via build/dispose.
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _scrollController.dispose();
    } else {
      _scrollController.removeListener(_onScroll);
    }
    super.dispose();
  }

  void _schedulePostFrameCheck() {
    if (_postFrameCheckScheduled) return;
    _postFrameCheckScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _postFrameCheckScheduled = false;
      if (mounted) _updateCurrentSection();
    });
  }

  void _onHeaderMounted(int sectionIndex, _InlineSectionHeaderState state) {
    _mountedHeaders[sectionIndex] = state;
    // Re-measure once the new header has been laid out.
    _schedulePostFrameCheck();
  }

  void _unregisterHeader(int sectionIndex, _InlineSectionHeaderState state) {
    if (_mountedHeaders[sectionIndex] == state) {
      _mountedHeaders.remove(sectionIndex);
    }
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    _schedulePostFrameCheck();
  }

  void _updateCurrentSection() {
    if (!_scrollController.hasClients) return;

    final listBox =
        _listViewportKey.currentContext?.findRenderObject() as RenderBox?;
    if (listBox == null || !listBox.attached) return;

    // Scan in ascending section order so the result never depends on the
    // order headers happened to mount (a zero-height header tied with the
    // next one must not flip the outcome).
    final indices = _mountedHeaders.keys.toList()..sort();

    // The active section is the last one whose inline header has reached the
    // top of the list viewport. Headers above the top belong to sections
    // that have been scrolled past.
    int? lastCrossedIndex;
    for (final idx in indices) {
      final renderObject = _mountedHeaders[idx]?.renderObject;
      if (renderObject == null || !renderObject.attached) continue;
      final headerBox = renderObject as RenderBox;
      final dy = headerBox.localToGlobal(Offset.zero, ancestor: listBox).dy;
      if (dy <= 0) lastCrossedIndex = idx;
    }

    int active;
    if (lastCrossedIndex != null) {
      active = lastCrossedIndex;
    } else if (indices.isNotEmpty) {
      // Not necessarily the start of the list: the active section's own
      // header may have been recycled out of the cache extent while the
      // next section's header is already mounted below the top. The
      // section before the first mounted header is active then; at the
      // start of the list this degenerates to index 0.
      active = indices.first > 0 ? indices.first - 1 : 0;
    } else {
      active = _currentSectionIndex;
    }

    if (_currentSectionIndex != active) {
      setState(() => _currentSectionIndex = active);
      widget.onSectionChanged?.call(active);
      // Re-verify once the rebuilt sticky bar has been laid out.
      _schedulePostFrameCheck();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final stickyListTheme = theme.stickySectionListTheme;

    final effectivePadding =
        widget.padding ?? stickyListTheme.padding ?? EdgeInsets.zero;
    final effectiveHeaderPadding =
        widget.headerPadding ??
        stickyListTheme.headerPadding ??
        const EdgeInsets.fromLTRB(24, 20, 24, 12);
    final effectiveHeaderBackgroundColor =
        widget.headerBackgroundColor ??
        stickyListTheme.headerBackgroundColor ??
        theme.colorScheme.background;
    final effectiveHeaderBorder =
        widget.headerBorder ??
        stickyListTheme.headerBorder ??
        ShadBorder(bottom: ShadBorderSide(color: theme.colorScheme.border));
    final effectiveHeaderAlignment =
        widget.headerAlignment ??
        stickyListTheme.headerAlignment ??
        Alignment.centerLeft;
    final effectiveInlineHeaderPadding =
        widget.inlineHeaderPadding ??
        stickyListTheme.inlineHeaderPadding ??
        const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
    final effectiveInlineHeaderBackgroundColor =
        widget.inlineHeaderBackgroundColor ??
        stickyListTheme.inlineHeaderBackgroundColor ??
        theme.colorScheme.muted.withValues(alpha: 0.3);

    final currentSection =
        widget.sections.isNotEmpty &&
            _currentSectionIndex < widget.sections.length
        ? widget.sections[_currentSectionIndex]
        : null;

    return Column(
      children: [
        if (currentSection != null)
          _StickyHeader(
            section: currentSection,
            padding: effectiveHeaderPadding,
            backgroundColor: effectiveHeaderBackgroundColor,
            border: effectiveHeaderBorder,
            alignment: effectiveHeaderAlignment,
          ),
        Expanded(
          child: KeyedSubtree(
            key: _listViewportKey,
            child: ListView.builder(
              controller: _scrollController,
              physics: widget.physics,
              clipBehavior: widget.clipBehavior,
              padding: effectivePadding,
              itemCount: _calculateTotalItemCount(),
              itemBuilder: (context, index) => _buildItemAtIndex(
                context,
                index,
                effectiveInlineHeaderPadding,
                effectiveInlineHeaderBackgroundColor,
                effectiveHeaderAlignment,
              ),
            ),
          ),
        ),
      ],
    );
  }

  int _calculateTotalItemCount() {
    return widget.sections.fold<int>(
      0,
      (sum, section) => sum + 1 + section.items.length,
    );
  }

  Widget _buildItemAtIndex(
    BuildContext context,
    int index,
    EdgeInsetsGeometry inlineHeaderPadding,
    Color inlineHeaderBackgroundColor,
    AlignmentGeometry headerAlignment,
  ) {
    var remaining = index;
    for (var i = 0; i < widget.sections.length; i++) {
      final section = widget.sections[i];
      if (remaining == 0) {
        // Skip rendering the inline header for the first section — the sticky
        // header at the top already displays it. We still need a zero-height
        // widget so the scroll-position tracking (renderObject lookup) works.
        return _InlineSectionHeader(
          key: ValueKey('shad-sticky-header-$i'),
          sectionIndex: i,
          section: section,
          padding: inlineHeaderPadding,
          backgroundColor: inlineHeaderBackgroundColor,
          alignment: headerAlignment,
          onMounted: _onHeaderMounted,
          onUnmounted: _unregisterHeader,
          visible: i != 0,
        );
      }
      remaining--;
      if (remaining < section.items.length) {
        return section.items[remaining];
      }
      remaining -= section.items.length;
    }
    return const SizedBox.shrink();
  }
}

/// The fixed header bar pinned at the top updates instantly without animation.
class _StickyHeader extends StatelessWidget {
  const _StickyHeader({
    required this.section,
    required this.padding,
    required this.backgroundColor,
    required this.border,
    required this.alignment,
  });

  final ShadListSection section;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final ShadBorder border;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: border.toBorder(),
      ),
      child: Align(alignment: alignment, child: section.header),
    );
  }
}

/// Inline section header rendered within the scrollable list.
///
/// Registers itself with the parent on mount so the parent can read its
/// live render-object position on every scroll frame.
class _InlineSectionHeader extends StatefulWidget {
  const _InlineSectionHeader({
    super.key,
    required this.sectionIndex,
    required this.section,
    required this.padding,
    required this.backgroundColor,
    required this.alignment,
    required this.onMounted,
    required this.onUnmounted,
    this.visible = true,
  });

  final int sectionIndex;
  final ShadListSection section;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final AlignmentGeometry alignment;
  final void Function(int sectionIndex, _InlineSectionHeaderState state)
  onMounted;
  final void Function(int sectionIndex, _InlineSectionHeaderState state)
  onUnmounted;

  /// When false the widget renders invisible (zero height) but still registers
  /// itself for scroll-position tracking.
  final bool visible;

  @override
  State<_InlineSectionHeader> createState() => _InlineSectionHeaderState();
}

class _InlineSectionHeaderState extends State<_InlineSectionHeader> {
  /// The current render object, or null if not yet laid out / detached.
  RenderObject? get renderObject {
    if (!mounted) return null;
    return context.findRenderObject();
  }

  @override
  void initState() {
    super.initState();
    widget.onMounted(widget.sectionIndex, this);
  }

  @override
  void dispose() {
    widget.onUnmounted(widget.sectionIndex, this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Ensure the header is registered whenever it builds. This protects against
    // the parent state losing track of it due to rebuilds.
    widget.onMounted(widget.sectionIndex, this);

    if (!widget.visible) return const SizedBox.shrink();

    return Container(
      padding: widget.padding,
      color: widget.backgroundColor,
      child: Align(
        alignment: widget.alignment,
        child: widget.section.header,
      ),
    );
  }
}
