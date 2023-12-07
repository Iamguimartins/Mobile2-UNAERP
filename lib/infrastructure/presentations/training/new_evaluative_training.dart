import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trabalho_faculdade/infrastructure/domain/entities/timer.dart';
import 'package:trabalho_faculdade/infrastructure/domain/lists/category_list.dart';
import 'package:trabalho_faculdade/infrastructure/domain/lists/style_list.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/sel_object/selected_user.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/shared/widgets/button/button_custom.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/shared/widgets/checkbox/checkbox_custom.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/shared/widgets/input/text_field_custom.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/shared/widgets/toast/toast_message.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/training/training_controller.dart';
import 'package:trabalho_faculdade/utils/colors.dart';
import 'package:trabalho_faculdade/utils/util.dart';

class NewEvaluativeTraining extends StatefulWidget {
  NewEvaluativeTraining({Key? key, required this.state}) : super(key: key);
  TrainingController state;

  @override
  State<NewEvaluativeTraining> createState() => _NewEvaluativeTrainingState();
}

class _NewEvaluativeTrainingState extends State<NewEvaluativeTraining> {
  late Stopwatch _stopwatch;
  late Timer _timer;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    _timer = Timer.periodic(const Duration(milliseconds: 1), _updateTimer);
  }

  void _updateTimer(Timer timer) {
    if (_stopwatch.isRunning) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final minutes = (_stopwatch.elapsed.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (_stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, '0');
    final milliseconds = (_stopwatch.elapsed.inMilliseconds % 60).toString().padLeft(2, '0');

    List<String> stylesTraining = [];
    List<String> categoryTraining = [];

    stylesTraining.addAll(styles);
    categoryTraining.addAll(categories);

    stylesTraining.removeAt(0);
    categoryTraining.removeAt(0);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Treino"),
          centerTitle: true,
          elevation: 0,
        ),
        body: widget.state.isLoading ? const Center(child: CircularProgressIndicator(),) : Container(
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
                      controller: widget.state.controllerAthlete,
                      onTap: () async {
                        var result = await Navigator.push(context, MaterialPageRoute(builder: (builder) => SelectedUser(type: 'V',)));
                          if (result != null) {
                            await widget.state.setAthlete(result);
                            setState(() {});
                        }
                      },
                      readOnly: true,
                      text: "Atleta",
                      hint: "Qual é o atleta do treino?",
                      inputType: TextInputType.text,
                      getColorValidator: Util.existStringInList(
                          widget.state.errors, 'athlete')
                          ? MyColors.error
                          : MyColors.gray),
                  const SizedBox(
                    height: 30,
                  ),
                  Text("Estilo", style: TextStyle(
                      fontSize: 16,
                      color: MyColors.black,
                      fontWeight: FontWeight.w400),),
                  const SizedBox(height: 10,),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Util.existStringInList(
                            widget.state.errors, 'style')
                            ? MyColors.error
                            : MyColors.gray)
                    ),
                    height: 50,
                    width: double.infinity,
                    child: DropdownButton<String>(
                      hint: const Text("Informe um estilo"),
                      value: widget.state.selectedStyle == "" ? null : widget.state.selectedStyle,
                      onChanged: (newValue) {
                        widget.state.selectedStyle = newValue ?? "";
                        setState(() {});
                      },
                      items: widget.state.stylesAthlete
                          .map<DropdownMenuItem<String>>((String style) {
                        return DropdownMenuItem<String>(
                          value: style,
                          child: Text(style),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text("Categoria:", style: TextStyle(
                      fontSize: 16,
                      color: MyColors.black,
                      fontWeight: FontWeight.w400),),
                  const SizedBox(height: 10,),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Util.existStringInList(
                            widget.state.errors, 'category')
                            ? MyColors.error
                            : MyColors.gray)
                    ),
                    height: 50,
                    width: double.infinity,
                    child: DropdownButton<String>(
                      hint: const Text("Informe uma prova"),
                      value: widget.state.selectedCategory == "" ? null : widget.state.selectedCategory,
                      onChanged: (newValue) {
                        widget.state.selectedCategory = newValue ?? "";
                        setState(() {});
                      },
                      items: widget.state.categoriesAthlete
                          .map<DropdownMenuItem<String>>((String style) {
                        return DropdownMenuItem<String>(
                          value: style,
                          child: Text(style),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFieldCustom(
                      controller: widget.state.controllerNumber,
                      text: "Número",
                      hint: "Informe o número do treino",
                      inputType: const TextInputType.numberWithOptions(signed: false, decimal: false),
                      getColorValidator: Util.existStringInList(
                          widget.state.errors, 'number')
                          ? MyColors.error
                          : MyColors.gray),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFieldCustom(
                      controller: widget.state.controllerDate,
                      hint: "Quando aconteceu",
                      text: "Data",
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
                          widget.state.controllerDate.text = selectedDate;
                        }
                      },
                      inputType: TextInputType.number,
                      getColorValidator: Util.existStringInList(
                          widget.state.errors, 'date')
                          ? MyColors.error
                          : MyColors.gray),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFieldCustom(
                      controller: widget.state.controllerStart,
                      text: "Frequência cardíaca no ínicio",
                      hint: "Frequência no ínicio do treino",
                      inputType: TextInputType.number,
                      getColorValidator: Util.existStringInList(
                          widget.state.errors, 'start')
                          ? MyColors.error
                          : MyColors.gray),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFieldCustom(
                      controller: widget.state.controllerEnd,
                      text: "Frequência cardíaca no final",
                      hint: "Frequência no final do treino",
                      inputType: TextInputType.number,
                      getColorValidator: Util.existStringInList(
                          widget.state.errors, 'end')
                          ? MyColors.error
                          : MyColors.gray),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFieldCustom(
                      onTap: () async {
                        if (widget.state.athlete.userID == "") {
                          showToast("Primeiro informe o atlheta");
                        } else {
                          var result = await Navigator.push(context, MaterialPageRoute(builder: (builder) => SelectedUser(type: 'C')));

                          if (result.userID == widget.state.athlete.userID) {
                            showToast("O responsável pelo treino, não pode ser o próprio atleta");
                          } else {
                            if (result != null) {
                              setState(() {
                                widget.state.setControlResponsible(result);
                              });
                            }
                          }
                        }
                      },
                      readOnly: true,
                      controller: widget.state.controllerControlResponsible,
                      hint: "Responsável pelo controle do tempo",
                      text: "Responsável",
                      inputType: TextInputType.text,
                      getColorValidator: Util.existStringInList(
                          widget.state.errors, 'controlResponsible')
                          ? MyColors.error
                          : MyColors.gray),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFieldCustom(
                      controller: widget.state.controllerLastRound,
                      text: "Quantidade metros última volta",
                      hint: "Informe o quantidade",
                      inputType: const TextInputType.numberWithOptions(signed: false, decimal: false),
                      getColorValidator: Util.existStringInList(
                          widget.state.errors, 'lastRound')
                          ? MyColors.error
                          : MyColors.gray),
                  const SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CheckboxCustom(
                          title: "A última volta foi completa?",
                          onPressed: () {
                            setState(() {
                              widget.state.lastRoundCompleted = !widget.state.lastRoundCompleted;
                            });
                          },
                          isCheck: widget.state.lastRoundCompleted),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text("Tempos a cada 100 metros", style: TextStyle(
                      fontSize: 16,
                      color: MyColors.black,
                      fontWeight: FontWeight.w400),),
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.state.timers.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Tempo: ${i + 1}: ${widget.state.timers[i].minutes}:${widget.state.timers[i].seconds}:${widget.state.timers[i].milliseconds}",
                                style: const TextStyle(fontSize: 16),
                              ),
                              IconButton(onPressed: () {
                                setState(() {
                                  widget.state.timers.removeAt(i);
                                });
                              }, icon: const Icon(Icons.close, color: Colors.red,))
                            ],
                          ),
                        );
                      }),
                  const SizedBox(height: 20,),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '$minutes:$seconds:$milliseconds',
                        style: const TextStyle(fontSize: 22.0),
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              if (_stopwatch.isRunning) {
                                _stopwatch.stop();
                              } else {
                                _stopwatch.start();
                              }
                              setState(() {
                                _isRunning = !_isRunning;
                              });
                            },
                            child: Text(_isRunning ? 'Pausar' : 'Iniciar'),
                          ),
                          const SizedBox(width: 20.0),
                          ElevatedButton(
                            onPressed: () {
                              if (milliseconds == "00" && minutes == "00" && seconds == "00") {
                                showToast("Não é possível adicionar tempo zerado");
                              } else {
                                setState(() {
                                  TimerModel timer = TimerModel(
                                      seconds: seconds, minutes: minutes, milliseconds: milliseconds);

                                  widget.state.timers.add(timer);
                                });
                              }
                            },
                            child: const Text('Adicionar'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 80),
                  ButtonCustom(
                      title: "Salvar",
                      onPressed: () async {
                        setState(() {
                          widget.state.isLoading = true;
                        });

                        bool res = await widget.state.saveTraining();

                        setState(() {
                          widget.state.isLoading = false;
                        });

                        if (res) {
                          Navigator.pop(context);
                        }
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

  static InputBorder _border(Color borderColor) => OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(width: 1.5, color: borderColor),
  );
}
