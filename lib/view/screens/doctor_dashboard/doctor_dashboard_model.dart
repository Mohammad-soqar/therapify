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
  final String patientName;
  final DateTime dateTime;

  Appointment({
    required this.id,
    required this.patientName,
    required this.dateTime,
  });
}

class DashboardStats {
  final int totalPatients;
  final int totalAppointments;
  final double totalEarnings;
  final bool isAvailable;

  DashboardStats({
    required this.totalPatients,
    required this.totalAppointments,
    required this.totalEarnings,
    required this.isAvailable,
  });
}
