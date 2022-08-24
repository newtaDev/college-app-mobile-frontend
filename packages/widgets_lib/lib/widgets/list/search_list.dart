import 'package:flutter/material.dart';

///```dart
///SizedBox(
///  height: MediaQuery.of(context).size.height * 0.7,
///  child: SearchList<String>(
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
///      const avatarSize = 25.0;
///      return Column(
///        children: [
///          GestureDetector(
///            onTap: () {
///              print(searchList[searchIndex]);
///            },
///            child: ProfileListViewCard(
///              emoji: '👨🏻',
///              title: 'Name: ${searchList[searchIndex]}',
///              subtitle: '191962662',
///              avatarSize: avatarSize,
///            ),
///          ),
///          const Divider(
///            indent: avatarSize * 2,
///            height: 20,
///          )
///        ],
///      );
///    },
///  ),
///),
///```
///
class SearchList<T> extends StatefulWidget {
  final List<T> searchList;
  final Widget? emptyWidget;
  final String? hintText;
  final bool shrinkWrap;
  final bool Function(T data, String searchInput) searchCondition;
  final Widget Function(
    BuildContext context,
    List<T> searchList,
    int searchIndex,
  ) searchItemBuilder;
  const SearchList({
    super.key,
    required this.searchList,
    this.emptyWidget,
    this.hintText,
    this.shrinkWrap = false,
    required this.searchItemBuilder,
    required this.searchCondition,
  });

  @override
  State<SearchList<T>> createState() => _SearchListState<T>();
}

class _SearchListState<T> extends State<SearchList<T>> {
  final ValueNotifier<List<T>> _searchList = ValueNotifier([]);
  String searchedText = '';
  @override
  void initState() {
    _searchList.value = List.from(widget.searchList);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SearchList<T> oldWidget) {
    /// Just to support hot reload  (when widget changes)
    if (oldWidget.searchList != widget.searchList) {
      _searchList.value = List.from(widget.searchList);
      _onSearch(searchedText);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: _onSearch,
          decoration: InputDecoration(
            hintText: widget.hintText ?? 'Search...',
            prefixIcon: const Icon(Icons.search),
          ),
        ),
        const SizedBox(height: 20),
        if (widget.shrinkWrap) _buildSearchList(),
        if (!widget.shrinkWrap)
          Expanded(
            child: _buildSearchList(),
          )
      ],
    );
  }

  ValueListenableBuilder<List<T>> _buildSearchList() {
    return ValueListenableBuilder<List<T>>(
      valueListenable: _searchList,
      builder: (context, searchedList, child) {
        if (searchedList.isEmpty) {
          /// Empty Widget will not build every time
          return child!;
        }
        return ListView.builder(
          itemCount: searchedList.length,
          shrinkWrap: widget.shrinkWrap,
          itemBuilder: (context, index) => widget.searchItemBuilder(
            context,
            searchedList,
            index,
          ),
        );
      },
      child: widget.emptyWidget ?? const Text('Not found'),
    );
  }

  void _onSearch(String searchInput) {
    searchedText = searchInput;
    if (searchedText.isEmpty) {
      _searchList.value = widget.searchList;
      return;
    }
    _searchList.value = widget.searchList
        .where((data) => widget.searchCondition(data, searchInput))
        .toList();
  }
}
