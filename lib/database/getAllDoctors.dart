import 'dart:convert';
import 'package:seizure_deck/data/doctor.dart';

import 'package:seizure_deck/globals.dart' as globals;
import 'package:http/http.dart' as http;


class getAllDoctors {
  List<Doctor> doctorsList = [];

  Future<void> getDoctors() async {
    final url = Uri.parse('${globals.dbstart_url}get_doctors.php');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // Parse the JSON response
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        // Check for success status
        if (responseData['status'] == 'success') {
          // Convert the JSON array 'data' to a list of Doctor objects
          final List<dynamic> doctorsData = responseData['data'];
          doctorsList = doctorsData.map((json) => Doctor.fromJson(json)).toList();

          // Now doctorsList contains all the doctors
          // You can use doctorsList for further operations
        }
      } else {
        // Handle server error
        print('Server Error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions
      print('Error: $e');
    }
  }
}