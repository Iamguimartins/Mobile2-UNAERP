import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trabalho_faculdade/infrastructure/domain/entities/user.dart';

class TrainingModel {
  String id;
  String style;
  String category;
  String number;
  UserModel athlete;
  String date;
  double frequencyStart;
  double frequencyEnd;
  UserModel controlResponsible;
  double lastRound;
  bool lastRoundCompleted;
  List<int> timeBy100;
  bool active;

  TrainingModel({
     required this.id,
     required this.style,
     required this.category,
     required this.number,
     required this.athlete,
     required this.date,
     required this.frequencyStart,
     required this.frequencyEnd,
     required this.controlResponsible,
     required this.lastRound,
     required this.lastRoundCompleted,
     required this.timeBy100,
     required this.active,
  });

  TrainingModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        style = json['style'],
        category = json['category'],
        number = json['number'],
        athlete = UserModel.fromJson(json['athlete']),
        date = json['date'],
        frequencyStart = json['frequencyStart'],
        frequencyEnd = json['frequencyEnd'],
        controlResponsible = UserModel.fromJson(json['controlResponsible']),
        lastRound = json['lastRound'],
        lastRoundCompleted = json['lastRoundCompleted'],
        timeBy100 = List<int>.from(json['timeBy100']),
        active = json['active'];

  factory TrainingModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return TrainingModel(
      id: snapshot.id,
      style: data['style'],
      category: data['category'],
      number: data['number'],
      athlete: UserModel.fromJson(data['athlete']),
      date: data['date'],
      frequencyStart: (data['frequencyStart'] ?? 0.0).toDouble(),
      frequencyEnd: (data['frequencyEnd'] ?? 0.0).toDouble(),
      controlResponsible: UserModel.fromJson(data['controlResponsible']),
      lastRound: data['lastRound'],
      lastRoundCompleted: data['lastRoundCompleted'],
      timeBy100: List<int>.from(data['timeBy100']),
      active: data['active']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'style': style,
      'category': category,
      'number': number,
      'athlete': athlete.toMap(),
      'date': date,
      'frequencyStart': frequencyStart,
      'frequencyEnd': frequencyEnd,
      'controlResponsible': controlResponsible.toMap(),
      'lastRound': lastRound,
      'lastRoundCompleted': lastRoundCompleted,
      'timeBy100': timeBy100,
      'active': active
    };
  }
}