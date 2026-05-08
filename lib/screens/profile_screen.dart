import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../providers/profile_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final profile = Provider.of<ProfileProvider>(context);
    final email = auth.user?.email ?? "";

    profile.loadProfileImage(email);

    final picker = ImagePicker();

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // HEADER
            Container(
              width: double.infinity,

              padding: const EdgeInsets.only(top: 70, bottom: 40),

              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF7B1113), Color(0xFF3A0A0B)],
                ),

                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35),
                ),
              ),

              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      final picked = await picker.pickImage(
                        source: ImageSource.gallery,
                      );

                      if (picked != null) {
                        profile.setImage(email, picked.path);
                      }
                    },

                    child: CircleAvatar(
                      radius: 60,

                      backgroundColor: Colors.white,

                      backgroundImage: profile.imagePath != null
                          ? FileImage(File(profile.imagePath!))
                          : NetworkImage(auth.user?.photoUrl ?? "")
                                as ImageProvider,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    auth.user?.displayName ?? "",

                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    auth.user?.email ?? "",

                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 35),

            // INFO CARDS
            profileCard(Icons.person, "Usuario", auth.user?.displayName ?? ""),

            profileCard(Icons.email, "Correo", auth.user?.email ?? ""),

            const SizedBox(height: 40),

            // BOTÓN
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),

              child: SizedBox(
                width: double.infinity,
                height: 58,

                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7B1113),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),

                  icon: const Icon(Icons.logout, color: Colors.white),

                  label: Text(
                    "Cerrar sesión",

                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  onPressed: () async {
                    await auth.logout();

                    if (context.mounted) {
                      Navigator.pushReplacementNamed(context, '/login');
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget profileCard(IconData icon, String title, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),

        borderRadius: BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10),
        ],
      ),

      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),

            decoration: BoxDecoration(
              color: const Color(0xFF7B1113),

              borderRadius: BorderRadius.circular(15),
            ),

            child: Icon(icon, color: Colors.white),
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  title,

                  style: GoogleFonts.poppins(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  value,

                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
