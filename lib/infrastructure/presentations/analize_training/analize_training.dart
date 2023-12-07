import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trabalho_faculdade/infrastructure/domain/lists/category_list.dart';
import 'package:trabalho_faculdade/infrastructure/domain/lists/style_list.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/analize_training/analize_training_controller.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/sel_object/selected_user.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/shared/widgets/button/button_custom.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/shared/widgets/chart/bar_chart/bar_chart_custom.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/shared/widgets/input/text_field_custom.dart';
import 'package:trabalho_faculdade/utils/colors.dart';

class AnalizeTraining extends StatefulWidget {
  const AnalizeTraining({Key? key}) : super(key: key);

  @override
  State<AnalizeTraining> createState() => _AnalizeTrainingState();
}

class _AnalizeTrainingState extends State<AnalizeTraining> {
  AnalizeTrainingController state = AnalizeTrainingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Análise dos Treinos"),
        centerTitle: true,
      ),
      body: state.isLoading ? const Center(child: CircularProgressIndicator(),) : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 150,
                  child: TextFieldCustom(
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
                          state.controllerDateInit.text = selectedDate;
                        }
                      },
                      controller: state.controllerDateInit,
                      readOnly: true,
                      text: "Data Inicial",
                      hint: "",
                      inputType: TextInputType.number,
                      getColorValidator: MyColors.gray),
                ),
                const SizedBox(width: 10,),
                SizedBox(
                  width: 150,
                  child: TextFieldCustom(
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
                          state.controllerDateFinish.text = selectedDate;
                        }
                      },
                      controller: state.controllerDateFinish,
                      readOnly: true,
                      text: "Data Final",
                      hint: "",
                      inputType: TextInputType.number,
                      getColorValidator: MyColors.gray),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            TextFieldCustom(
                controller: state.controllerAthlete,
                onTap: () async {
                  var result = await Navigator.push(context, MaterialPageRoute(builder: (builder) => SelectedUser(type: 'V')));
                  if (result != null) {
                    state.setAthlete(result);
                  }
                },
                readOnly: true,
                text: "Atleta (opcional)",
                hint: "Informe o atleta",
                inputType: TextInputType.text,
                getColorValidator: MyColors.gray),
            const SizedBox(height: 20,),
            Text("Estilo", style: TextStyle(
                fontSize: 16,
                color: MyColors.black,
                fontWeight: FontWeight.w400),),
            DropdownButton<String>(
              value: state.selectedStyle,
              onChanged: (newValue) {
                state.selectedStyle = newValue ?? "";
                setState(() {});
              },
              items: styles
                  .map<DropdownMenuItem<String>>((String style) {
                return DropdownMenuItem<String>(
                  value: style,
                  child: Text(style),
                );
              }).toList(),
            ),
            const SizedBox(height: 20,),
            Text("Categoria", style: TextStyle(
                fontSize: 16,
                color: MyColors.black,
                fontWeight: FontWeight.w400),),
            DropdownButton<String>(
              value: state.selectedCategory,
              onChanged: (newValue) {
                state.selectedCategory = newValue ?? "";
                setState(() {});
              },
              items: categories
                  .map<DropdownMenuItem<String>>((String event) {
                return DropdownMenuItem<String>(
                  value: event,
                  child: Text(event),
                );
              }).toList(),
            ),
            const SizedBox(height: 20,),
            Text("Sexo", style: TextStyle(
                fontSize: 16,
                color: MyColors.black,
                fontWeight: FontWeight.w400),),
            DropdownButton<String>(
              value: state.selectedSex,
              onChanged: (newValue) {
                state.selectedSex = newValue ?? "";
                setState(() {});
              },
              items: ['Todos', 'Masculino', 'Feminino']
                  .map<DropdownMenuItem<String>>((String sex) {
                return DropdownMenuItem<String>(
                  value: sex,
                  child: Text(sex),
                );
              }).toList(),
            ),
            const SizedBox(height: 20,),
            ButtonCustom(title: "Gerar dados", onPressed: () async {
              setState(() {
                state.isLoading = true;
              });
              await state.getData();
              setState(() {
                state.isLoading = false;
              });
            }),
            const SizedBox(height: 40,),
            Visibility(
              visible: state.trainings.isNotEmpty,
              child: BarChartCustom(
                title: "Número de treinos por atleta",
                sections: state.trainingByUser,
              ),
            ),
            Visibility(
              visible: state.trainings.isEmpty,
              child: const Center(
                child: Text("Nenhum dado encontrado"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
