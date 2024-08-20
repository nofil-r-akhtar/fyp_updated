import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:seizure_deck/data/user_appointments.dart';
import 'package:seizure_deck/globals.dart' as globals;
import 'package:http/http.dart' as http;

class GetDoctorsScheduledAppointment {
  List<Appointments> doctors_appointments = [];

  Future<void> doctorsappointments() async {
    final url = Uri.parse("${globals.dbstart_url}get_doctor_appointments.php?doctor_id=${globals.id}");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          List<dynamic> appointmentsJson = responseData['data'];
          doctors_appointments = appointmentsJson.map((json) => Appointments.fromJson(json)).toList();
        } else {
          throw Exception('Failed to load appointments');
        }
      } else {
        throw Exception('Failed to connect to the server');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }
}
