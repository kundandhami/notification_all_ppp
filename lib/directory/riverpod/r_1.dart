import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class R1 extends ConsumerWidget {
  const R1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("stateNotifierProvider"),
      ),
      body: ref.watch(dataPost).when(
            data: (data) {
              return ListView.separated(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Text(
                      data[index].userId.toString(),
                    ),
                    title: Text(data[index].title),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: 10,
                ),
              );
            },
            error: (error, stackTrace) {
              return Text(
                error.toString(),
              );
            },
            loading: () => CircularProgressIndicator(),
          ),
    );
  }
}

final dataPost = FutureProvider((ref) {
  final a = ref.watch(statenotifierProvider.notifier);
  return a.getData();
});

final statenotifierProvider =
    StateNotifierProvider<PostsNetwork, bool>((ref) => PostsNetwork());

class PostsNetwork extends StateNotifier<bool> {
  PostsNetwork() : super(false);

  Future<List<Welcome>> getData() async {
    List<Welcome> post = [];
    try {
      final res = await http
          .get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));

      if (res.statusCode == 200) {
        post = welcomeFromJson(res.body);
      }
    } catch (e) {
      throw Exception(e);
    }
    return post;
  }
}

List<Welcome> welcomeFromJson(String str) =>
    List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

String welcomeToJson(List<Welcome> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Welcome {
  int userId;
  int id;
  String title;
  String body;

  Welcome({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };
}
