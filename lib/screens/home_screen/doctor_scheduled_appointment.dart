import 'package:flutter/material.dart';
import 'package:seizure_deck/data/user_appointments.dart';
import 'package:seizure_deck/database/get_doctors_scheduled_appointment.dart';
import 'package:seizure_deck/screens/home_screen/detailed_doctor_appointment.dart';

class DoctorScheduledAppointment extends StatefulWidget {
  const DoctorScheduledAppointment({super.key});

  @override
  State<DoctorScheduledAppointment> createState() => _DoctorScheduledAppointmentState();
}

class _DoctorScheduledAppointmentState extends State<DoctorScheduledAppointment> {

  GetDoctorsScheduledAppointment api = GetDoctorsScheduledAppointment();
  List<Appointments> appointment_list = [];

  @override
  void initState() {
    super.initState();
    fetchAppointments();
  }

  void fetchAppointments() async {
    try {
      await api.doctorsappointments();
      setState(() {
        appointment_list = api.doctors_appointments;
      });
      // Do something with the appointments list, like displaying it in a ListView
    } catch (e) {
      // Handle any errors
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Scheduled Appointments",
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: appointment_list.length,
            itemBuilder: (context, index) {
              final appointments = appointment_list[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DetailedDoctorAppointment(appointments: appointments))
                  );
                },
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Patient: ${appointments.patient_name}",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 18.0
                              ),
                            ),
                            SizedBox(height: 10.0,),
                            Text(
                              "Appointment Date: ${appointments.appointment_date.split(' ')[0]}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17.0
                              ),
                            ),

                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
