import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  double progress = 0;

  @override
  void initState() {
    super.initState();

    startLoading();
  }

  void startLoading() async {
    for (int i = 0; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 35));

      setState(() {
        progress = i / 100;
      });
    }

    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // LOGO
              Container(
                padding: const EdgeInsets.all(15),

                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  borderRadius: BorderRadius.circular(30),

                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF7B1113).withOpacity(0.5),
                      blurRadius: 25,
                      spreadRadius: 2,
                    ),
                  ],
                ),

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),

                  child: Image.asset(
                    "assets/images/logo_ys.png",
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 30),

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
                "Elegancia y estilo",
                style: GoogleFonts.poppins(color: Colors.white70, fontSize: 15),
              ),

              const SizedBox(height: 60),

              // BARRA ESTILO BARBER POLE
              Stack(
                children: [
                  // fondo
                  Container(
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),

                  // progreso
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),

                    height: 16,

                    width: MediaQuery.of(context).size.width * 0.75 * progress,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),

                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF000000),
                          Color(0xFF7B1113),
                          Color.fromARGB(255, 255, 255, 255),
                          Color.fromARGB(255, 0, 0, 0),
                          Color(0xFF7B1113),
                          Color.fromARGB(255, 255, 255, 255),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              Text(
                "${(progress * 100).toInt()}%",
                style: GoogleFonts.poppins(color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
