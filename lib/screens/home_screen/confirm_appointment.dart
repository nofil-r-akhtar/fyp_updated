import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:seizure_deck/data/doctor.dart';
import 'package:seizure_deck/database/set_doctor_appointment.dart';
import 'package:seizure_deck/globals.dart' as globals;

class ConfirmAppointment extends StatefulWidget {
  final Doctor doctor;

  const ConfirmAppointment({super.key, required this.doctor});

  @override
  State<ConfirmAppointment> createState() => _ConfirmAppointmentState();
}

class _ConfirmAppointmentState extends State<ConfirmAppointment> {
  SetDoctorAppointment setup = SetDoctorAppointment();

  late TextEditingController doctor_id;
  late TextEditingController doctor_name;
  late TextEditingController patient_id ;
  late TextEditingController patient_name;
  late TextEditingController appointment_date;
  String? selectedAddress;

  List<String> address =[];

  DateTime? _selectedDate;

  Future<void> _selectDate() async {
    DateTime now = DateTime.now();
    DateTime initialDate = _selectedDate ?? now;
    DateTime firstAvailableDate = DateTime.now(); // Replace with actual logic if needed

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstAvailableDate,
      lastDate: DateTime(2101), // Set a future date limit if needed
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Theme.of(context).primaryColor,
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        appointment_date.text = "${_selectedDate!.toLocal()}".split(' ')[0]; // Format the date as needed
      });
    }
  }

  void _submitAppointment() {
    if (selectedAddress != null &&
        patient_name.text.isNotEmpty &&
        appointment_date.text.isNotEmpty) {
      setup.setDoctorAppointment(
        userId: patient_id.text,
        doctorId: doctor_id.text,
        patientName: patient_name.text,
        doctorName: doctor_name.text,
        appointmentDate: appointment_date.text,
        address: selectedAddress!,
      );
    } else {
      // Handle form validation or display an error message
      Fluttertoast.showToast(
          msg: "All Fields are required",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

  @override
  void initState() {
    super.initState();
    doctor_id = TextEditingController(text: widget.doctor.doctorId.toString());
    doctor_name = TextEditingController(text: "Dr. ${widget.doctor.name}");
    patient_id = TextEditingController(text: globals.id.toString());
    patient_name = TextEditingController();
    appointment_date = TextEditingController();

    address = [
      widget.doctor.workingAddress,
      widget.doctor.optionalWorkingAddress
    ];
  }

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
        child: Container(
          width: width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextyField(
                        cntrller: doctor_id,
                        label: "Doctor id",
                        typeable: false,
                        seeText: true,
                      ),
                    ),
                    SizedBox(width: 10), // Add some spacing between the fields
                    Expanded(
                      child: TextyField(
                        cntrller: doctor_name,
                        label: "Doctor Name",
                        typeable: false,
                        seeText: false,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20), // Add some spacing between rows
                Row(
                  children: [
                    Expanded(
                      child: TextyField(
                        cntrller: patient_id,
                        label: "Patient id",
                        typeable: false,
                        seeText: true,
                      ),
                    ),
                    SizedBox(width: 10), // Add some spacing between the fields
                    Expanded(
                      child: TextyField(
                        cntrller: patient_name,
                        label: "Patient Name",
                        typeable: true,
                        seeText: false,
                      ),
                    ),
                  ],
                ),
                TextField(
                  controller: appointment_date,
                  readOnly: true,
                  onTap: _selectDate,
                  decoration: InputDecoration(
                    hintText: 'Select Appointment Date',
                    hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 0.5,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                DropdownButtonFormField<String>(
                  value: selectedAddress,
                  hint: Text('Select Address'),
                  items: address.map((String address) {
                    return DropdownMenuItem<String>(
                      value: address,
                      child: Text(address),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedAddress = newValue;
                    });
                  },
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50.0,),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: _submitAppointment,
                    child: Container(
                      width: 100.0,
                      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextyField extends StatelessWidget {
  final TextEditingController cntrller;
  final bool typeable;
  final bool seeText;
  final String label;
  const TextyField({super.key, required this.cntrller, required this.typeable, required this.seeText, required this.label});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: cntrller,
      readOnly: !typeable, // Ensure typeable works as intended
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 13.0,
      ),
      decoration: InputDecoration(
        hintText: label,
        hintStyle: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2.0,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 0.5,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2.0,
          ),
        ),
      ),
      obscureText: seeText,
    );
  }
}
