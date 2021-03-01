import 'package:graphql/client.dart';
import 'package:graphql_playground/data/models/github_repo_model.dart';
import 'package:graphql_playground/services/networking/graphql_client.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final gitHubRepoRepositoryProvider =
    Provider<GitHubRepoRepository>((_) => GitHubRepoRepository());

class GitHubRepoRepository {
  Future<List<GithubRepo>> getCurrentUserRepos({int last = 50}) {
    return getGraphQLClient().query(_queryOptions(last)).then(_toGitHubRepo);
  }

  QueryOptions _queryOptions(int nRepos) {
    return QueryOptions(
      document: gql(readRepositories),
      variables: <String, dynamic>{
        'nRepositories': nRepos,
      },
    );
  }

  List<GithubRepo> _toGitHubRepo(QueryResult queryResult) {
    if (queryResult.hasException) {
      print(queryResult.exception.toString());
      throw Exception();
    }

    final list =
        queryResult.data['viewer']['repositories']['nodes'] as List<dynamic>;

    return list.map((repoJson) => GithubRepo.fromJson(repoJson)).toList();
  }
}

const String readRepositories = r'''
  query ReadRepositories($nRepositories: Int!) {
    viewer {
      repositories(last: $nRepositories) {
        nodes {
          name
          createdAt
          forkCount
          stargazerCount
        }
      }
    }
  }
''';
