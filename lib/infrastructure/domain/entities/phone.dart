class PhoneModel {
  String phone;
  String type;

  PhoneModel({required this.phone, required this.type});

  factory PhoneModel.fromMap(Map<String, dynamic> map) {
    return PhoneModel(
      phone: map['phone'],
      type: map['type'],
    );
  }

  factory PhoneModel.fromJson(Map<String, dynamic> json) {
    return PhoneModel(
      phone: json['phone'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'type': type,
    };
  }
}