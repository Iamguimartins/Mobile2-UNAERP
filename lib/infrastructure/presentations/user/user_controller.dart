import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trabalho_faculdade/infrastructure/domain/entities/user.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/shared/widgets/toast/toast_message.dart';
import 'package:trabalho_faculdade/utils/firebase_errors.dart';
import 'package:trabalho_faculdade/utils/util.dart';

class UserController {
  init() async {
    isUpdate = false;
    isLoading = false;
    _typeUser = '';
    userID = '';
    errors.clear();
    controllerName.clear();
    controllerEmail.clear();
    controllerPassword.clear();
  }

  String get typeUser => _typeUser;

  set typeUser(String value) {
    _typeUser = value;
  }

  Future<bool> saveUser() async {
    bool res = false;

    try {
      errors.clear();

      if (controllerName.text.isEmpty) {
        errors.add('name');
      }

      if ((controllerEmail.text.isEmpty ||
              !Util().validateEmail(controllerEmail.text)) &&
          !isUpdate) {
        errors.add('email');
      }

      if ((controllerPassword.text.isEmpty ||
              controllerPassword.text.length <= 5) &&
          !isUpdate) {
        errors.add('password');
      }

      if (errors.isNotEmpty) {
        showToast("Campos em branco ou com valores inválidos");
      } else if (typeUser == '') {
        showToast("Informe o tipo de usuário");
      } else {
        if (!isUpdate) {
          final UserCredential result = await auth
              .createUserWithEmailAndPassword(
                  email: controllerEmail.text,
                  password: controllerPassword.text)
              .catchError((e) {
            showToast(getErrorString(e.code));
          });

          userID = result.user!.uid;
        }

        UserModel user = UserModel(
            userID: userID,
            name: controllerName.text,
            email: controllerEmail.text,
            password: controllerPassword.text,
            type: typeUser,
            active: true);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.userID)
            .set(user.toMap());

        showToast("Usuário salvo com sucesso");
        res = true;
      }
    } catch (_) {
      res = false;
    }

    return res;
  }

  Future<bool> deleteUser() async {
    bool res = false;

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .update({'active': false});

      res = true;
    } catch (_) {
      res = false;
    }

    return res;
  }

  Future<void> setUser(UserModel user) async {
    isUpdate = true;
    userID = user.userID;

    controllerName.text = user.name;
    controllerEmail.text = user.email;
    _typeUser = user.type;
  }


  Future<void> getData(UserModel user) async {
    users.clear();
    var res = await FirebaseFirestore.instance
        .collection('users')
        .where('active', isEqualTo: true)
        .get();

    var docs = res.docs;

    for (var doc in docs) {
      var obj = UserModel.fromSnapshot(doc);
      users.add(obj);
    }
  }

  List<UserModel> users = [];
  bool isUpdate = false;
  bool isLoading = false;
  String userID = '';
  String _typeUser = '';
  List<String> errors = [];

  final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
}
