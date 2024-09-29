/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

LastExample lastExampleFromJson(String str) => LastExample.fromJson(json.decode(str));

String lastExampleToJson(LastExample data) => json.encode(data.toJson());

class LastExample {
    LastExample({
        required this.perPage,
        required this.total,
        required this.data,
        required this.page,
        required this.totalPages,
        required this.support,
    });

    int perPage;
    int total;
    List<Datum> data;
    int page;
    int totalPages;
    Support support;

    factory LastExample.fromJson(Map<dynamic, dynamic> json) => LastExample(
        perPage: json["per_page"],
        total: json["total"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        page: json["page"],
        totalPages: json["total_pages"],
        support: Support.fromJson(json["support"]),
    );

    Map<dynamic, dynamic> toJson() => {
        "per_page": perPage,
        "total": total,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "page": page,
        "total_pages": totalPages,
        "support": support.toJson(),
    };
}

class Datum {
    Datum({
        required this.lastName,
        required this.id,
        required this.avatar,
        required this.firstName,
        required this.email,
    });

    String lastName;
    int id;
    String avatar;
    String firstName;
    String email;

    factory Datum.fromJson(Map<dynamic, dynamic> json) => Datum(
        lastName: json["last_name"],
        id: json["id"],
        avatar: json["avatar"],
        firstName: json["first_name"],
        email: json["email"],
    );

    Map<dynamic, dynamic> toJson() => {
        "last_name": lastName,
        "id": id,
        "avatar": avatar,
        "first_name": firstName,
        "email": email,
    };
}

class Support {
    Support({
        required this.text,
        required this.url,
    });

    String text;
    String url;

    factory Support.fromJson(Map<dynamic, dynamic> json) => Support(
        text: json["text"],
        url: json["url"],
    );

    Map<dynamic, dynamic> toJson() => {
        "text": text,
        "url": url,
    };
}
