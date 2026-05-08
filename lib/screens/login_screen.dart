import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              // LOGO
              Container(
                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 0, 0),

                  borderRadius: BorderRadius.circular(30),

                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF7B1113).withOpacity(0.5),

                      blurRadius: 25,
                      spreadRadius: 3,
                    ),
                  ],
                ),

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),

                  child: Image.asset(
                    "assets/images/logo_ys.png",

                    width: 130,
                    height: 130,

                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 35),

              // NOMBRE
              Text(
                "Barber YS",

                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "Elegancia y estilo premium",

                style: GoogleFonts.poppins(color: Colors.white70, fontSize: 16),
              ),

              const SizedBox(height: 60),

              // BOTÓN GOOGLE
              SizedBox(
                width: double.infinity,
                height: 60,

                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7B1113),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),

                  icon: const Icon(Icons.login, color: Colors.white),

                  label: Text(
                    "Continuar con Google",

                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  onPressed: () async {
                    await auth.loginWithGoogle();

                    if (context.mounted) {
                      Navigator.pushReplacementNamed(context, '/home');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
