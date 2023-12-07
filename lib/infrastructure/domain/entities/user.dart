import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String userID;
  String name;
  String email;
  String password;
  String type;
  bool active;

  UserModel({
    required this.userID,
    required this.name,
    required this.email,
    required this.password,
    required this.type,
    required this.active
  });

  UserModel.fromMap(Map<String, dynamic> map)
      : userID = map['userID'],
        name = map['name'],
        email = map['email'],
        password = map['password'],
        type = map['type'],
        active = map['active'];

  UserModel.fromSnapshot(DocumentSnapshot snapshot)
      : userID = snapshot.id,
        name = snapshot["name"],
        email = snapshot["email"],
        password = "",
        type = snapshot["type"],
        active = snapshot["active"];

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        userID: json['userID'],
        name: json["name"],
        email: json["email"],
        password: "",
        type: json["type"],
        active: json["active"]
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'name': name,
      'email': email,
      'password': password,
      'type': type,
      'active': active
    };
  }

  bool isAdm() {
    return type == 'administrador';
  }

  bool isTrainer() {
    return type == 'treinador';
  }
}
