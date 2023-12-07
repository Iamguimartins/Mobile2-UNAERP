import 'package:flutter/material.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/recovery/recover_password_controller.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/shared/widgets/button/button_custom.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/shared/widgets/input/text_field_custom.dart';
import 'package:trabalho_faculdade/utils/colors.dart';
import 'package:trabalho_faculdade/utils/util.dart';

class RecoverPasswordView extends StatefulWidget {
  const RecoverPasswordView({Key? key}) : super(key: key);

  @override
  State<RecoverPasswordView> createState() => _RecoverPasswordViewState();
}

class _RecoverPasswordViewState extends State<RecoverPasswordView> {
  RecoverPasswordController state = RecoverPasswordController();

  @override
  void initState() {
    super.initState();
    state.init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Recuperação de senha"),
          centerTitle: true,
          elevation: 0,
        ),
        body: state.isLoading ? const Center(child: CircularProgressIndicator(),) : Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  Center(
                    child: Text(
                      "Esqueceu a senha?. Não se preocupe, coloque seu email abaixo, que enviares um link para recuperação",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: MyColors.neutralText),
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextFieldCustom(
                      text: "Email",
                      hint: "Informe seu email",
                      inputType: TextInputType.emailAddress,
                      controller: state.controllerEmail,
                      getColorValidator:
                      Util.existStringInList(state.errors, 'email')
                          ? MyColors.error
                          : MyColors.gray),
                  const SizedBox(
                    height: 30,
                  ),
                  const SizedBox(height: 80),
                  state.isLoading ? const Center(
                    child: CircularProgressIndicator(),
                  ) : ButtonCustom(
                      title: "Enviar Link",
                      onPressed: () async {
                        setState(() {
                          state.isLoading = true;
                        });
                        await state.sendLink();
                        setState(() {
                          state.isLoading = false;
                        });
                      }),
                ],
              ),
            ),
          ),
        ));
  }
}