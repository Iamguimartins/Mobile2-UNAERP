import 'package:flutter/material.dart';
import 'package:trabalho_faculdade/utils/colors.dart';
import 'package:trabalho_faculdade/utils/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  runApp(const TrabalhoFaculdade());
}

class TrabalhoFaculdade extends StatelessWidget {
  const TrabalhoFaculdade({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trabalho Faculdade',
      debugShowCheckedModeBanner: false,
      routes: Routes.routes,
      initialRoute: Routes.authView,
      theme: ThemeData(
        scaffoldBackgroundColor: MyColors.neutralBackground,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt'),
      ],
    );
  }
}
