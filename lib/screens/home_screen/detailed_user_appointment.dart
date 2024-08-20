import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seizure_deck/data/user_appointments.dart';
import 'package:seizure_deck/database/cancel_appointment.dart';
import 'package:seizure_deck/database/complete_appointment.dart';

class DetailedUserAppointment extends StatefulWidget {
  final Appointments appointments;
  const DetailedUserAppointment({super.key, required this.appointments});

  @override
  State<DetailedUserAppointment> createState() => _DetailedUserAppointmentState();
}

class _DetailedUserAppointmentState extends State<DetailedUserAppointment> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          height: height,
          width: width,
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Values(
                      text: widget.appointments.doctor_name,
                    color: Theme.of(context).primaryColor,
                    underline: true,
                  ),
                  Row(
                    children: [
                      Values(text: "Status: ", color: Theme.of(context).primaryColor, underline: false,),
                      Values(
                          text: widget.appointments.status,
                        color: widget.appointments.status == 'booked' ? Colors.blue : widget.appointments.status == 'completed' ? Colors.green : Colors.red,
                        underline: true,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.0,),
              Values(
                  text: "Appointment Date: ${widget.appointments.appointment_date.split(" ")[0]}",
                  color: Theme.of(context).primaryColor,
                  underline: true),
              SizedBox(height: 15.0,),
              Values(text: widget.appointments.appointmeent_address, color: Theme.of(context).primaryColor, underline: true),

              SizedBox(height: 80.0,),
              Visibility(
                visible: widget.appointments.status == 'booked',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        CancelAppointment cancel = CancelAppointment();
                        cancel.cancelAppointment(widget.appointments.appointment_id, widget.appointments.user_id, widget.appointments.doctor_id);
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8.0)
                        ),
                        alignment: Alignment.center,
                        child: Center(
                          child: Text(
                            "Cancel\nAppointment",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        CompleteAppointment complete = CompleteAppointment();
                        complete.completeAppointment(widget.appointments.appointment_id, widget.appointments.user_id, widget.appointments.doctor_id);
                        Navigator.pop(context);
                        },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        alignment: Alignment.center,
                        child: Center(
                          child: Text(
                            "Complete\nAppointment",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class Values extends StatelessWidget {
  final String text;
  final Color color;
  final bool underline;
  const Values({super.key, required this.text, required this.color, required this.underline});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: underline ? Border(
          bottom: BorderSide(
            color: Theme.of(context).primaryColor, // Set the color of the underline
            width: 2.0,         // Set the thickness of the underline
          ),
        ) : null,
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 18.0
        ),
      ),
    );
  }
}
