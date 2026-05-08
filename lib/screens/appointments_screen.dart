import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/appointment_provider.dart';
import '../models/appointment_model.dart';
import '../providers/auth_provider.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final nameController = TextEditingController();
  final serviceController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();

  void saveAppointment() {
    if (nameController.text.isEmpty ||
        serviceController.text.isEmpty ||
        dateController.text.isEmpty ||
        timeController.text.isEmpty) {
      return;
    }

    final auth = Provider.of<AuthProvider>(context, listen: false);

    final appointment = Appointment(
      userEmail: auth.user?.email ?? "",
      name: nameController.text,
      service: serviceController.text,
      date: dateController.text,
      time: timeController.text,
    );

    Provider.of<AppointmentProvider>(
      context,
      listen: false,
    ).addAppointment(appointment);

    nameController.clear();
    serviceController.clear();
    dateController.clear();
    timeController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Cita guardada correctamente")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppointmentProvider>(context);
    final auth = Provider.of<AuthProvider>(context);

    final appointments = auth.isAdmin
        ? provider.appointments
        : provider.appointments
              .where((appt) => appt.userEmail == auth.user?.email)
              .toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Citas")),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Nombre"),
            ),
            TextField(
              controller: serviceController,
              decoration: const InputDecoration(labelText: "Servicio"),
            ),
            TextField(
              controller: dateController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: "Fecha",
                suffixIcon: Icon(Icons.calendar_today),
              ),
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2024),
                  lastDate: DateTime(2100),
                );

                if (picked != null) {
                  dateController.text =
                      "${picked.day}/${picked.month}/${picked.year}";
                }
              },
            ),
            TextField(
              controller: timeController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: "Hora",
                suffixIcon: Icon(Icons.access_time),
              ),
              onTap: () async {
                TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (picked != null) {
                  timeController.text = picked.format(context);
                }
              },
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () async {
                saveAppointment();
              },
              child: const Text("Guardar cita"),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  final appt = appointments[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A1A),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFF7B1113),
                        width: 1,
                      ),
                    ),
                    child: ListTile(
                      title: Text("${appt.name} - ${appt.service}"),
                      subtitle: Text(
                        "${appt.date} | ${appt.time}\n${appt.userEmail}",
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          provider.removeAppointment(index);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
