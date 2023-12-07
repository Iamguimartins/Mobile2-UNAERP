import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trabalho_faculdade/infrastructure/domain/entities/phone.dart';
import 'package:trabalho_faculdade/infrastructure/domain/entities/user.dart';

class AthleteModel {
  UserModel user;
  String birthDate;
  String placeOfBirth;
  String nationality;
  String rg;
  String cpf;
  String sex;
  String fullAddress;
  String nameMother;
  String nameFather;
  String originClub;
  String localWork;
  String medicalInsurance;
  String urlMedicalCertificate;
  String urlFileRg;
  String urlFileCPf;
  String urlProofOfAddress;
  String urlPhoto3X4;
  String urlRegulation;
  List<String> allergies;
  List<String> styles;
  List<String> categories;
  List<PhoneModel> phones;
  bool active;
  bool validate;

  AthleteModel({
    required this.user,
    required this.birthDate,
    required this.placeOfBirth,
    required this.nationality,
    required this.rg,
    required this.cpf,
    required this.sex,
    required this.fullAddress,
    required this.nameMother,
    required this.nameFather,
    required this.originClub,
    required this.localWork,
    required this.medicalInsurance,
    required this.allergies,
    required this.styles,
    required this.categories,
    required this.phones,
    required this.urlMedicalCertificate,
    required this.urlFileRg,
    required this.urlFileCPf,
    required this.urlProofOfAddress,
    required this.urlPhoto3X4,
    required this.urlRegulation,
    required this.active,
    required this.validate
  });

  factory AthleteModel.fromSnapshot(DocumentSnapshot snapshot) {
    return AthleteModel(
        user: UserModel.fromJson(snapshot["user"]),
        birthDate: snapshot["birthDate"],
        placeOfBirth: snapshot["placeOfBirth"],
        nationality: snapshot["nationality"],
        rg: snapshot["rg"],
        cpf: snapshot["cpf"],
        sex: snapshot["sex"],
        fullAddress: snapshot["fullAddress"],
        nameMother: snapshot["nameMother"],
        nameFather: snapshot["nameFather"],
        originClub: snapshot["originClub"],
        localWork: snapshot["localWork"],
        medicalInsurance: snapshot["medicalInsurance"],
        allergies: List<String>.from(snapshot['allergies'] ?? []),
        styles: List<String>.from(snapshot['styles'] ?? []),
        categories: List<String>.from(snapshot['categories'] ?? []),
        phones: (snapshot['phones'] as List<dynamic>?)
            ?.map((phone) => PhoneModel.fromJson(phone))
            .toList() ??
            [],
        active: snapshot["active"],
        validate: snapshot["validate"],
        urlMedicalCertificate: snapshot["urlMedicalCertificate"],
        urlFileRg: snapshot["urlFileRg"],
        urlFileCPf: snapshot["urlFileCPf"],
        urlProofOfAddress: snapshot["urlProofOfAddress"],
        urlPhoto3X4: snapshot["urlPhoto3X4"],
        urlRegulation: snapshot["urlRegulation"]
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "user": user.toMap(),
      "birthDate": birthDate,
      "placeOfBirth": placeOfBirth,
      "nationality": nationality,
      "rg": rg,
      "cpf": cpf,
      "sex": sex,
      "fullAddress": fullAddress,
      "nameMother": nameMother,
      "nameFather": nameFather,
      "originClub": originClub,
      "localWork": localWork,
      "medicalInsurance": medicalInsurance,
      'allergies': allergies,
      'styles': styles,
      'categories': categories,
      'phones': phones.map((phone) => phone.toMap()).toList(),
      'active': active,
      'validate': validate,
      "urlMedicalCertificate": urlMedicalCertificate,
      "urlFileRg": urlFileRg,
      "urlFileCPf": urlFileCPf,
      "urlProofOfAddress": urlProofOfAddress,
      "urlPhoto3X4": urlPhoto3X4,
      "urlRegulation": urlRegulation
    };
  }
}