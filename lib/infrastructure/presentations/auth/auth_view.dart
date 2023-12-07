import 'package:flutter/material.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/auth/auth_controller.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/home_page/home_page_view.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/recovery/recover_password_view.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/shared/widgets/button/button_custom.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/shared/widgets/input/text_field_custom.dart';
import 'package:trabalho_faculdade/utils/assets.dart';
import 'package:trabalho_faculdade/utils/colors.dart';
import 'package:trabalho_faculdade/utils/pref.dart';
import 'package:trabalho_faculdade/utils/util.dart';

class AuthView extends StatefulWidget {
  AuthView({Key? key}) : super(key: key);

  AuthController state = AuthController();

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {

  @override
  void initState() {
    super.initState();
    widget.state.init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: widget.state.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
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
                        Center(
                            child: Image.asset(Assets.logo,
                                height: 100, width: 200)),
                        const SizedBox(height: 50),
                        Text(
                          "Bem-vindo",
                          style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                              color: MyColors.neutralText),
                        ),
                        const SizedBox(height: 40),
                        TextFieldCustom(
                            hint: "Informe o seu e-mail",
                            text: "E-mail",
                            inputType: TextInputType.emailAddress,
                            controller: widget.state.controllerEmail,
                            getColorValidator:
                                Util.existStringInList(widget.state.errors, 'e-mail')
                                    ? MyColors.error
                                    : MyColors.gray),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFieldCustom(
                            text: "Senha",
                            hint: "Informe sua senha",
                            inputType: TextInputType.text,
                            isPassword: true,
                            controller: widget.state.controllerPassword,
                            getColorValidator:
                                Util.existStringInList(widget.state.errors, 'password')
                                    ? MyColors.error
                                    : MyColors.gray),
                        const SizedBox(
                          height: 25,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (builder) => const RecoverPasswordView()));
                          },
                          child: Center(
                            child: Text(
                              "Esqueceu a senha?",
                              style: TextStyle(
                                  color: MyColors.primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13),
                            ),
                          ),
                        ),
                        const SizedBox(height: 80),
                        ButtonCustom(
                            title: "Login",
                            onPressed: () async {
                              setState(() {
                                widget.state.isLoading = true;
                              });

                              if (await widget.state.onLogin()) {
                                var user = await Pref().getUser();
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) => HomePageView(
                                              user: user!,
                                            )));
                              }

                              setState(() {
                                widget.state.isLoading = false;
                              });
                            }),
                      ],
                    ),
                  ),
                ),
              ));
  }
}
