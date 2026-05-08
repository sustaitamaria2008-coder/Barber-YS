import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/appointment_model.dart';

class AppointmentProvider extends ChangeNotifier {
  List<Appointment> _appointments = [];

  List<Appointment> get appointments => _appointments;

  AppointmentProvider() {
    loadAppointments();
  }

  Future<void> addAppointment(Appointment appointment) async {
    _appointments.add(appointment);

    await saveAppointments();

    notifyListeners();
  }

  Future<void> removeAppointment(int index) async {
    _appointments.removeAt(index);

    await saveAppointments();

    notifyListeners();
  }

  Future<void> saveAppointments() async {
    final prefs = await SharedPreferences.getInstance();

    List<String> appointmentsJson = _appointments
        .map((appt) => jsonEncode(appt.toMap()))
        .toList();

    await prefs.setStringList('appointments', appointmentsJson);
  }

  Future<void> loadAppointments() async {
    final prefs = await SharedPreferences.getInstance();

    final appointmentsJson = prefs.getStringList('appointments');

    if (appointmentsJson != null) {
      _appointments = appointmentsJson
          .map((item) => Appointment.fromMap(jsonDecode(item)))
          .toList();

      notifyListeners();
    }
  }
}
