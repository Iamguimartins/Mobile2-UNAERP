import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trabalho_faculdade/infrastructure/domain/entities/user.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/shared/widgets/toast/toast_message.dart';
import 'package:trabalho_faculdade/utils/firebase_errors.dart';
import 'package:trabalho_faculdade/utils/pref.dart';
import 'package:trabalho_faculdade/utils/util.dart';

class AuthController {

  void init() {
    isLoading = false;
    errors.clear();
  }


  bool get rememberPassword => _rememberPassword;

  set rememberPassword(bool value) {
    _rememberPassword = value;
  }

  Future<bool> onLogin() async {
    bool res = false;

    try {
      isLoading = true;
      errors.clear();

      if (controllerEmail.text.isEmpty || !Util().validateEmail(controllerEmail.text)) {
        errors.add('email');
      }

      if (controllerPassword.text.isEmpty) {
        errors.add('password');
      }

      if (errors.isNotEmpty) {
        showToast("Campos em branco ou com valor inválido");

      } else {
        final UserCredential result = await auth.signInWithEmailAndPassword(email: controllerEmail.text, password: controllerPassword.text).catchError((e) async {
          showToast(getErrorString(e.code));
          return false;
        });
        await _loadCurrentUser(firebaseUser: result.user!);
        res = true;
      }
    } catch (_) {
      res = false;
    } finally {
      isLoading = false;
    }

    return res;
  }

  Future<void> _loadCurrentUser({User? firebaseUser}) async {
    final User? currentUser = firebaseUser ?? auth.currentUser;

    if(currentUser != null) {
      final DocumentSnapshot docUser = await firestore.collection('users').doc(currentUser.uid).get();

      if (docUser.exists) {
        UserModel user = UserModel.fromSnapshot(docUser);
        await Pref.saveUser(user!);
      }
    }
  }

  bool isLoading = false;
  bool _rememberPassword = false;
  List<String> errors = [];
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
}