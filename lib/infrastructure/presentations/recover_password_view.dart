import 'package:flutter/material.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/shared/widgets/button/button_custom.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/shared/widgets/input/text_field_custom.dart';
import 'package:trabalho_faculdade/utils/colors.dart';

class RecoverPasswordView extends StatelessWidget {
  const RecoverPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Recuperação de senha"),
          centerTitle: true,
          elevation: 0,
        ),
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
                        hint: "Email",
                        inputType: TextInputType.emailAddress,
                        getColorValidator: MyColors.gray),
                    const SizedBox(
                      height: 30,
                    ),
                    const SizedBox(height: 80),
                    ButtonCustom(
                        title: "Enviar Link",
                        onPressed: ()  {
                        }),
                  ],
                ),
              ),
      ),
    ));
  }
}
