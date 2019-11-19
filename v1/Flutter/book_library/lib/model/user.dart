import 'dart:convert';

import 'package:book_library/model/device.dart';

class Subscriber {
    List<Device> devices;
    String email;
    String fullName;
    int id;

    Subscriber({
        this.devices,
        this.email,
        this.fullName,
        this.id,
    });

    factory Subscriber.fromRawJson(String str) => Subscriber.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Subscriber.fromJson(Map<String, dynamic> json) => Subscriber(
        devices: json["devices"] == null ? null : List<Device>.from(json["devices"].map((x) => Device.fromJson(x))),
        email: json["email"] == null ? null : json["email"],
        fullName: json["fullName"] == null ? null : json["fullName"],
        id: json["id"] == null ? null : json["id"],
    );

    Map<String, dynamic> toJson() => {
        "devices": devices == null ? null : List<dynamic>.from(devices.map((x) => x.toJson())),
        "email": email == null ? null : email,
        "fullName": fullName == null ? null : fullName,
        "id": id == null ? null : id,
    };
}