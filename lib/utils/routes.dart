import 'package:flutter/material.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/analize_training.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/auth_view.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/evaluative_training_view.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/home_page/home_page_view.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/new_user_view.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/recover_password_view.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/result_training.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/selected_athlete.dart';

class Routes {
  static const authView = '/authView';
  static const newUserView = 'newUserView';
  static const recoverPassword = 'recoverPassword';
  static const homePage = 'homePage';
  static const evaluativeTraining = 'evaluativeTraining';
  static const selAthlete = 'selAthlete';
  static const resultTraining = 'resultTraining';
  static const analizeTraining = 'analizeTraining';

  static final routes = <String, Widget Function(BuildContext)>{
    authView: (_) => const AuthView(),
    newUserView: (_) => const NewUserView(),
    recoverPassword: (_) => const RecoverPasswordView(),
    homePage: (_) => const HomePageView(),
    evaluativeTraining: (_) => EvaluativeTrainingView(),
    selAthlete: (_) => const SelAthlete(),
    resultTraining: (_) => ResultTraining(),
    analizeTraining: (_) => AnalizeTraining(),
  };
}