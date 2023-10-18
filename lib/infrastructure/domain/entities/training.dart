class TrainingModel {
  String style;
  String number;
  String athlete;
  String date;
  double frequencyStart;
  double frequencyEnd;
  String controlResponsible;
  List<double> timeBy100;

  TrainingModel({
    required this.style,
    required this.number,
    required this.athlete,
    required this.date,
    required this.frequencyStart,
    required this.frequencyEnd,
    required this.controlResponsible,
    required this.timeBy100,
  });

  TrainingModel.fromJson(Map<String, dynamic> json)
      : style = json['style'],
        number = json['number'],
        athlete = json['athlete'],
        date = json['date'],
        frequencyStart = json['frequencyStart'],
        frequencyEnd = json['frequencyEnd'],
        controlResponsible = json['controlResponsible'],
        timeBy100 = List<double>.from(json['timeBy100']);

  Map<String, dynamic> toMap() {
    return {
      'style': style,
      'number': number,
      'athlete': athlete,
      'date': date,
      'frequencyStart': frequencyStart,
      'frequencyEnd': frequencyEnd,
      'controlResponsible': controlResponsible,
      'timeBy100': timeBy100,
    };
  }
}