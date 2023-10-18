import 'package:flutter/material.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/home_page/widgets/button_option.dart';
import 'package:trabalho_faculdade/utils/routes.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Trabalho faculdade"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ButtonOption(
              title: "Cadastrar usuário",
              icon: Icons.person,
              onTap: () {
                Navigator.pushNamed(context, Routes.newUserView);
              }),
          ButtonOption(
              title: "Cadastrar treino",
              icon: Icons.water,
              onTap: () {
                Navigator.pushNamed(context, Routes.evaluativeTraining);
              }),
          ButtonOption(
              title: "Resultado de treino",
              icon: Icons.newspaper,
              onTap: () {
                Navigator.pushNamed(context, Routes.resultTraining);
              }),
          ButtonOption(
              title: "Análise dos treinos",
              icon: Icons.trending_up,
              onTap: () {
                Navigator.pushNamed(context, Routes.analizeTraining);
              })
        ],
      ),
    );
  }
}
