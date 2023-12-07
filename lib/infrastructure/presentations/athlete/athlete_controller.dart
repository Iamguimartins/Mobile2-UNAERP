import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trabalho_faculdade/infrastructure/domain/entities/athlete.dart';
import 'package:trabalho_faculdade/infrastructure/domain/entities/phone.dart';
import 'package:trabalho_faculdade/infrastructure/domain/entities/user.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/shared/widgets/toast/toast_message.dart';
import 'package:trabalho_faculdade/utils/firestore.dart';
import 'package:trabalho_faculdade/utils/util.dart';

class AthleteController {
  init() async {
    athletes.clear();
    isUpdate = false;
    isLoading = false;
    validate = false;
    errors.clear();
    allergies.clear();
    styles.clear();
    categories.clear();
    controllerUser.clear();
    controllerBirthDate.clear();
    controllerPlaceOfBirth.clear();
    controllerNationality.clear();
    controllerRg.clear();
    controllerCpf.clear();
    controllerSex.clear();
    controllerFullAddress.clear();
    controllerNameMother.clear();
    controllerNameFather.clear();
    controllerOriginClub.clear();
    controllerLocalWork.clear();
    controllerMedicalInsurance.clear();
    controllerAllergy.clear();
    phones.clear();
    phone = PhoneModel(phone: "", type: "");
    user = UserModel(userID: "", name: "", email: "", password: "", type: "", active: false);

    medicalCertificate = File("");
    fileRg = File("");
    fileCPf = File("");
    proofOfAddress = File("");
    photo3X4 = File("");
    regulation = File("");

    pathMedicalCertificate = "";
    pathFileRg = "";
    pathFileCPf = "";
    pathProofOfAddress = "";
    pathPhoto3X4 = "";
    pathRegulation = "";
  }

  Future<bool> saveUAthlete() async {
    bool res = false;
    try {
      errors.clear();

      if (controllerUser.text.isEmpty) {
        errors.add('user');
      }

      if (controllerBirthDate.text.isEmpty) {
        errors.add('birthDate');
      }

      if (controllerPlaceOfBirth.text.isEmpty) {
        errors.add('placeOfBirth');
      }

      if (controllerNationality.text.isEmpty) {
        errors.add('nationality');
      }

      if (controllerRg.text.isEmpty) {
        errors.add('rg');
      }

      if (controllerCpf.text.isEmpty ||
          !Util().validateCPF(
              controllerCpf.text.replaceAll('.', '').replaceAll('-', ''))) {
        errors.add('cpf');
      }

      if (controllerSex.text.isEmpty) {
        errors.add('sex');
      }

      if (controllerFullAddress.text.isEmpty) {
        errors.add('fullAddress');
      }

      if (controllerMedicalInsurance.text.isEmpty) {
        errors.add('medicalInsurance');
      }

      if (pathMedicalCertificate == "") {
        errors.add('medicalCertificate');
      }

      if (pathFileRg == "") {
        errors.add('fileRg');
      }

      if (pathFileCPf == "") {
        errors.add("fileCpf");
      }

      if (pathProofOfAddress == "") {
        errors.add("proofOfAddress");
      }

      if (pathPhoto3X4 == "") {
        errors.add("photo3X4");
      }

      if (pathRegulation == "") {
        errors.add("regulation");
      }

      if (errors.isNotEmpty) {
        showToast("Campos em branco ou com valores inválidos");
      } else if (phones
          .where((e) => e.type == "Celular")
          .isEmpty || phones
          .where((e) => e.type == "Emergência")
          .isEmpty) {
        showToast("Informe pelo menos um celular e um número de emergência");
      } else if (styles.isEmpty) {
        showToast("Informe ao menos um estilo");
      } else if (categories.isEmpty) {
        showToast("Informe ao menos uma prova");
      }
      else {
        AthleteModel athlete = AthleteModel(
            user: user,
            birthDate: controllerBirthDate.text,
            placeOfBirth: controllerPlaceOfBirth.text,
            nationality: controllerNationality.text,
            cpf: controllerCpf.text,
            rg: controllerRg.text,
            fullAddress: controllerFullAddress.text,
            sex: controllerSex.text,
            nameFather: controllerNameFather.text,
            nameMother: controllerNameMother.text,
            medicalInsurance: controllerMedicalInsurance.text,
            originClub: controllerOriginClub.text,
            localWork: controllerLocalWork.text,
            allergies: allergies,
            categories: categories,
            styles: styles,
            phones: phones,
            active: true,
            validate: validate,
            urlMedicalCertificate: pathMedicalCertificate.contains('https://')
                ? pathMedicalCertificate
                : await uploadFile(
                user.userID, medicalCertificate, 'medicalCertificate'),
            urlFileCPf: pathFileCPf.contains('https://')
                ? pathFileCPf
                : await uploadFile(user.userID, fileCPf, 'cpf'),
            urlFileRg: pathFileRg.contains('https://')
                ? pathFileRg
                : await uploadFile(user.userID, fileRg, 'rg'),
            urlPhoto3X4: pathPhoto3X4.contains('https://')
                ? pathPhoto3X4
                : await uploadFile(user.userID, photo3X4, 'photo3X4'),
            urlProofOfAddress: pathProofOfAddress.contains('https://')
                ? pathProofOfAddress
                : await uploadFile(user.userID, proofOfAddress, 'proofOfAddress'),
            urlRegulation: pathRegulation.contains('https://')
                ? pathRegulation
                : await uploadFile(user.userID, regulation, 'regulation'));

        await FirebaseFirestore.instance
            .collection('athletes')
            .doc(user.userID)
            .set(athlete.toMap());
        showToast("Usuário salvo com sucesso");
        res = true;
      }
    } catch (_) {
      res = false;
    }

    return res;
  }

