import 'package:flutter/material.dart';

///```dart
/// SearchSliverList<String>(
///   textController: textController2,
///   searchList: List.generate(
///     300,
///     (index) => 'name $index',
///   ),
///   searchCondition: (data, searchInput) {
///     return data.toLowerCase().contains(searchInput.toLowerCase());
///   },
///   searchItemBuilder: (context, searchList, searchIndex) {
///     print(searchIndex);
///     const avatarSize = 25.0;
///     return GestureDetector(
///       onTap: () {
///         print(searchList[searchIndex]);
///       },
///       child: Text(searchList[searchIndex]),
///     );
///   },
/// ),
/// ```
class SliverSearchList<T> extends StatefulWidget {
  final List<T> searchList;
  final Widget? emptyWidget;
  final TextEditingController textController;
  final bool shrinkWrap;
  final bool Function(T data, String searchInput) searchCondition;
  final Widget Function(
    BuildContext context,
    List<T> searchList,
    int searchIndex,
  ) searchItemBuilder;
  const SliverSearchList({
    super.key,
    required this.searchList,
    this.emptyWidget,
    this.shrinkWrap = false,
    required this.searchItemBuilder,
    required this.searchCondition,
    required this.textController,
  });

  @override
  State<SliverSearchList<T>> createState() => _SliverSearchListState<T>();
}

class _SliverSearchListState<T> extends State<SliverSearchList<T>> {
  List<T> _searchList = [];
  @override
  void initState() {
    _searchList = List.from(widget.searchList);
    widget.textController.addListener(_textFieldListner);
    _onSearch(widget.textController.text);
    super.initState();
  }

  @override
  void dispose() {
    widget.textController.removeListener(_textFieldListner);
    super.dispose();
  }

  void _textFieldListner() => _onSearch(widget.textController.text);

  @override
  void didUpdateWidget(covariant SliverSearchList<T> oldWidget) {
    /// Just to support hot reload  (when widget changes)
    if (oldWidget.searchList != widget.searchList) {
      _searchList = List.from(widget.searchList);
      _onSearch(widget.textController.text);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (_searchList.isEmpty) {
      return SliverList(
        delegate: SliverChildListDelegate(
          [widget.emptyWidget ?? const Center(child: Text('No Results'))],
        ),
      );
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: _searchList.length,
        (context, index) => widget.searchItemBuilder(
          context,
          _searchList,
          index,
        ),
      ),
    );
  }

  void _onSearch(String searchInput) {
    if (searchInput.isEmpty) {
      _searchList = widget.searchList;
      setState(() {});
      return;
    }
    _searchList = widget.searchList
        .where((data) => widget.searchCondition(data, searchInput))
        .toList();
    setState(() {});
  }
}
