import 'package:flutter/material.dart';
import 'package:seizure_deck/data/user_appointments.dart';
import 'package:seizure_deck/database/get_all_appointments.dart';
import 'package:seizure_deck/screens/home_screen/detailed_user_appointment.dart';

class PreviousAppointments extends StatefulWidget {
  const PreviousAppointments({super.key});

  @override
  State<PreviousAppointments> createState() => _PreviousAppointmentsState();
}

class _PreviousAppointmentsState extends State<PreviousAppointments> {
  List<Appointments> user_appointments = [];

  @override
  void initState() {
    super.initState();
    _fetchAppointments();
  }

  Future<void> _fetchAppointments() async {
    final getAllAppointmentsForUser appointmentFetcher = getAllAppointmentsForUser();
    await appointmentFetcher.fetchAllAppointments();
    setState(() {
      user_appointments = appointmentFetcher.user_appointments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: user_appointments.isEmpty
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
          shrinkWrap: true,
          itemCount: user_appointments.length,
          itemBuilder: (context, index) {
            final appointments = user_appointments[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => DetailedUserAppointment(appointments: appointments))
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
                            "Dr. ${appointments.doctor_name}",
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
          }
      ),
    );
  }
}
