import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_playground/utils/helpers.dart';
import 'package:graphql_playground/views/home/home_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GraphQL Playground"),
      ),
      body: ReposList(),
    );
  }
}

class ReposList extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final reposListState = useProvider(homeStateNotifierProvider.state);
    return RefreshIndicator(
      onRefresh: () async {
        context
            .read(homeStateNotifierProvider)
            .retrieveRepos(isRefreshing: true);
      },
      child: reposListState.when(
        data: (repos) => repos.isEmpty
            ? Center(
                child: Text("No Repos!"),
              )
            : ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Text(repos[index].name),
                    trailing: Text(
                      DateFormat('yMMMd').format(repos[index].createdAt),
                    ),
                    onTap: () =>
                        showStarsToast(repos[index].stargazerCount, context),
                    onLongPress: () =>
                        showStarsToast(repos[index].stargazerCount, context),
                  );
                },
                itemCount: repos.length,
              ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, _) => Text("$error"),
      ),
    );
  }
}
