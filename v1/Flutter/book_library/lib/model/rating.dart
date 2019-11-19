import 'dart:convert';

import 'package:book_library/model/user.dart';

class Rating {
    int id;
    Subscriber user;
    int value;

    Rating({
        this.id,
        this.user,
        this.value,
    });

    factory Rating.fromRawJson(String str) => Rating.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        id: json["id"] == null ? null : json["id"],
        user: json["user"] == null ? null : Subscriber.fromJson(json["user"]),
        value: json["value"] == null ? null : json["value"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user": user == null ? null : user.toJson(),
        "value": value == null ? null : value,
    };
}
