import 'dart:convert';

import 'package:book_library/model/book_detail.dart';
import 'package:book_library/model/user.dart';

class Book {
    String author;
    List<Detail> details;
    int id;
    String name;
    String serialNumber;
    List<Subscriber> subscribers;

    Book({
        this.author,
        this.details,
        this.id,
        this.name,
        this.serialNumber,
        this.subscribers,
    });

    factory Book.fromRawJson(String str) => Book.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Book.fromJson(Map<String, dynamic> json) => Book(
        author: json["author"] == null ? null : json["author"],
        details: json["details"] == null ? null : List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        serialNumber: json["serialNumber"] == null ? null : json["serialNumber"],
        subscribers: json["subscribers"] == null ? null : List<Subscriber>.from(json["subscribers"].map((x) => Subscriber.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "author": author == null ? null : author,
        "details": details == null ? null : List<dynamic>.from(details.map((x) => x.toJson())),
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "serialNumber": serialNumber == null ? null : serialNumber,
        "subscribers": subscribers == null ? null : List<dynamic>.from(subscribers.map((x) => x.toJson())),
    };
}