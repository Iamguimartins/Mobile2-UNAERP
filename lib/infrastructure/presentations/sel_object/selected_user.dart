import 'package:flutter/material.dart';
import 'package:trabalho_faculdade/infrastructure/domain/entities/user.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/sel_object/selected_user_controller.dart';

class SelectedUser extends StatelessWidget {
  SelectedUser({Key? key, required this.type}) : super(key: key);

  //A - Athetas sem usuário
  String type;

  UserModel? userSelected;
  SelectedUserController state = SelectedUserController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(getTitle()),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: getTypeFilter(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting: return const Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return ListView.builder(
                      itemCount: state.users.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            userSelected = state.users[index];
                            Navigator.pop(context, userSelected);
                          },
                          child: ListTile(
                            title: Text(state.users[index].name),
                            trailing: const Icon(Icons.arrow_forward_outlined),
                          ),
                        );
                      });
                }
            }
          },
        )
    );
  }

  Future<void> getTypeFilter() async {
    if (type == 'A') {
      await state.getUsersAthletesWithout();
    } else if (type == 'V') {
      await state.getAthletesValidate();
    } else if (type == 'C') {
      await state.getControlResponsible();
    }
  }

  String getTitle() {
    if (type == 'A') {
      return 'Atletas sem usuário';
    } else if (type == 'V') {
      return 'Athetas validados';
    } else if (type == 'C') {
      return 'Responsável pelo treino';
    } else {
      return '';
    }
  }
}
