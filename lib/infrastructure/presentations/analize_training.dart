import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trabalho_faculdade/infrastructure/domain/entities/chart_section.dart';
import 'package:trabalho_faculdade/infrastructure/domain/entities/training.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/shared/widgets/button/button_custom.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/shared/widgets/chart/bar_chart/bar_chart_custom.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/shared/widgets/chart/line_chart/line_chart_custom.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/shared/widgets/chart/pie_chart/pie_chart_custom.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/shared/widgets/input/text_field_custom.dart';
import 'package:trabalho_faculdade/utils/colors.dart';

class AnalizeTraining extends StatelessWidget {
  AnalizeTraining({Key? key}) : super(key: key);

  final TextEditingController _controllerDateInit = TextEditingController(text: '31/12/2023');
  final TextEditingController _controllerDateFinish = TextEditingController(text: '31/12/2023');

  String selectedStyle = 'Estilo Livre';
  String selectedEvent = '100m Livre';
  String selectedSex = 'Masculino';
  String selectedPeriod = 'Mês Atual';

  final TrainingModel trainingModel = TrainingModel(
    style: "Natação",
    number: "1",
    date: DateTime.now().toString(),
    athlete: "João",
    frequencyStart: 80,
    frequencyEnd: 120,
    controlResponsible: "Seu zé",
    timeBy100: List.generate(10, (index) => (index + 1) * 2),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Análise dos Treinos"),
        centerTitle: true,
      ),
      body: Padding(
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
                        }
                      },
                      controller: _controllerDateInit,
                      readOnly: true,
                      hint: "Data Inicial",
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
                        }
                      },
                      controller: _controllerDateFinish,
                      readOnly: true,
                      hint: "Data Final",
                      inputType: TextInputType.number,
                      getColorValidator: MyColors.gray),
                ),
              ],
            ),
            const SizedBox(height: 20,),
            DropdownButton<String>(
              value: selectedStyle,
              onChanged: (newValue) {
                //update
              },
              items: ['Estilo Livre', 'Borboleta', 'Costas', 'Peito']
                  .map<DropdownMenuItem<String>>((String style) {
                return DropdownMenuItem<String>(
                  value: style,
                  child: Text(style),
                );
              }).toList(),
            ),
            const SizedBox(height: 20,),
            DropdownButton<String>(
              value: selectedEvent,
              onChanged: (newValue) {
                //update
              },
              items: ['100m Livre', '200m Livre', '50m Peito', '100m Borboleta']
                  .map<DropdownMenuItem<String>>((String event) {
                return DropdownMenuItem<String>(
                  value: event,
                  child: Text(event),
                );
              }).toList(),
            ),
            const SizedBox(height: 20,),
            DropdownButton<String>(
              value: selectedSex,
              onChanged: (newValue) {
                //update
              },
              items: ['Masculino', 'Feminino']
                  .map<DropdownMenuItem<String>>((String sex) {
                return DropdownMenuItem<String>(
                  value: sex,
                  child: Text(sex),
                );
              }).toList(),
            ),
            const SizedBox(height: 20,),
            ButtonCustom(title: "Gerar dados", onPressed: () {}),
            const SizedBox(height: 40,),
            BarChartCustom(
              title: "Gráfico de Barras",
              sections: [
                ChartSection(title: "Valor A", value: 100),
                ChartSection(title: "Valor B", value: 150),
                ChartSection(title: "Valor C", value: 90),
                ChartSection(title: "Valor D", value: 170),
              ],
            ),
            const SizedBox(height: 20,),
            PieChartCustom(
              title: "Gráfico de Pizza",
              sections: [
                ChartSection(title: "Valor A", value: 100, color: Colors.blue),
                ChartSection(title: "Valor B", value: 150, color: Colors.red),
                ChartSection(title: "Valor C", value: 90, color: Colors.yellow),
                ChartSection(title: "Valor D", value: 170, color: Colors.green),
              ],
            ),
            const SizedBox(height: 20,),
            LineChartCustom(
              colorLine: Colors.blue,
              title: "Gráfico de Linha",
              sections: [
                ChartSection(title: "Valor A", value: 100),
                ChartSection(title: "Valor B", value: 150),
                ChartSection(title: "Valor C", value: 90),
                ChartSection(title: "Valor D", value: 170),
              ],
            )
          ],
        ),
      ),
    );
  }
}
