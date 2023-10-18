class UserModel {
  String userID;
  String name;
  String email;
  String password;
  String type;

  UserModel({
    required this.userID,
    required this.name,
    required this.email,
    required this.password,
    required this.type,
  });

  UserModel.fromMap(Map<String, dynamic> map)
      : userID = map['userID'],
        name = map['name'],
        email = map['email'],
        password = map['password'],
        type = map['type'];

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'type': type,
    };
  }
}
