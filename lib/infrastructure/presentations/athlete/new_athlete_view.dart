import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trabalho_faculdade/infrastructure/domain/entities/phone.dart';
import 'package:trabalho_faculdade/infrastructure/domain/entities/user.dart';
import 'package:trabalho_faculdade/infrastructure/domain/lists/category_list.dart';
import 'package:trabalho_faculdade/infrastructure/domain/lists/phone_types.dart';
import 'package:trabalho_faculdade/infrastructure/domain/lists/style_list.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/athlete/athlete_controller.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/sel_object/selected_user.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/shared/widgets/button/button_custom.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/shared/widgets/checkbox/checkbox_custom.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/shared/widgets/field_file/field_file.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/shared/widgets/input/text_field_custom.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/shared/widgets/toast/toast_message.dart';
import 'package:trabalho_faculdade/utils/colors.dart';
import 'package:trabalho_faculdade/utils/masks.dart';
import 'package:trabalho_faculdade/utils/util.dart';

class NewAthleteView extends StatefulWidget {
  NewAthleteView({Key? key, required this.state, required this.user})
      : super(key: key);

  AthleteController state;
   UserModel user;

  @override
  State<NewAthleteView> createState() => _NewAthleteViewState();
}

class _NewAthleteViewState extends State<NewAthleteView> {
  List<String> stylesUser = [];
  List<String> categoryUser = [];

