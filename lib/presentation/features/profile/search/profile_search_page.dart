import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:widgets_lib/widgets/cards/src/profile_listview_card.dart';
import 'package:widgets_lib/widgets/common/loading_indicator.dart';

import '../../../../utils/utils.dart';
import '../../../router/routes.dart';
import 'cubit/search_user_profile_cubit.dart';

class ProfileSearchPage extends StatefulWidget {
  const ProfileSearchPage({super.key});

  @override
  State<ProfileSearchPage> createState() => _ProfileSearchPageState();
}

class _ProfileSearchPageState extends State<ProfileSearchPage> {
  late final FocusNode focusNode;
  @override
  void initState() {
    focusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future<void>.delayed(const Duration(milliseconds: 300)).then((value) {
        if (mounted) focusNode.requestFocus();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  final searchDebouncer = Debouncer(delay: const Duration(seconds: 1));
  String? searchText;
  String? lastSearchedText;
  @override
  Widget build(BuildContext context) {
    final searchCubit = context.read<SearchUserProfileCubit>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Hero(
          tag: 'home-search-tag',
          child: Material(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 10, top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        focusNode: focusNode,
                        decoration: const InputDecoration(
                          hintText: 'Search...',
                          prefixIcon: Icon(Icons.search),
                        ),
                        onChanged: (value) {
                          if (value.isEmpty ||
                              searchText == value ||
                              lastSearchedText == value) {
                            searchDebouncer.dispose();
                            searchText = value;
                            return;
                          }
                          searchText = value;
                          searchDebouncer.run(
                            () async {
                              await searchCubit.searchUserProfiles(
                                searchText: value,
                              );
                              lastSearchedText = value;
                            },
                          );
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: context.pop,
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<SearchUserProfileCubit, SearchUserProfileState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          if (state.status.isInitial) return const SizedBox();
          if (state.status.isLoading) {
            return const SizedBox(height: 200, child: LoadingIndicator());
          }

          if (state.searchResults.isEmpty || state.status.isError) {
            return const SizedBox(
                height: 200, child: Center(child: Text('No results found')));
          }
          return Padding(
            padding: const EdgeInsets.only(top: 5),
            child: ListView.separated(
              itemCount: state.searchResults.length,
              padding: const EdgeInsets.all(20),
              separatorBuilder: (context, index) => const Divider(indent: 50),
              itemBuilder: (context, index) {
                final user = state.searchResults[index];
                return InkWell(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    context.pushNamed(
                      Routes.profileScreen.name,
                      params: {
                        'profile_id': user.id,
                        ...RouteParams.withDashboard
                      },
                      queryParams: {'userType': user.userType.value},
                    );
                  },
                  child: ProfileListViewCard(
                    emoji: user.emoji ?? '🔍',
                    title: user.name,
                    subtitle: user.username,
                    avatarSize: 25,
                    emojiSize: 20,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
