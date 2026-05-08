class Appointment {
  final String userEmail;
  final String name;
  final String service;
  final String date;
  final String time;

  Appointment({
    required this.userEmail,
    required this.name,
    required this.service,
    required this.date,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'userEmail': userEmail,
      'name': name,
      'service': service,
      'date': date,
      'time': time,
    };
  }

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      userEmail: map['userEmail'],
      name: map['name'],
      service: map['service'],
      date: map['date'],
      time: map['time'],
    );
  }
}
