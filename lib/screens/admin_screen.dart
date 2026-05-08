import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/appointment_provider.dart';
import '../providers/work_provider.dart';
import 'dart:io';

import '../providers/profile_provider.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    final appointments = Provider.of<AppointmentProvider>(context);

    final works = Provider.of<WorkProvider>(context);
    final profile = Provider.of<ProfileProvider>(context);

    final email = auth.user?.email ?? "";

    profile.loadProfileImage(email);

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),

      appBar: AppBar(title: const Text("Panel Admin")),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // BIENVENIDA
              Container(
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),

                  gradient: const LinearGradient(
                    colors: [Color(0xFF7B1113), Color(0xFF3A0A0B)],
                  ),
                ),

                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 35,

                      backgroundImage: profile.imagePath != null
                          ? FileImage(File(profile.imagePath!))
                          : NetworkImage(auth.user?.photoUrl ?? "")
                                as ImageProvider,
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            "Administrador",

                            style: GoogleFonts.poppins(color: Colors.white70),
                          ),

                          Text(
                            auth.user?.displayName ?? "",

                            style: GoogleFonts.poppins(
                              color: Colors.white,

                              fontSize: 20,

                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              Text(
                "Resumen",

                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // ESTADISTICAS
              Row(
                children: [
                  Expanded(
                    child: statCard(
                      "Citas",
                      appointments.appointments.length.toString(),
                      Icons.calendar_month,
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: statCard(
                      "Cortes",
                      works.works.length.toString(),
                      Icons.cut,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              Text(
                "Acciones rápidas",

                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              actionCard(
                context,
                "Gestionar citas",
                "Ver citas agendadas",
                Icons.calendar_today,
                () {
                  Navigator.pushNamed(context, '/appointments');
                },
              ),

              actionCard(
                context,
                "Publicar cortes",
                "Subir nuevos trabajos",
                Icons.photo_library,
                () {
                  Navigator.pushNamed(context, '/works');
                },
              ),

              actionCard(
                context,
                "Galería",
                "Administrar publicaciones",
                Icons.collections,
                () {
                  Navigator.pushNamed(context, '/works');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget statCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),

        borderRadius: BorderRadius.circular(20),

        border: Border.all(color: const Color(0xFF7B1113)),
      ),

      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 35),

          const SizedBox(height: 10),

          Text(
            value,

            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          Text(title, style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  Widget actionCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        margin: const EdgeInsets.only(bottom: 15),

        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),

          borderRadius: BorderRadius.circular(20),
        ),

        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(15),

              decoration: BoxDecoration(
                color: const Color(0xFF7B1113),

                borderRadius: BorderRadius.circular(15),
              ),

              child: Icon(icon, color: Colors.white),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    title,

                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(subtitle, style: const TextStyle(color: Colors.white70)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
