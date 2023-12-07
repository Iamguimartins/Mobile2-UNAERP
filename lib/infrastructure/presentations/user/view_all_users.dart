import 'package:flutter/material.dart';
import 'package:trabalho_faculdade/infrastructure/domain/entities/user.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/user/new_user_view.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/user/user_controller.dart';

class ViewAllUsers extends StatefulWidget {
  ViewAllUsers({Key? key, required this.user}) : super(key: key);

  UserController state = UserController();
  UserModel user;

  @override
  State<ViewAllUsers> createState() => _ViewAllUsersState();
}

class _ViewAllUsersState extends State<ViewAllUsers> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text("Lista de Usuários"),
          centerTitle: true,
          actions: [
            Visibility(
              visible: widget.user.isAdm(),
              child: IconButton(onPressed: () async {
                widget.state.init();
                await Navigator.push(context, MaterialPageRoute(builder: (builder) => NewUserView(state: widget.state, user: widget.user,)));
                setState(() {});
              }, icon: const Icon(Icons.add)),
            )
          ],
        ),
        body: FutureBuilder(
          future: widget.state.getData(widget.user),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting: return const Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return ListView.builder(
                      itemCount: widget.state.users.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            widget.state.init();
                            await widget.state.setUser(widget.state.users[index]);
                            await Navigator.push(context, MaterialPageRoute(builder: (builder) => NewUserView(state: widget.state, user: widget.user)));
                            setState(() {});
                          },
                          child: ListTile(
                            title: Text(widget.state.users[index].name),
                            subtitle: Text(widget.state.users[index].type),
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
}
