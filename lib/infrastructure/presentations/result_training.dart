import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trabalho_faculdade/infrastructure/domain/entities/training.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/shared/widgets/button/button_custom.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/shared/widgets/input/text_field_custom.dart';
import 'package:trabalho_faculdade/utils/colors.dart';
import 'package:trabalho_faculdade/utils/routes.dart';

class ResultTraining extends StatelessWidget {
  ResultTraining({Key? key}) : super(key: key);

  final TextEditingController _controllerDateInit = TextEditingController(text: '31/12/2023');
  final TextEditingController _controllerDateFinish = TextEditingController(text: '31/12/2023');

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
        title: const Text("Resultado de Treino"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(height: 30,),
            TextFieldCustom(
                onTap: () {
                  Navigator.pushNamed(context, Routes.selAthlete);
                },
                readOnly: true,
                hint: "Atleta (opcional)",
                inputType: TextInputType.text,
                getColorValidator: MyColors.gray),
            const SizedBox(
              height: 30,
            ),
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
            const SizedBox(
              height: 30,
            ),
            ButtonCustom(title: "Filtrar resultados", onPressed: () {}),
            Card(
              margin: const EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Estilo do Treino: ${trainingModel.style}'),
                    Text('Número do Treino: ${trainingModel.number}'),
                    Text('Atleta: ${trainingModel.athlete}'),
                    Text('Data do Treino: ${trainingModel.date}'),
                    Text('Frequência Cardíaca Início: ${trainingModel.frequencyStart}'),
                    Text('Frequência Cardíaca Final: ${trainingModel.frequencyEnd}'),
                    const Text('Tempos por 100 Metros (até 30 minutos):'),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: trainingModel.timeBy100.length,
                      itemBuilder: (context, index) {
                        final time = trainingModel.timeBy100[index];
                        final status = time < 0.8 * trainingModel.frequencyEnd
                            ? 'Abaixo da Média'
                            : time <= 1.2 * trainingModel.frequencyEnd
                            ? 'Na Média'
                            : 'Acima da Média';

                        return ListTile(
                          title: Text('Tempo ${index + 1}: ${time.toString()}s'),
                          subtitle: Text('Status: $status'),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
