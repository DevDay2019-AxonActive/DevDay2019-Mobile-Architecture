import 'package:books/model/user.dart';

class Device {
  int id;
  String status;
  String token;
  User user;

  Device(this.id, this.status, this.token, this.user);

  Device.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        status = json['status'],
        token = json['token'],
        user = json['user'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status,
        'token': token,
        'user': user,
      };
}
