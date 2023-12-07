import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trabalho_faculdade/infrastructure/domain/entities/training.dart';
import 'package:trabalho_faculdade/infrastructure/domain/entities/user.dart';

class ResultTrainingController {

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
        if (!obj.lastRoundCompleted) {
          obj.timeBy100.removeLast();
        }
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

      trainings.clear();
      trainings.addAll(listByData);
    }
  }

  final TextEditingController controllerDateInit = TextEditingController(text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  final TextEditingController controllerDateFinish = TextEditingController(text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  final TextEditingController controllerAthlete = TextEditingController();
  String idUser = "";
  List<TrainingModel> trainings = [];
}