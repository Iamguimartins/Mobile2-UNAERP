import 'package:flutter/material.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/shared/widgets/button/button_custom.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/shared/widgets/checkbox/checkbox_custom.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/shared/widgets/field_file/field_file.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/shared/widgets/input/text_field_custom.dart';
import 'package:trabalho_faculdade/utils/colors.dart';
import 'package:trabalho_faculdade/utils/masks.dart';

class NewUserView extends StatelessWidget {
  const NewUserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text("Novo usuário"),
          centerTitle: true,
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
                  const SizedBox(height: 70),
                  TextFieldCustom(
                      hint: "Nome",
                      inputType: TextInputType.name,
                      getColorValidator: MyColors.gray),
                  const SizedBox(
                    height: 30,
                  ),
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
                    height: 30,
                  ),
                  Text(
                    "Usuário",
                    style: TextStyle(
                        fontSize: 16,
                        color: MyColors.black,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CheckboxCustom(
                          title: "Administrador",
                          onPressed: () {

                          },
                          isCheck: false),
                      const SizedBox(
                        height: 10,
                      ),
                      CheckboxCustom(
                          title: "Atleta",
                          onPressed: () {

                          },
                          isCheck: true),
                      const SizedBox(
                        height: 10,
                      ),
                      CheckboxCustom(
                          title: "Treinador",
                          onPressed: () {

                          },
                          isCheck: false),
                    ],
                  ),
                  Visibility(
                    visible: true,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        TextFieldCustom(
                            hint: "Data de nascimento",
                            inputType: TextInputType.number,
                            mask: maskDateFormatter,
                            isPassword: false,
                            getColorValidator: MyColors.gray),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFieldCustom(
                            hint: "Naturalidade",
                            inputType: TextInputType.text,
                            isPassword: false,
                            getColorValidator: MyColors.gray),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFieldCustom(
                            hint: "Nacionalidade",
                            inputType: TextInputType.text,
                            isPassword: false,
                            getColorValidator: MyColors.gray),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFieldCustom(
                            hint: "RG",
                            inputType: TextInputType.text,
                            isPassword: false,
                            getColorValidator: MyColors.gray),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFieldCustom(
                            hint: "CPF",
                            inputType: TextInputType.number,
                            mask: maskCPFFormatter,
                            isPassword: false,
                            getColorValidator: MyColors.gray),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFieldCustom(
                            hint: "Sexo",
                            inputType: TextInputType.text,
                            isPassword: false,
                            getColorValidator: MyColors.gray),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFieldCustom(
                            hint: "Endereço completo",
                            inputType: TextInputType.text,
                            isPassword: false,
                            getColorValidator: MyColors.gray),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFieldCustom(
                            hint: "Nome da mãe",
                            inputType: TextInputType.name,
                            isPassword: false,
                            getColorValidator: MyColors.gray),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFieldCustom(
                            hint: "Nome do pai",
                            inputType: TextInputType.name,
                            isPassword: false,
                            getColorValidator: MyColors.gray),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFieldCustom(
                            hint: "Clube de Origem",
                            inputType: TextInputType.text,
                            isPassword: false,
                            getColorValidator: MyColors.gray),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFieldCustom(
                            hint: "Local de trabalho",
                            inputType: TextInputType.text,
                            isPassword: false,
                            getColorValidator: MyColors.gray),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFieldCustom(
                            hint: "Convênio médico",
                            inputType: TextInputType.text,
                            isPassword: false,
                            getColorValidator: MyColors.gray),
                        FieldFile(
                            title: "Atestado médico admissional",
                            onTap: () {

                            },
                            text: "",
                            color: MyColors.gray),
                        FieldFile(
                            title: "Comprovante RG",
                            onTap: () {

                            },
                            text: "",
                            color: MyColors.gray),
                        FieldFile(
                            title: "Comprovante CPF",
                            onTap: () {

                            },
                            text: "",
                            color: MyColors.gray),
                        FieldFile(
                            title: "Comprovante de residência",
                            onTap: () {

                            },
                            text: "",
                            color: MyColors.gray),
                        FieldFile(
                            title: "Foto 3X4",
                            onTap: () {

                            },
                            text: "",
                            color: MyColors.gray),
                        FieldFile(
                            title: "Regulamento assinado",
                            onTap: () {

                            },
                            text: "",
                            color: MyColors.gray),
                      ],
                    ),
                  ),
                  const SizedBox(height: 80),
                  ButtonCustom(
                          title: "Cadastrar",
                          onPressed: () async {

                          }),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
