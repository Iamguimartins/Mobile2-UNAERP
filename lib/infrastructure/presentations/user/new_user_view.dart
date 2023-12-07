import 'package:flutter/material.dart';
import 'package:trabalho_faculdade/infrastructure/domain/entities/user.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/shared/widgets/button/button_custom.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/shared/widgets/checkbox/checkbox_custom.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/shared/widgets/input/text_field_custom.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/shared/widgets/toast/toast_message.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/user/user_controller.dart';
import 'package:trabalho_faculdade/utils/colors.dart';
import 'package:trabalho_faculdade/utils/util.dart';

class NewUserView extends StatefulWidget {
  NewUserView({Key? key, required this.state, required this.user})
      : super(key: key);

  UserController state;
  UserModel user;

  @override
  State<NewUserView> createState() => _NewUserViewState();
}

class _NewUserViewState extends State<NewUserView> {
  List<String> stylesUser = [];
  List<String> categoryUser = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text("Usuário"),
          centerTitle: true,
        ),
        body: widget.state.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 70),
                      TextFieldCustom(
                          readOnly: !widget.user.isAdm(),
                          text: "Nome",
                          hint: "Informe o seu nome",
                          inputType: TextInputType.name,
                          controller: widget.state.controllerName,
                          getColorValidator: Util.existStringInList(
                                  widget.state.errors, 'name')
                              ? MyColors.error
                              : MyColors.gray),
                      const SizedBox(
                        height: 30,
                      ),
                      Visibility(
                        visible: !widget.state.isUpdate,
                        child: TextFieldCustom(
                            text: "Email",
                            hint: "Informe o seu email",
                            inputType: TextInputType.emailAddress,
                            controller: widget.state.controllerEmail,
                            getColorValidator: Util.existStringInList(
                                    widget.state.errors, 'email')
                                ? MyColors.error
                                : MyColors.gray),
                      ),
                      Visibility(
                        visible: !widget.state.isUpdate,
                        child: const SizedBox(
                          height: 30,
                        ),
                      ),
                      Visibility(
                        visible: !widget.state.isUpdate,
                        child: TextFieldCustom(
                            text: "Senha (mínimo 6 caracteres)",
                            hint: "Informe a sua senha",
                            inputType: TextInputType.text,
                            isPassword: true,
                            controller: widget.state.controllerPassword,
                            getColorValidator: Util.existStringInList(
                                    widget.state.errors, 'password')
                                ? MyColors.error
                                : MyColors.gray),
                      ),
                      Visibility(
                        visible: !widget.state.isUpdate,
                        child: const SizedBox(
                          height: 30,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CheckboxCustom(
                              disabled: !widget.user.isAdm(),
                              title: "Administrador",
                              onPressed: () {
                                setState(() {
                                  widget.state.typeUser = 'administrador';
                                });
                              },
                              isCheck:
                              widget.state.typeUser == 'administrador'),
                          const SizedBox(
                            height: 10,
                          ),
                          CheckboxCustom(
                              disabled: !widget.user.isAdm(),
                              title: "Atleta",
                              onPressed: () {
                                setState(() {
                                  widget.state.typeUser = 'atleta';
                                });
                              },
                              isCheck: widget.state.typeUser == 'atleta'),
                          const SizedBox(
                            height: 10,
                          ),
                          CheckboxCustom(
                              disabled: !widget.user.isAdm(),
                              title: "Treinador",
                              onPressed: () {
                                setState(() {
                                  widget.state.typeUser = 'treinador';
                                });
                              },
                              isCheck: widget.state.typeUser == 'treinador'),
                        ],
                      ),
                      const SizedBox(height: 80),
                      Visibility(
                        visible: widget.user.isAdm(),
                        child: ButtonCustom(
                            title: "Salvar",
                            onPressed: () async {
                              setState(() {
                                widget.state.isLoading = true;
                              });

                              bool res = await widget.state.saveUser();

                              setState(() {
                                widget.state.isLoading = false;
                              });

                              if (res) {
                                Navigator.pop(context);
                              }
                            }),
                      ),
                      Visibility(
                        visible: widget.state.isUpdate && widget.user.isAdm(),
                        child: ButtonCustom(
                            title: "Excluir",
                            onPressed: () async {
                              setState(() {
                                widget.state.isLoading = true;
                              });

                              bool res = await widget.state.deleteUser();

                              setState(() {
                                widget.state.isLoading = false;
                              });

                              if (res) {
                                showToast("Usuário excluído com sucesso");
                                Navigator.pop(context);
                              } else {
                                showToast("Falha ao excluir usuário");
                              }
                            }),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ));
  }
}
