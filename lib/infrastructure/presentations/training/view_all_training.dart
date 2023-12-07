import 'package:flutter/material.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/training/new_evaluative_training.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/training/training_controller.dart';

class ViewAllTraining extends StatefulWidget {
  const ViewAllTraining({Key? key}) : super(key: key);

  @override
  State<ViewAllTraining> createState() => _ViewTrainingState();
}

class _ViewTrainingState extends State<ViewAllTraining> {
  TrainingController state = TrainingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Treinos"),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(onPressed: () async {
            state.init();
            await Navigator.push(context, MaterialPageRoute(builder: (builder) => NewEvaluativeTraining(state: state,)));
            setState(() {});
          }, icon: const Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
          future: state.getData(),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting: return const Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return ListView.builder(
                      itemCount: state.training.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            state.init();
                            await state.setTrainingModel(state.training[index]);
                            await Navigator.push(context, MaterialPageRoute(builder: (builder) => NewEvaluativeTraining(state: state,)));
                            setState(() {});
                          },
                          child: ListTile(
                            title: Text(state.training[index].number),
                            subtitle: Text(state.training[index].date),
                            trailing: const Icon(Icons.arrow_forward_outlined),
                          ),
                        );
                      });
                }
            }
          }),
    );
  }
}
