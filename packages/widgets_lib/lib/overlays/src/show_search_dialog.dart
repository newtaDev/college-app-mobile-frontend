import 'package:flutter/material.dart';

import '../../widgets/list/search_list.dart';

class ShowSearchDialog<T> extends StatefulWidget {
  final List<T> searchList;
  final Widget? emptyWidget;
  final Widget Function(
    BuildContext context,
    List<T> searchList,
    int searchIndex,
  ) searchItemBuilder;
  final bool Function(T data, String searchInput) searchCondition;
  const ShowSearchDialog({
    super.key,
    required this.searchItemBuilder,
    required this.searchList,
    this.emptyWidget,
    required this.searchCondition,
  });

  @override
  State<ShowSearchDialog<T>> createState() => _ShowSearchDialogState<T>();
}

class _ShowSearchDialogState<T> extends State<ShowSearchDialog<T>> {
  late TextEditingController searchTextCtr;

  @override
  void initState() {
    searchTextCtr = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: searchTextCtr,
              decoration: const InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SearchList<T>(
                textController: searchTextCtr,
                searchList: widget.searchList,
                emptyWidget: widget.emptyWidget,
                searchCondition: widget.searchCondition,
                searchItemBuilder: widget.searchItemBuilder,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
