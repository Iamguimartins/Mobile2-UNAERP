import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trabalho_faculdade/infrastructure/domain/entities/athlete.dart';
import 'package:trabalho_faculdade/infrastructure/domain/entities/chart_section.dart';
import 'package:trabalho_faculdade/infrastructure/domain/entities/training.dart';
import 'package:trabalho_faculdade/infrastructure/domain/entities/user.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/athlete/athlete_controller.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/sel_object/selected_user_controller.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/user/user_controller.dart';

class AnalizeTrainingController {

  void setAthlete(UserModel user) {
    controllerAthlete.text = user.name;
    idUser = user.userID;
  }

  Future<void> getData() async {
    if (controllerDateInit.text.isNotEmpty && controllerDateFinish.text.isNotEmpty) {

      trainings.clear();

      var res = await FirebaseFirestore.instance.collection('training').get();
      var docs = res.docs;

      for (var doc in docs) {
        var obj =  TrainingModel.fromSnapshot(doc);
        trainings.add(obj);
      }
      List<TrainingModel> listByData = [];
      List<String> splitDateTimeInit = controllerDateInit.text.split('/');
      List<String> splitDateTimeFinish = controllerDateFinish.text.split('/');

      DateTime dtInit = DateTime(int.parse(splitDateTimeInit[2]), int.parse(splitDateTimeInit[1]), int.parse(splitDateTimeInit[0]));
      DateTime dtFinish = DateTime(int.parse(splitDateTimeFinish[2]), int.parse(splitDateTimeFinish[1]), int.parse(splitDateTimeFinish[0]));


      for (var training in trainings) {
        List<String> splitDateTimeTraining = training.date!.split('/');
        DateTime dateTraining = DateTime(int.parse(splitDateTimeTraining[2]), int.parse(splitDateTimeTraining[1]), int.parse(splitDateTimeTraining[0]));

        if (dateTraining.difference(dtInit).inDays >= 0 && dateTraining.difference(dtFinish).inDays <= 0) {
          listByData.add(training);
        }
      }

      trainings.clear();
      trainings.addAll(listByData);

      if (idUser.isNotEmpty) {
        List<TrainingModel> listByUser = [];
        for (var training in trainings) {
          if (training.athlete.userID == idUser) {
            listByUser.add(training);
          }
        }

        trainings.clear();
        trainings.addAll(listByUser);
      }

      if (selectedStyle != 'Todos') {
        List<TrainingModel> traningsByStyle = trainings.where((e) => e.style == selectedStyle).toList();
        trainings.clear();
        trainings.addAll(traningsByStyle);
      }

      if (selectedCategory != 'Todos') {
        List<TrainingModel> traningsByCategory = trainings.where((e) => e.category == selectedCategory).toList();
        trainings.clear();
        trainings.addAll(traningsByCategory);
      }

      if (selectedSex != 'Todos') {
        SelectedUserController selectedUserController = SelectedUserController();
        List<AthleteModel> athletes = await selectedUserController.getAthletesBySex(selectedSex);
        List<TrainingModel> trainingsByUser = [];
        List<TrainingModel> trainingsByUserSex = [];

        for (var athlete in athletes) {
          trainingsByUser = trainings.where((e) => e.athlete.userID == athlete.user.userID).toList();
          trainingsByUserSex.addAll(trainingsByUser);
        }

        trainings.clear();
        trainings.addAll(trainingsByUserSex);
      }
    }

    await setTrainingByUser();
  }

  Future<void> setTrainingByUser() async {
    trainingByUser.clear();

    if (idUser == "") {
      SelectedUserController selectedUserController = SelectedUserController();
      List<UserModel> athletes = await selectedUserController.getAllAthletes();

      for (var a in athletes) {
        trainingByUser.add(ChartSection(title: a.name, value: trainings.where((e) => e.athlete.userID == a.userID).length.toDouble()));
      }
    } else {
      trainingByUser.add(ChartSection(title: controllerAthlete.text, value: trainings.length.toDouble()));
    }

  }

  final TextEditingController controllerDateInit = TextEditingController(text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  final TextEditingController controllerDateFinish = TextEditingController(text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  final TextEditingController controllerAthlete = TextEditingController();
  String idUser = "";
  bool isLoading = false;
  String selectedStyle = 'Todos';
  String selectedCategory = 'Todos';
  String selectedSex = 'Todos';
  List<TrainingModel> trainings = [];
  List<ChartSection> trainingByUser = [];

}