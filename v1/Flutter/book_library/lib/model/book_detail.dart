import 'dart:convert';

import 'package:book_library/model/comment.dart';
import 'package:book_library/model/rating.dart';
import 'package:book_library/model/tag.dart';

enum SourceEnum {
  AAHCM,
  AACT,
  AADN,
  AAYG,
  PANMAC,
  OPEN_LIBRARY,
  BOOK_MOOCH,
  IT_BOOK_STORE,
  UNKNOWN
}

class Detail {
  List<Comment> comments;
  String coverUrl;
  String description;
  int id;
  List<Rating> ratings;
  String source;
  List<Tag> tags;

  Detail({
    this.comments,
    this.coverUrl,
    this.description,
    this.id,
    this.ratings,
    this.source,
    this.tags,
  });

  factory Detail.fromRawJson(String str) => Detail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        comments: json["comments"] == null
            ? null
            : List<Comment>.from(
                json["comments"].map((x) => Comment.fromJson(x))),
        coverUrl: json["coverUrl"] == null ? null : json["coverUrl"],
        description: json["description"] == null ? null : json["description"],
        id: json["id"] == null ? null : json["id"],
        ratings: json["ratings"] == null
            ? null
            : List<Rating>.from(json["ratings"].map((x) => Rating.fromJson(x))),
        source: json["source"] == null ? null : json["source"],
        tags: json["tags"] == null
            ? null
            : List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "comments": comments == null
            ? null
            : List<dynamic>.from(comments.map((x) => x.toJson())),
        "coverUrl": coverUrl == null ? null : coverUrl,
        "description": description == null ? null : description,
        "id": id == null ? null : id,
        "ratings": ratings == null
            ? null
            : List<dynamic>.from(ratings.map((x) => x.toJson())),
        "source": source == null ? null : source,
        "tags": tags == null
            ? null
            : List<dynamic>.from(tags.map((x) => x.toJson())),
      };
}
