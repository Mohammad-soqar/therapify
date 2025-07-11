class Patient {
  final String id;
  final String name;
  final int age;
  final String condition;

  Patient({
    required this.id,
    required this.name,
    required this.age,
    required this.condition,
  });
}

class Appointment {
  final String id;
  final String patientId;
  final String patientName;
  final DateTime dateTime;
   final String description;

  Appointment({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.dateTime,
    required this.description,
  });
}

class DashboardStats {
  final int totalPatients;
  final int totalAppointments;
  final bool isAvailable;

  DashboardStats({
    required this.totalPatients,
    required this.totalAppointments,
    required this.isAvailable,
  });
}
