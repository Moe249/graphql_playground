import 'package:graphql_playground/data/models/github_repo_model.dart';
import 'package:graphql_playground/data/repositories/github_repos_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final homeStateNotifierProvider = StateNotifierProvider<HomeStateNotifier>(
  (ref) => HomeStateNotifier(read: ref.read),
);

class HomeStateNotifier extends StateNotifier<AsyncValue<List<GithubRepo>>> {
  final Reader read;
  HomeStateNotifier({this.read}) : super(AsyncValue.loading()) {
    retrieveRepos();
  }

  Future<void> retrieveRepos({bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      final repos =
          await read(gitHubRepoRepositoryProvider).getCurrentUserRepos();
      if (mounted) state = AsyncValue.data(repos);
    } catch (e) {
      print(e.toString());
    }
  }
}
