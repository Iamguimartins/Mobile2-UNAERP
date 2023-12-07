import 'package:flutter/material.dart';
import 'package:trabalho_faculdade/infrastructure/domain/entities/training.dart';
import 'package:trabalho_faculdade/utils/timer.dart';

class CardTraining extends StatelessWidget {
  CardTraining({Key? key, required this.trainingModel}) : super(key: key);

  TrainingModel trainingModel;


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Estilo do Treino: ${trainingModel.style}', style: const TextStyle(fontSize: 16)),
            Text('Número do Treino: ${trainingModel.number}', style: const TextStyle(fontSize: 16)),
            Text('Atleta: ${trainingModel.athlete.name}', style: const TextStyle(fontSize: 16)),
            Text('Data do Treino: ${trainingModel.date}', style: const TextStyle(fontSize: 16)),
            Text('Frequência Cardíaca Início: ${trainingModel.frequencyStart}', style: const TextStyle(fontSize: 16)),
            Text('Frequência Cardíaca Final: ${trainingModel.frequencyEnd}', style: const TextStyle(fontSize: 16)),
            const Text('Tempos por 100 Metros (até 30 minutos):', style: TextStyle(fontSize: 16)),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: trainingModel.timeBy100!.length,
              itemBuilder: (context, index) {
                final time = trainingModel.timeBy100![index];
                final status = time < 0.8 * trainingModel.frequencyEnd!
                    ? 'Abaixo da Média'
                    : time <= 1.2 * trainingModel.frequencyEnd!
                    ? 'Na Média'
                    : 'Acima da Média';

                return ListTile(
                  title: Text('Tempo: ${index + 1}: ${getTimeToString(time)}'),
                  subtitle: Text('Status: $status'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
