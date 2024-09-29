/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

PostsModel postsModelFromJson(String str) => PostsModel.fromJson(json.decode(str));

String postsModelToJson(PostsModel data) => json.encode(data.toJson());

class PostsModel {
    PostsModel({
        required this.name,
        required this.postId,
        required this.id,
        required this.body,
        required this.email,
    });

    String name;
    int postId;
    int id;
    String body;
    String email;

    factory PostsModel.fromJson(Map<dynamic, dynamic> json) => PostsModel(
        name: json["name"],
        postId: json["postId"],
        id: json["id"],
        body: json["body"],
        email: json["email"],
    );

    Map<dynamic, dynamic> toJson() => {
        "name": name,
        "postId": postId,
        "id": id,
        "body": body,
        "email": email,
    };
}
