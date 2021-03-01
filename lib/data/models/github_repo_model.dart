class GithubRepo {
  String name;
  DateTime createdAt;
  int forkCount;
  int stargazerCount;

  GithubRepo({
    this.name,
    this.createdAt,
    this.forkCount,
    this.stargazerCount,
  });

  factory GithubRepo.fromJson(Map<String, dynamic> json) => GithubRepo(
        name: json["name"],
        createdAt: DateTime.parse(json["createdAt"]),
        forkCount: json["forkCount"],
        stargazerCount: json["stargazerCount"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "createdAt": createdAt.toIso8601String(),
        "forkCount": forkCount,
        "stars": stargazerCount,
      };
}