  @override
  Widget build(BuildContext context) {
    stylesUser.clear();
    categoryUser.clear();

    stylesUser.addAll(styles);
    categoryUser.addAll(categories);

    stylesUser.removeAt(0);
    categoryUser.removeAt(0);

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text("Atleta"),
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
                          text: "Usuário",
                          hint: "Informe o usuário",
                          inputType: TextInputType.name,
                          readOnly: true,
                          onTap: () async {
                            var result = await Navigator.push(context, MaterialPageRoute(builder: (builder) => SelectedUser(type: 'A')));
                            if (result != null) {
                               widget.state.setUser(result);
                             }
                          },
                          controller: widget.state.controllerUser,
                          getColorValidator: Util.existStringInList(
                                  widget.state.errors, 'user')
                              ? MyColors.error
                              : MyColors.gray),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFieldCustom(
                          onTap: () async {
                            var selectedDate;

                            selectedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.parse("2000-01-01"),
                              lastDate: DateTime.parse("2050-01-01"),
                              locale: const Locale('pt', 'BR'),
                              confirmText: 'Confirmar',
                              cancelText: 'Cancelar',
                            );

                            if (selectedDate != null) {
                              selectedDate = DateFormat('dd/MM/yyyy')
                                  .format(selectedDate);

                              setState(() {
                                widget.state.controllerBirthDate.text =
                                    selectedDate;
                              });
                            }
                          },
                          readOnly: true,
                          hint: "Quando você nasceu?",
                          text: "Data de nascimento",
                          inputType: TextInputType.number,
                          mask: maskDateFormatter,
                          isPassword: false,
                          controller: widget.state.controllerBirthDate,
                          getColorValidator: Util.existStringInList(
                              widget.state.errors, 'birthDate')
                              ? MyColors.error
                              : MyColors.gray),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFieldCustom(
                          text: "Naturalidade",
                          hint: "Onde você nasceu?",
                          inputType: TextInputType.text,
                          isPassword: false,
                          controller: widget.state.controllerPlaceOfBirth,
                          getColorValidator: Util.existStringInList(
                              widget.state.errors, 'placeOfBirth')
                              ? MyColors.error
                              : MyColors.gray),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFieldCustom(
                          hint: "Informe sua nacionalidade",
                          text: "Nacionalidade",
                          inputType: TextInputType.text,
                          isPassword: false,
                          controller: widget.state.controllerNationality,
                          getColorValidator: Util.existStringInList(
                              widget.state.errors, 'nationality')
                              ? MyColors.error
                              : MyColors.gray),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFieldCustom(
                          text: "RG",
                          hint: "Informe seu RG",
                          inputType: TextInputType.number,
                          isPassword: false,
                          controller: widget.state.controllerRg,
                          getColorValidator: Util.existStringInList(
                              widget.state.errors, 'rg')
                              ? MyColors.error
                              : MyColors.gray),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFieldCustom(
                          text: "CPF",
                          hint: "Informe seu CPF",
                          inputType: TextInputType.number,
                          mask: maskCPFFormatter,
                          isPassword: false,
                          controller: widget.state.controllerCpf,
                          getColorValidator: Util.existStringInList(
                              widget.state.errors, 'cpf')
                              ? MyColors.error
                              : MyColors.gray),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Sexo",
                        style: TextStyle(
                            fontSize: 16,
                            color: Util.existStringInList(
                                widget.state.errors, 'sex')
                                ? MyColors.error
                                : MyColors.gray,
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
                              title: "Masculino",
                              onPressed: () {
                                setState(() {
                                  widget.state.controllerSex.text = 'Masculino';
                                });
                              },
                              isCheck: widget.state.controllerSex.text == 'Masculino'),
                          const SizedBox(
                            height: 10,
                          ),
                          CheckboxCustom(
                              title: "Feminino",
                              onPressed: () {
                                setState(() {
                                  widget.state.controllerSex.text = 'Feminino';
                                });
                              },
                              isCheck: widget.state.controllerSex.text == 'Feminino'),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFieldCustom(
                          text: "Endereço completo",
                          hint: "Informe seu endereço",
                          inputType: TextInputType.text,
                          isPassword: false,
                          controller: widget.state.controllerFullAddress,
                          getColorValidator: Util.existStringInList(
                              widget.state.errors, 'fullAddress')
                              ? MyColors.error
                              : MyColors.gray),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFieldCustom(
                          text: "Nome da mãe",
                          hint: "Informe o nome da sua mãe",
                          inputType: TextInputType.name,
                          isPassword: false,
                          controller: widget.state.controllerNameMother,
                          getColorValidator: MyColors.gray),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFieldCustom(
                          text: "Nome do pai",
                          hint: "Informe o nome do seu pai",
                          inputType: TextInputType.name,
                          isPassword: false,
                          controller: widget.state.controllerNameFather,
                          getColorValidator: MyColors.gray),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFieldCustom(
                          text: "Clube de Origem",
                          hint: "Qual seu clube de origem?",
                          inputType: TextInputType.text,
                          isPassword: false,
                          controller: widget.state.controllerOriginClub,
                          getColorValidator: MyColors.gray),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFieldCustom(
                          text: "Local de trabalho",
                          hint: "Onde você trabalha?",
                          inputType: TextInputType.text,
                          isPassword: false,
                          controller: widget.state.controllerLocalWork,
                          getColorValidator: MyColors.gray),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFieldCustom(
                          text: "Convênio médico",
                          hint: "Qual é seu convênio médico?",
                          inputType: TextInputType.text,
                          isPassword: false,
                          controller:
                          widget.state.controllerMedicalInsurance,
                          getColorValidator: Util.existStringInList(
                              widget.state.errors, 'medicalInsurance')
                              ? MyColors.error
                              : MyColors.gray),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldCustom(
                          text: "Alergia",
                          hint:
                          "A cada alergia informada, aperte o botão +",
                          inputType: TextInputType.text,
                          isPassword: false,
                          controller: widget.state.controllerAllergy,
                          getColorValidator: MyColors.gray,
                          onTapAdd: () {
                            if (widget.state.controllerAllergy.text.isNotEmpty) {
                              setState(() {
                                widget.state.allergies.add(
                                    widget.state.controllerAllergy.text);
                                widget.state.controllerAllergy.clear();
                              });
                            } else {
                              showToast("Informe uma alergia");
                            }
                          }),
                      const SizedBox(height: 10,),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.state.allergies.length,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.state.allergies[i],
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          widget.state.allergies
                                              .removeAt(i);
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      ))
                                ],
                              ),
                            );
                          }),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFieldCustom(
                          text: "Telefone",
                          hint:
                          "A cada telefone informado, aperte o botão +",
                          inputType: TextInputType.number,
                          isPassword: false,
                          mask: maskPhoneFormatter,
                          controller: widget.state.controllerPhone,
                          getColorValidator: MyColors.gray,
                          onTapAdd: () {
                            if (widget.state.controllerPhone.text != "" &&
                                widget.state.phone.type != "") {
                              setState(() {
                                widget.state.phone.phone =
                                    widget.state.controllerPhone.text;

                                widget.state.phones
                                    .add(widget.state.phone);

                                widget.state.controllerPhone.clear();
                                widget.state.phone =
                                    PhoneModel(phone: "", type: "");
                              });
                            } else {
                              showToast(
                                  "Preencha as informações do telefone");
                            }
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: phoneTypes.length,
                          itemBuilder: (context, i) {
                            return CheckboxCustom(
                                title: phoneTypes[i],
                                onPressed: () {
                                  setState(() {
                                    widget.state.phone.type =
                                    phoneTypes[i];
                                  });
                                },
                                isCheck: widget.state.phone.type ==
                                    phoneTypes[i]);
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.state.phones.length,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.state.phones[i].phone,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    widget.state.phones[i].type,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          widget.state.phones.removeAt(i);
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      ))
                                ],
                              ),
                            );
                          }),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Estilos",
                            style: TextStyle(
                                fontSize: 16,
                                color: MyColors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: stylesUser.length,
                          itemBuilder: (context, i) {
                            return CheckboxCustom(
                                title: stylesUser[i],
                                onPressed: () {
                                  setState(() {
                                    if (widget.state.styles
                                        .contains(stylesUser[i])) {
                                      widget.state.styles
                                          .remove(stylesUser[i]);
                                    } else {
                                      widget.state.styles
                                          .add(stylesUser[i]);
                                    }
                                  });
                                },
                                isCheck: widget.state.styles
                                    .contains(stylesUser[i]));
                          }),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Provas",
                            style: TextStyle(
                                fontSize: 16,
                                color: MyColors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: categoryUser.length,
                          itemBuilder: (context, i) {
                            return CheckboxCustom(
                                title: categoryUser[i],
                                onPressed: () {
                                  setState(() {
                                    if (widget.state.categories
                                        .contains(categoryUser[i])) {
                                      widget.state.categories
                                          .remove(categoryUser[i]);
                                    } else {
                                      widget.state.categories
                                          .add(categoryUser[i]);
                                    }
                                  });
                                },
                                isCheck: widget.state.categories
                                    .contains(categoryUser[i]));
                          }),
                      FieldFile(
                          title: "Atestado médico admissional",
                          onTap: () async {
                            await widget.state.setMedicalCertificate();
                            setState(() {});
                          },
                          text: widget.state.pathMedicalCertificate,
                          color: Util.existStringInList(
                              widget.state.errors,
                              'medicalCertificate')
                              ? MyColors.error
                              : MyColors.gray),
                      FieldFile(
                          title: "Comprovante RG",
                          onTap: () async {
                            await widget.state.setFileRg();
                            setState(() {});
                          },
                          text: widget.state.pathFileRg,
                          color: Util.existStringInList(
                              widget.state.errors, 'fileRg')
                              ? MyColors.error
                              : MyColors.gray),
                      FieldFile(
                          title: "Comprovante CPF",
                          onTap: () async {
                            await widget.state.setFileCpf();
                            setState(() {});
                          },
                          text: widget.state.pathFileCPf,
                          color: Util.existStringInList(
                              widget.state.errors, 'fileCpf')
                              ? MyColors.error
                              : MyColors.gray),
                      FieldFile(
                          title: "Comprovante de residência",
                          onTap: () async {
                            await widget.state.setProofOfAddress();
                            setState(() {});
                          },
                          text: widget.state.pathProofOfAddress,
                          color: Util.existStringInList(
                              widget.state.errors, 'proofOfAddress')
                              ? MyColors.error
                              : MyColors.gray),
                      FieldFile(
                          title: "Foto 3X4",
                          onTap: () async {
                            await widget.state.setPhoto3X4();
                            setState(() {});
                          },
                          text: widget.state.pathPhoto3X4,
                          color: Util.existStringInList(
                              widget.state.errors, 'photo3X4')
                              ? MyColors.error
                              : MyColors.gray),
                      FieldFile(
                          title: "Regulamento assinado",
                          onTap: () async {
                            await widget.state.setRegulation();
                            setState(() {});
                          },
                          text: widget.state.pathRegulation,
                          color: Util.existStringInList(
                              widget.state.errors, 'regulation')
                              ? MyColors.error
                              : MyColors.gray),
                      const SizedBox(height: 30,),
                      Visibility(
                        visible: widget.user.type == "treinador",
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Validação do treinador",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: MyColors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Visibility(
                        visible: widget.user.type == "treinador",
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CheckboxCustom(
                                title: "Atleta validado",
                                onPressed: () {
                                  setState(() {
                                    widget.state.validate = !widget.state.validate;
                                  });
                                },
                                isCheck: widget.state.validate),
                          ],
                        ),
                      ),
                      const SizedBox(height: 80),
                      ButtonCustom(
                          title: "Salvar",
                          onPressed: () async {
                            setState(() {
                              widget.state.isLoading = true;
                            });

                            bool res = await widget.state.saveUAthlete();

                            setState(() {
                              widget.state.isLoading = false;
                            });

                            if (res) {
                              Navigator.pop(context);
                            }
                          }),
                      Visibility(
                        visible: widget.state.isUpdate,
                        child: ButtonCustom(
                            title: "Excluir",
                            onPressed: () async {
                              setState(() {
                                widget.state.isLoading = true;
                              });

                              bool res = await widget.state.deleteAthlete();

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
