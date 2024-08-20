import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:seizure_deck/globals.dart' as globals;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import '../colors.dart';

class CompleteAppointment {
  
  Future<void> completeAppointment(String appointment_id, String user_id, String doctor_id) async {
    final url = Uri.parse("${globals.dbstart_url}complete_appointment.php");

    try{
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          "appointment_id": appointment_id,
          "user_id": user_id,
          "doctor_id": doctor_id,
        },
      );

      if (response.statusCode == 200) {
        // Parse the JSON response
        final responseData = json.decode(response.body);

        // Check the status and show a toast message accordingly
        if (responseData['status'] == 'success') {
          Fluttertoast.showToast(
            msg: responseData['message'], // e.g., "Appointment cancelled successfully"
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: primaryColor,
            textColor: Colors.white,
          );
        } else {
          Fluttertoast.showToast(
            msg: responseData['message'] ?? 'Something went wrong.', // Show the error message from the response
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: 'Failed to cancel appointment. Please try again later.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }

    } catch (e) {
      Fluttertoast.showToast(
        msg: 'An error occurred: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }
}