class Appointments {
  final String appointment_id;
  final String user_id;
  final String doctor_id;
  final String patient_name;
  final String appointment_date;
  final String status;
  final String appointment_created;
  final String appointmeent_address;
  final String doctor_name;

  Appointments({
    required this.appointment_id,
    required this.user_id,
    required this.doctor_id,
    required this.patient_name,
    required this.appointment_date,
    required this.status,
    required this.appointment_created,
    required this.appointmeent_address,
    required this.doctor_name
  });

  factory Appointments.fromJson(Map<String, dynamic> json) {
    return Appointments(
      appointment_id: json['id'],
      user_id: json['user_id'],
      doctor_id: json['doctor_id'],
      patient_name: json['patient_name'],
      appointment_date: json['appointment_date'],
      status: json['status'],
      appointment_created: json['created_at'],
      appointmeent_address: json['address'],
      doctor_name: json['doctor_name']
    );
  }
}

