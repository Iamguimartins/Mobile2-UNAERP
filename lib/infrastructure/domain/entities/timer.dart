class TimerModel {
  String minutes;
  String seconds;
  String milliseconds;

  TimerModel({required this.seconds, required this.minutes, required this.milliseconds});

  Map<String, dynamic> toMap() {
    return {
      'minutes': minutes,
      'seconds': seconds,
      'milliseconds': milliseconds
    };
  }
}