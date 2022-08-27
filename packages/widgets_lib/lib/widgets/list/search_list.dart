import 'package:flutter/material.dart';

///```dart
///SizedBox(
///  height: MediaQuery.of(context).size.height * 0.7,
///  child: SearchList<String>(
///    textController: textController,
///    searchList: List.generate(
///      300,
///      (index) => 'name $index',
///    ),
///    searchCondition: (data, searchInput) {
///      return data
///          .toLowerCase()
///          .contains(searchInput.toLowerCase());
///    },
///    searchItemBuilder: (context, searchList, searchIndex) {
///      print(searchIndex);
///      const avatarSize = 25.0;
///      return GestureDetector(
///        onTap: () {
///          print(searchList[searchIndex]);
///        },
///        child: Text(searchList[searchIndex]),
///      );
///    },
///  ),
///),
///```
///
class SearchList<T> extends StatefulWidget {
  final List<T> searchList;
  final Widget? emptyWidget;
  final TextEditingController textController;
  final bool shrinkWrap;
  final bool Function(T data, String searchInput) searchCondition;
  final void Function(String searchInput)? onSearch;
  final Widget Function(
    BuildContext context,
    List<T> searchList,
    int searchIndex,
  ) searchItemBuilder;
  const SearchList({
    super.key,
    required this.searchList,
    this.emptyWidget,
    required this.textController,
    this.shrinkWrap = false,
    required this.searchCondition,
    this.onSearch,
    required this.searchItemBuilder,
  });

  @override
  State<SearchList<T>> createState() => _SearchListState<T>();
}

class _SearchListState<T> extends State<SearchList<T>> {
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
  void didUpdateWidget(covariant SearchList<T> oldWidget) {
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
      return widget.emptyWidget ?? const Text('Not found');
    }
    return ListView.builder(
      itemCount: _searchList.length,
      shrinkWrap: widget.shrinkWrap,
      itemBuilder: (context, index) => widget.searchItemBuilder(
        context,
        _searchList,
        index,
      ),
    );
  }

  void _onSearch(String searchInput) {
    widget.onSearch?.call(searchInput);
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
