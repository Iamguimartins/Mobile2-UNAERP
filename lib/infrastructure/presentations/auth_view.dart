import 'package:flutter/material.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/shared/widgets/button/button_custom.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/shared/widgets/input/text_field_custom.dart';
import 'package:trabalho_faculdade/utils/assets.dart';
import 'package:trabalho_faculdade/utils/colors.dart';
import 'package:trabalho_faculdade/utils/routes.dart';

class AuthView extends StatelessWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    const SizedBox(
                      height: 20,
                    ),
                    Image.asset(Assets.logo),
                    const SizedBox(height: 50),
                    Text(
                      "Bem vindo",
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                          color: MyColors.neutralText),
                    ),
                    const SizedBox(height: 40),
                    TextFieldCustom(
                        hint: "Email",
                        inputType: TextInputType.emailAddress,
                        getColorValidator: MyColors.gray),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFieldCustom(
                        hint: "Senha",
                        inputType: TextInputType.text,
                        isPassword: true,
                        getColorValidator: MyColors.gray),
                    const SizedBox(
                      height: 25,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.recoverPassword);
                      },
                      child: Center(
                        child: Text(
                          "Esqueci a senha",
                          style: TextStyle(
                              color:
                              MyColors.primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 13),
                        ),
                      ),
                    ),
                    const SizedBox(height: 80),
                    ButtonCustom(
                        title: "Entrar",
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, Routes.homePage);
                        }),
                    const SizedBox(height: 20,),
                  ],
                ),
              ),
      ),
    ));
  }
}