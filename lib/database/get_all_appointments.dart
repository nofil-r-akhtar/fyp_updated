import 'dart:convert';

import 'package:seizure_deck/data/user_appointments.dart';
import 'package:seizure_deck/globals.dart' as globals;
import 'package:http/http.dart' as http;

class getAllAppointmentsForUser {

  List<Appointments> user_appointments = [];

  Future<void> fetchAllAppointments() async {
    final url = Uri.parse("${globals.dbstart_url}get_user_appointments.php?user_id=${globals.id.toString()}");

    try{
      final response = await http.get(url);
      if (response.statusCode == 200) {
        dynamic responseBody = jsonDecode(response.body);
        final List<dynamic> userAppointmentsData = responseBody['data'];
        user_appointments = userAppointmentsData.map((json) => Appointments.fromJson(json)).toList();
      } else {
        // Handle server error
        print('Server Error: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }
}