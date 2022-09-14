import 'package:online_last_bloc/data/data_provider/network_service.dart';

import '../data/model/post_model.dart';

class PostRepository {
  late Network networkProvider;

  PostRepository._() {
    networkProvider = Network.instance;
  }

  static final instance = PostRepository._();

  Future<List<Post>> apiPostList() async {
    List<Post> items = [];
    List? response = await networkProvider.GET(
        networkProvider.API_LIST, networkProvider.paramsEmpty());
    if (response != null) {
      items = response.map((e) => Post.fromJson(e)).toList();
    } else {
      items = [];
    }
    return items;
  }

  Future<bool> apiPostDelete(int id) async {
    Map? response = await networkProvider.DELETE(
        networkProvider.API_DELETE + id.toString(),
        networkProvider.paramsEmpty());
    return response != null;
  }

  Future<bool> createPost(String title, String body, int userId) async {
    Map<String, dynamic> json = {
      "title": title,
      "body": body,
      "userId": userId,
    };
    Map? response =
        await networkProvider.POST(networkProvider.API_CREATE, json);
    return response != null;
  }
  Future<bool> updatePost(String title, String body, int id) async {
    Map<String, dynamic> json = {
      "title": title,
      "body": body,
    };
    Map? response =
    await networkProvider.PUT('${networkProvider.API_UPDATE}$id', json);
    return response != null;
  }


}
