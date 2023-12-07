import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/shared/widgets/toast/toast_message.dart';

class RecoverPasswordController {

  void init() {
    isLoading = false;
    errors.clear();
  }

  Future<void> sendLink() async {
    try {
      isLoading = true;
      errors.clear();

      if (controllerEmail.text.isEmpty) {
        errors.add('email');
      }

      if (errors.isEmpty) {
        final QuerySnapshot query = await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: controllerEmail.text).get();

        if (query.docs.isEmpty) {
          showToast("Não existe usuário com esse email");
        } else {
          await FirebaseAuth.instance.sendPasswordResetEmail(email: controllerEmail.text);
          showToast("Link enviado no email");
        }
      } else {
        showToast("Preencha o email");
      }
    } catch (_) {
    } finally {
      isLoading = false;
    }
  }

  bool isLoading = false;
  List<String> errors = [];
  final TextEditingController controllerEmail = TextEditingController();
}