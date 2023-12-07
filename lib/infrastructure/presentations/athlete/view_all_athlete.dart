import 'package:flutter/material.dart';
import 'package:trabalho_faculdade/infrastructure/domain/entities/user.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/athlete/athlete_controller.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/athlete/new_athlete_view.dart';

class ViewAllAthlete extends StatefulWidget {
  ViewAllAthlete({Key? key, required this.user}) : super(key: key);

  AthleteController state = AthleteController();
  UserModel user;

  @override
  State<ViewAllAthlete> createState() => _ViewAllAthleteState();
}

class _ViewAllAthleteState extends State<ViewAllAthlete> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text("Lista de Atletas"),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () async {
              widget.state.init();
              await Navigator.push(context, MaterialPageRoute(builder: (builder) => NewAthleteView(state: widget.state, user: widget.user,)));
              setState(() {});
            }, icon: const Icon(Icons.add))
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
                      itemCount: widget.state.athletes.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            widget.state.setAthlete(widget.state.athletes[index]);
                            await Navigator.push(context, MaterialPageRoute(builder: (builder) => NewAthleteView(state: widget.state, user: widget.user)));
                            setState(() {});
                          },
                          child: ListTile(
                            title: Text(widget.state.athletes[index].user.name),
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
