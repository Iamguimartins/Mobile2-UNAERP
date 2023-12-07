import 'package:flutter/material.dart';
import 'package:trabalho_faculdade/infrastructure/domain/entities/user.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/analize_training/analize_training.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/athlete/view_all_athlete.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/auth/auth_view.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/home_page/widgets/button_option.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/result_training/result_training.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/shared/widgets/toast/toast_message.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/training/view_all_training.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/user/view_all_users.dart';
import 'package:trabalho_faculdade/utils/pref.dart';

class HomePageView extends StatelessWidget {
  HomePageView({Key? key, required this.user}) : super(key: key);

  UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[150],
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Trabalho da Faculdade',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Text("Bem vindo: ${user.name}", style: const TextStyle(fontSize: 26, color: Colors.white,)),
                  ],
                ),
              ),
              const Divider(),
              ListTile(
                title: const Text('Usuários'),
                trailing: const Icon(Icons.groups),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (builder) => ViewAllUsers(user: user)));
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              ListTile(
                title: const Text('Atletas'),
                trailing: const Icon(Icons.person),
                onTap: () {
                  if (!user.isAdm()) {
                    Navigator.push(context, MaterialPageRoute(builder: (builder) => ViewAllUsers(user: user)));
                    Navigator.pop(context);
                  } else {
                    showToast("Não liberado para esse perfil de usuário");
                  }
                },
              ),
              const Divider(),
              ListTile(
                title: const Text('Treinos'),
                trailing: const Icon(Icons.water),
                onTap: () {
                  if (!user.isAdm()) {
                    Navigator.push(context, MaterialPageRoute(builder: (builder) => const ViewAllTraining()));
                    Navigator.pop(context);
                  } else {
                    showToast("Não liberado para esse perfil de usuário");
                  }
                },
              ),
              const Divider(),
              ListTile(
                title: const Text('Análise de Treinos'),
                trailing: const Icon(Icons.trending_up),
                onTap: () {
                  if (user.isTrainer()) {
                    Navigator.push(context, MaterialPageRoute(builder: (builder) => const AnalizeTraining()));
                    Navigator.pop(context);
                  } else {
                    showToast("Não liberado para esse perfil de usuário");
                  }
                },
              ),
              const Divider(),
              ListTile(
                title: const Text('Resultado de Treino'),
                trailing: const Icon(Icons.newspaper),
                onTap: () {
                  if (user.isTrainer()) {
                    Navigator.push(context, MaterialPageRoute(builder: (builder) => const ResultTraining()));
                    Navigator.pop(context);
                  } else {
                    showToast("Não liberado para esse perfil de usuário");
                  }
                },
              ),
              const Divider(),
              ListTile(
                title: const Text('Sair do Aplicativo'),
                trailing: const Icon(Icons.exit_to_app),
                onTap: () async {
                  await Pref().remove('user');
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder) => AuthView()));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        title: const Text("Trabalho faculdade"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 60,),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text("Bem vindo: ${user.name}", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
          ),
          const SizedBox(height: 40,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonOption(
                  enabled: true,
                  title: "Usuários",
                  icon: Icons.groups,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (builder) => ViewAllUsers(user: user)));
                  }),
              ButtonOption(
                  enabled: !user.isAdm(),
                  title: "Atletas",
                  icon: Icons.person,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (builder) => ViewAllAthlete(user: user)));
                  }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonOption(
                  enabled: !user.isAdm(),
                  title: "Treinos",
                  icon: Icons.water,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (builder) => const ViewAllTraining()));
                  }),
              ButtonOption(
                  enabled: user.isTrainer(),
                  title: "Análise dos treinos",
                  icon: Icons.trending_up,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (builder) => const AnalizeTraining()));
                  }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonOption(
                  enabled: user.isTrainer(),
                  title: "Resultado de treino",
                  icon: Icons.newspaper,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (builder) => ResultTraining()));
                  }),
              ButtonOption(
                  enabled: true,
                  title: "Sair do aplicativo",
                  icon: Icons.exit_to_app,
                  onTap: () async {
                    await Pref().remove('user');
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder) => AuthView()));
                  })
            ],
          )
        ],
      ),
    );
  }
}
