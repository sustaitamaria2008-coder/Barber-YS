import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import 'dart:io';

import '../providers/profile_provider.dart';

class ClientScreen extends StatelessWidget {
  const ClientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final profile = Provider.of<ProfileProvider>(context);

    final email = auth.user?.email ?? "";

    profile.loadProfileImage(email);

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),

      appBar: AppBar(title: const Text("Barber YS")),

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
                            "Bienvenido",
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

              // TITULO
              Text(
                "Servicios Destacados",

                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // CARDS
              serviceCard(
                "Corte Fade",
                "Estilo moderno y limpio",
                Icons.content_cut,
              ),

              serviceCard("Barba Premium", "Perfilado profesional", Icons.face),

              serviceCard("Corte + Barba", "Look completo", Icons.star),

              const SizedBox(height: 30),

              // HORARIOS
              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),

                  borderRadius: BorderRadius.circular(20),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      "Horarios",

                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Lunes - Sábado\n10:00 AM - 8:00 PM",

                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget serviceCard(String title, String subtitle, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),

        borderRadius: BorderRadius.circular(20),

        border: Border.all(color: const Color(0xFF7B1113)),
      ),

      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(15),

            decoration: BoxDecoration(
              color: const Color(0xFF7B1113),

              borderRadius: BorderRadius.circular(15),
            ),

            child: Icon(icon, color: Colors.white, size: 28),
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
    );
  }
}
