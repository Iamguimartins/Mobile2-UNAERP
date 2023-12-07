import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:trabalho_faculdade/infrastructure/domain/entities/athlete.dart';
import 'package:trabalho_faculdade/infrastructure/domain/entities/timer.dart';
import 'package:trabalho_faculdade/infrastructure/domain/entities/training.dart';
import 'package:trabalho_faculdade/infrastructure/domain/entities/user.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/shared/widgets/toast/toast_message.dart';
import 'package:trabalho_faculdade/utils/timer.dart';
import 'package:trabalho_faculdade/utils/util.dart';

class TrainingController {
  Future<void> getData() async {
    training.clear();

    var res = await FirebaseFirestore.instance.collection('training').get();
    var docs = res.docs;

    for (var doc in docs) {
      var obj =  TrainingModel.fromSnapshot(doc);
      training.add(obj);
    }
  }

  init() async {
    idTraining = "";
    isLoading = false;
    isUpdate = false;
    lastRoundCompleted = false;
    errors.clear();
    selectedStyle = "";
    selectedCategory = "";
    athlete = UserModel(userID: "", name: "", email: "", password: "", type: "", active: false);
    controlResponsible = UserModel(userID: "", name: "", email: "", password: "", type: "", active: false);
    controllerNumber.clear();
    controllerAthlete.clear();
    controllerDate.clear();
    controllerStart.clear();
    controllerEnd.clear();
    controllerControlResponsible.clear();
    timers.clear();
    stylesAthlete.clear();
    categoriesAthlete.clear();
  }

  Future<bool> saveTraining() async {
    timerInSeconds.clear();

    bool res = false;

    try {
      errors.clear();

      if (_selectedStyle.isEmpty) {
        errors.add('style');
      }

      if (_selectedCategory.isEmpty) {
        errors.add('category');
      }

      if (controllerNumber.text.isEmpty || !Util().isInteger(controllerNumber.text)) {
        errors.add('number');
      }

      if (controllerAthlete.text.isEmpty) {
        errors.add('athlete');
      }

      if (controllerDate.text.isEmpty) {
        errors.add('date');
      }

      if (controllerStart.text.isEmpty || !Util().isDecimal(controllerStart.text)) {
        errors.add('start');
      }

      if (controllerEnd.text.isEmpty || !Util().isDecimal(controllerEnd.text)) {
        errors.add('end');
      }

      if (controllerControlResponsible.text.isEmpty) {
        errors.add('controlResponsible');
      }

      if (controllerLastRound.text.isEmpty || !Util().isDecimal(controllerLastRound.text)) {
        errors.add('lastRound');
      }

      if (errors.isNotEmpty) {
        showToast("Campos em branco ou com valores inválidos");
      } else {
        if (timers.isEmpty) {
          showToast("Tempos não informados");
        } else {

          for (var time in timers) {
            timerInSeconds.add(int.parse(getStringToTime('${time.minutes}:${time.seconds}:${time.milliseconds}')));
          }

          TrainingModel training = TrainingModel(
              id: idTraining,
              style: selectedStyle,
              category: selectedCategory,
              number: controllerNumber.text,
              athlete: athlete,
              date: controllerDate.text,
              frequencyStart: double.parse(controllerStart.text),
              frequencyEnd: double.parse(controllerEnd.text),
              controlResponsible: controlResponsible,
              lastRound: double.parse(controllerLastRound.text),
              lastRoundCompleted: lastRoundCompleted,
              timeBy100: timerInSeconds,
            active: true
          );

          if (idTraining == "") {
            await FirebaseFirestore.instance
                .collection('training')
                .add(training.toMap());
          } else {
            await FirebaseFirestore.instance
                .collection('training')
                .doc(training.id)
                .set(training.toMap());
          }

          showToast("Treino salvo com sucesso");
          res = true;
        }
      }
    } catch (_) {
      res = false;
    }

    return res;
  }

  Future<void> setTrainingModel(TrainingModel model) async {
    isUpdate = true;
    idTraining = model.id;
    selectedStyle = model.style;
    selectedCategory = model.category;
    controllerNumber.text = model.number;
    controllerDate.text = model.date;
    controllerStart.text = model.frequencyStart.toString();
    controllerEnd.text = model.frequencyEnd.toString();
    controllerLastRound.text = model.lastRound.toString();
    controlResponsible = model.controlResponsible;
    controllerControlResponsible.text = model.controlResponsible.name;
    lastRoundCompleted = model.lastRoundCompleted;

    await setAthlete(model.athlete, model: model);


    for (var time in model.timeBy100) {

      var totalMilliseconds = time;
      var totalSeconds = totalMilliseconds ~/ 1000;
      var seconds = totalSeconds % 60;
      var minutes = (totalSeconds ~/ 60) % 60;
      var milliseconds = totalMilliseconds % 1000;

      timers.add(TimerModel(minutes: minutes.toString().padLeft(2, '0'), seconds: seconds.toString().padLeft(2, '0'), milliseconds: milliseconds.toString().padLeft(2, '0')));
    }
  }

  set selectedStyle(String value) {
    _selectedStyle = value;
  }

  set selectedCategory(String value) {
    _selectedCategory = value;
  }

  Future<void> setAthlete(UserModel user, {TrainingModel? model}) async {
    controllerAthlete.text = user.name;
    athlete = user;

    var res = await FirebaseFirestore.instance.collection('athletes').where('active', isEqualTo: true).where('validate', isEqualTo: true).get();
    var docs = res.docs;

    for (var doc in docs) {
      var obj =  AthleteModel.fromSnapshot(doc);

      if (obj.user.userID == user.userID) {
        categoriesAthlete.clear();
        stylesAthlete.clear();
        categoriesAthlete.addAll(obj.categories);
        stylesAthlete.addAll(obj.styles);

        if (model != null) {
          selectedStyle = model.style;
          selectedCategory = model.category;
        } else {
          selectedCategory = "";
          selectedStyle = "";
        }
      }
    }
  }

  void setControlResponsible(UserModel user) {
    controllerControlResponsible.text = user.name;
    controlResponsible = user;
  }

  String get selectedStyle => _selectedStyle;
  String get selectedCategory => _selectedCategory;

  bool isLoading = true;
  bool isUpdate = false;
  bool lastRoundCompleted = false;
  String idTraining = "";

  UserModel athlete = UserModel(userID: "", name: "", email: "", password: "", type: "", active: false);
  UserModel controlResponsible = UserModel(userID: "", name: "", email: "", password: "", type: "", active: false);

  List<String> errors = [];
  String _selectedStyle = '';
  String _selectedCategory = '';
  List<String> stylesAthlete = [];
  List<String> categoriesAthlete = [];

  final TextEditingController controllerNumber = TextEditingController();
  final TextEditingController controllerAthlete = TextEditingController();
  final TextEditingController controllerDate = TextEditingController();
  final TextEditingController controllerStart = TextEditingController();
  final TextEditingController controllerEnd = TextEditingController();
  final TextEditingController controllerControlResponsible = TextEditingController();
  final TextEditingController controllerLastRound = TextEditingController();
  List<TimerModel> timers = [];
  List<int> timerInSeconds = [];
  List<TrainingModel> training = [];
}