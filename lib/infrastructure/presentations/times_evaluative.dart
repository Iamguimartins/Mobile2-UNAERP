import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trabalho_faculdade/infrastructure/domain/entities/timer.dart';

class TimesEvaluative extends StatefulWidget {
  TimesEvaluative({Key? key, required this.timers}) : super(key: key);

  List<TimerModel> timers;

  @override
  State<TimesEvaluative> createState() => _TimesEvaluativeState();
}

class _TimesEvaluativeState extends State<TimesEvaluative> {
  late Stopwatch _stopwatch;
  late Timer _timer;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    _timer = Timer.periodic(const Duration(seconds: 1), _updateTimer);
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
    final hours = _stopwatch.elapsed.inHours.toString().padLeft(2, '0');
    final minutes =
        (_stopwatch.elapsed.inMinutes % 60).toString().padLeft(2, '0');
    final seconds =
        (_stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, '0');

    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop(widget.timers);
        return Future.value(false);
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Tempos de treino'),
            elevation: 0,
            centerTitle: true,
          ),
          body: ListView(
            shrinkWrap: true,
            children: [
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.timers.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          height: 20,
                          child: Text(
                            "Tempo: ${i + 1}: ${widget.timers[i].hours}:${widget.timers[i].minutes}:${widget.timers[i].secounds}",
                            style: const TextStyle(fontSize: 16),
                          )),
                    );
                  }),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '$hours:$minutes:$seconds',
                    style: const TextStyle(fontSize: 48.0),
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
                          _stopwatch.reset();
                          setState(() {});
                        },
                        child: const Text('Reiniciar'),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        TimerModel timer = TimerModel(
                            hours: hours, secounds: seconds, minutes: minutes);
                        widget.timers.add(timer);
                        _stopwatch.reset();
                      });
                    },
                    child: const Text('Adicionar'),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
