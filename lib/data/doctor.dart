class Doctor {
  final int doctorId;
  final String name;
  final String pmdcNo;
  final String contactNo;
  final String email;
  final String password;
  final String availabilityDays;
  final String availabilityTime;
  final String workingAddress;
  final String optionalWorkingAddress;
  final int cnic;
  final String specialization;

  Doctor({
    required this.doctorId,
    required this.name,
    required this.pmdcNo,
    required this.contactNo,
    required this.email,
    required this.password,
    required this.availabilityDays,
    required this.availabilityTime,
    required this.workingAddress,
    required this.optionalWorkingAddress,
    required this.cnic,
    required this.specialization,
  });

  // Factory method to create a Doctor object from JSON
  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      doctorId: json['doctor_id'],
      name: json['name'],
      pmdcNo: json['pmdc_no'],
      contactNo: json['contact_no'],
      email: json['email'],
      password: json['password'],
      availabilityDays: json['availability_days'],
      availabilityTime: json['availability_time'],
      workingAddress: json['working_address'],
      optionalWorkingAddress: json['optional_working_address'],
      cnic: json['cnic'],
      specialization: json['specialization'],
    );
  }
}
