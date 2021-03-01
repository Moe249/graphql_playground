import 'package:graphql/client.dart';
import 'package:graphql_playground/utils/constants.dart';

final HttpLink _httpLink = HttpLink(
  'https://api.github.com/graphql',
);

final AuthLink _authLink = AuthLink(
  getToken: () async => 'Bearer ${Constants.GITHUB_TOKEN}',
);

Link _link = _authLink.concat(_httpLink);

GraphQLClient _client;

GraphQLClient getGraphQLClient() {
  _client = GraphQLClient(
    cache: GraphQLCache(),
    link: _link,
  );

  return _client;
}
