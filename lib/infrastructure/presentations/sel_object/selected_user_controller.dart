import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trabalho_faculdade/infrastructure/domain/entities/athlete.dart';
import 'package:trabalho_faculdade/infrastructure/domain/entities/user.dart';

class SelectedUserController {

  Future<void> getUsersAthletesWithout() async {
    List<AthleteModel> athletes = [];
    List<UserModel> usersWithout = [];
    users.clear();

    var res = await FirebaseFirestore.instance.collection('users').where('type', isEqualTo: 'atleta').where('active', isEqualTo: true).get();
    var docs = res.docs;

    for (var doc in docs) {
      var obj =  UserModel.fromSnapshot(doc);
      users.add(obj);
    }

    var resAthletes = await FirebaseFirestore.instance.collection('athletes').where('active', isEqualTo: true).get();
    var docsAthletes = resAthletes.docs;

    for (var doc in docsAthletes) {
      var obj =  AthleteModel.fromSnapshot(doc);
      athletes.add(obj);
    }

    usersWithout.addAll(users);

    for (var user in users) {
      if (athletes.indexWhere((e) => e.user.userID == user.userID) >= 0) {
        usersWithout.remove(user);
      }
    }

    users.clear();
    users.addAll(usersWithout);
  }

  Future<void> getAthletesValidate() async {
    List<AthleteModel> athletes = [];
    List<UserModel> usersWithout = [];

    users.clear();

    var res = await FirebaseFirestore.instance.collection('users').where('type', isEqualTo: 'atleta').where('active', isEqualTo: true).get();
    var docs = res.docs;

    for (var doc in docs) {
      var obj =  UserModel.fromSnapshot(doc);
      users.add(obj);
    }

    var resAthletes = await FirebaseFirestore.instance.collection('athletes').where('active', isEqualTo: true).where('validate', isEqualTo: true).get();
    var docsAthletes = resAthletes.docs;

    for (var doc in docsAthletes) {
      var obj =  AthleteModel.fromSnapshot(doc);
      athletes.add(obj);
    }

    for (var user in users) {
      if (athletes.indexWhere((e) => e.user.userID == user.userID) >= 0) {
        usersWithout.add(user);
      }
    }

    users.clear();
    users.addAll(usersWithout);
  }

  Future<void> getControlResponsible() async {
    users.clear();

    var res = await FirebaseFirestore.instance.collection('users').where('active', isEqualTo: true).get();
    var docs = res.docs;

    for (var doc in docs) {
      var obj =  UserModel.fromSnapshot(doc);

      if (obj.type != "administrador") {
        users.add(obj);
      }
    }
  }

  Future<List<AthleteModel>> getAthletesBySex(String sex) async {
    List<AthleteModel> athletes = [];

    var res = await FirebaseFirestore.instance.collection('athletes').where('active', isEqualTo: true).where('sex', isEqualTo: sex).get();
    var docs = res.docs;

    for (var doc in docs) {
      var obj =  AthleteModel.fromSnapshot(doc);

      athletes.add(obj);
    }

    return athletes;
  }

  Future<List<UserModel>> getAllAthletes() async {
    await getAthletesValidate();
    return users;
  }

  List<UserModel> users = [];
}
