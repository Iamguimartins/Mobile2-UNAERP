import 'package:flutter/material.dart';
import 'package:trabalho_faculdade/infrastructure/domain/entities/timer.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/shared/widgets/button/button_custom.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/shared/widgets/input/text_field_custom.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/times_evaluative.dart';
import 'package:trabalho_faculdade/utils/colors.dart';
import 'package:trabalho_faculdade/utils/routes.dart';

class EvaluativeTrainingView extends StatefulWidget {
  EvaluativeTrainingView({Key? key}) : super(key: key);

  @override
  State<EvaluativeTrainingView> createState() => _EvaluativeTrainingViewState();
}

class _EvaluativeTrainingViewState extends State<EvaluativeTrainingView> {
  List<TimerModel> timers = [];
  List<TimerModel> timerView = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Novo treino"),
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
              const SizedBox(height: 70),
              TextFieldCustom(
                  hint: "Estilo",
                  inputType: TextInputType.text,
                  getColorValidator: MyColors.gray),
              const SizedBox(
                height: 30,
              ),
              TextFieldCustom(
                  hint: "Número",
                  inputType: TextInputType.number,
                  getColorValidator: MyColors.gray),
              const SizedBox(
                height: 30,
              ),
              TextFieldCustom(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.selAthlete);
                  },
                  readOnly: true,
                  hint: "Atleta",
                  inputType: TextInputType.text,
                  getColorValidator: MyColors.gray),
              const SizedBox(
                height: 30,
              ),
              TextFieldCustom(
                  hint: "Data",
                  inputType: TextInputType.number,
                  getColorValidator: MyColors.gray),
              const SizedBox(
                height: 30,
              ),
              TextFieldCustom(
                  hint: "Frequência cardíaca no ínicio",
                  inputType: TextInputType.number,
                  getColorValidator: MyColors.gray),
              const SizedBox(
                height: 30,
              ),
              TextFieldCustom(
                  hint: "Frequência cardíaca no final",
                  inputType: TextInputType.number,
                  getColorValidator: MyColors.gray),
              const SizedBox(
                height: 30,
              ),
              TextFieldCustom(
                  hint: "Responsável pelo controle do tempo",
                  inputType: TextInputType.text,
                  getColorValidator: MyColors.gray),
              const SizedBox(
                height: 25,
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: timers.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          height: 20,
                          child: Text(
                            "Tempo: ${i + 1}: ${timers[i].hours}:${timers[i].minutes}:${timers[i].secounds}",
                            style: const TextStyle(fontSize: 16),
                          )),
                    );
                  }),
              ButtonCustom(
                  title: "Cadastrar tempos",
                  onPressed: () async {
                    var result = await Navigator.of(context).push(MaterialPageRoute(builder: (builder) => TimesEvaluative(timers: timers,)));
                    timerView.clear();
                    timerView.addAll(result);
                    setState(() {

                    });
                  }),
              const SizedBox(height: 80),
              ButtonCustom(
                      title: "Salvar",
                      onPressed: () {

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
