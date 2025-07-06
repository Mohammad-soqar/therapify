class ScheduleModel {
  final String day;
  final String date;
  final List<String> timeSlots;

  ScheduleModel({
    required this.day,
    required this.date,
    required this.timeSlots,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      day: json['day'],
      date: json['date'],
      timeSlots: List<String>.from(json['timeSlots'] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
        'day': day,
        'date': date,
        'timeSlots': timeSlots,
      };
}
