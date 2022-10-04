part of 'search_user_profile_cubit.dart';

enum SearchUserProfileStatus { initial, loading, success, error }

extension SearchUserProfileStatusX on SearchUserProfileStatus {
  bool get isInitial => this == SearchUserProfileStatus.initial;
  bool get isSuccess => this == SearchUserProfileStatus.success;
  bool get isError => this == SearchUserProfileStatus.error;
  bool get isLoading => this == SearchUserProfileStatus.loading;
}

class SearchUserProfileState extends MyEquatable {
  final List<AnonymousUser> searchResults;
  final SearchUserProfileStatus status;
  final ApiErrorRes? error;

  const SearchUserProfileState({
    required this.searchResults,
    required this.status,
    this.error,
  });
  const SearchUserProfileState.init()
      : status = SearchUserProfileStatus.initial,
        error = null,
        searchResults = const [];

  @override
  List<Object?> get props => [searchResults, status, error];

  SearchUserProfileState copyWith({
    List<AnonymousUser>? searchResults,
    SearchUserProfileStatus? status,
    ApiErrorRes? error,
  }) {
    return SearchUserProfileState(
      searchResults: searchResults ?? this.searchResults,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