  Future<bool> deleteAthlete() async {
    bool res = false;

    try {
      await FirebaseFirestore.instance
          .collection('athletes')
          .doc(user.userID)
          .update({'active': false});
      res = true;
    } catch (_) {
      res = false;
    }

    return res;
  }

  void setUser(UserModel userModel) {
    user = userModel;
    controllerUser.text = user.name;
  }

  void setAthlete(AthleteModel athleteModel) {
    controllerBirthDate.text = athleteModel.birthDate;
    controllerPlaceOfBirth.text = athleteModel.placeOfBirth;
    controllerNationality.text = athleteModel.nationality;
    controllerRg.text = athleteModel.rg;
    controllerCpf.text = athleteModel.cpf;
    controllerSex.text = athleteModel.sex;
    controllerFullAddress.text = athleteModel.fullAddress;
    controllerNameMother.text = athleteModel.nameMother;
    controllerNameFather.text = athleteModel.nameFather;
    controllerOriginClub.text = athleteModel.originClub;
    controllerMedicalInsurance.text = athleteModel.medicalInsurance;
    controllerLocalWork.text = athleteModel.localWork;

    allergies.clear();
    categories.clear();
    styles.clear();
    phones.clear();

    allergies.addAll(athleteModel.allergies);
    categories.addAll(athleteModel.categories);
    styles.addAll(athleteModel.styles);
    phones.addAll(athleteModel.phones);

    pathMedicalCertificate = athleteModel.urlMedicalCertificate;
    pathFileRg = athleteModel.urlFileRg;
    pathFileCPf = athleteModel.urlFileCPf;
    pathProofOfAddress = athleteModel.urlProofOfAddress;
    pathPhoto3X4 = athleteModel.urlPhoto3X4;
    pathRegulation = athleteModel.urlRegulation;

    setUser(athleteModel.user);
  }

  Future<void> setMedicalCertificate() async {
    var file = await getFile();
    if (file != null) {
      medicalCertificate = file;
      pathMedicalCertificate = medicalCertificate.path
          .split('/')
          .last;
    }
  }

  Future<void> setFileRg() async {
    var file = await getFile();
    if (file != null) {
      fileRg = file;
      pathFileRg = fileRg.path
          .split('/')
          .last;
    }
  }

  Future<void> setFileCpf() async {
    var file = await getFile();
    if (file != null) {
      fileCPf = file;
      pathFileCPf = fileCPf.path
          .split('/')
          .last;
    }
  }

  Future<void> setProofOfAddress() async {
    var file = await getFile();
    if (file != null) {
      proofOfAddress = file;
      pathProofOfAddress = proofOfAddress.path
          .split('/')
          .last;
    }
  }

  Future<void> setPhoto3X4() async {
    var file = await getFile();
    if (file != null) {
      photo3X4 = file;
      pathPhoto3X4 = photo3X4.path
          .split('/')
          .last;
    }
  }

  Future<void> setRegulation() async {
    var file = await getFile();
    if (file != null) {
      regulation = file;
      pathRegulation = regulation.path
          .split('/')
          .last;
    }
  }

  Future<void> getData(UserModel user) async {
    athletes.clear();
    var res = await FirebaseFirestore.instance
        .collection('athletes')
        .where('active', isEqualTo: true)
        .get();

    var docs = res.docs;

    for (var doc in docs) {
      var obj = AthleteModel.fromSnapshot(doc);
      athletes.add(obj);
    }
  }


  List<AthleteModel> athletes = [];
  bool isUpdate = false;
  bool isLoading = false;
  bool validate = false;
  List<String> errors = [];
  List<String> allergies = [];
  List<String> styles = [];
  List<String> categories = [];
  List<PhoneModel> phones = [];
  PhoneModel phone = PhoneModel(phone: "", type: "");
  UserModel user = UserModel(userID: "", name: "", email: "", password: "", type: "", active: false);
  final FirebaseAuth auth = FirebaseAuth.instance;

  final TextEditingController controllerUser = TextEditingController();
  final TextEditingController controllerBirthDate = TextEditingController();
  final TextEditingController controllerPlaceOfBirth = TextEditingController();
  final TextEditingController controllerNationality = TextEditingController();
  final TextEditingController controllerRg = TextEditingController();
  final TextEditingController controllerCpf = TextEditingController();
  final TextEditingController controllerSex = TextEditingController();
  final TextEditingController controllerFullAddress = TextEditingController();
  final TextEditingController controllerNameMother = TextEditingController();
  final TextEditingController controllerNameFather = TextEditingController();
  final TextEditingController controllerOriginClub = TextEditingController();
  final TextEditingController controllerLocalWork = TextEditingController();
  final TextEditingController controllerMedicalInsurance = TextEditingController();
  final TextEditingController controllerAllergy = TextEditingController();
  final TextEditingController controllerPhone = TextEditingController();

  File medicalCertificate = File("");
  File fileRg = File("");
  File fileCPf = File("");
  File proofOfAddress = File("");
  File photo3X4 = File("");
  File regulation = File("");

  String pathMedicalCertificate = "";
  String pathFileRg = "";
  String pathFileCPf = "";
  String pathProofOfAddress = "";
  String pathPhoto3X4 = "";
  String pathRegulation = "";
}
