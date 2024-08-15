import 'dart:convert';

import 'package:posts_infinitescroll/domain/entity/post.dart';
import 'package:http/http.dart' as http;

class PostsApi {
  static Future<List<Post>> getPosts(
      {int startIndex = 0, int limit = 20}) async {
    try {
      String url =
          "https://jsonplaceholder.typicode.com/posts?_start=$startIndex&_limit=$limit";
      var response = await http.get(Uri.parse(url));

      final List decodedJson = json.decode(response.body) as List;
      List<Post> posts = decodedJson
          .map<Post>((jsonPostModel) => Post.fromJson(jsonPostModel))
          .toList();

      return posts;
    } catch (e) {
      rethrow;
    }
  }
}
