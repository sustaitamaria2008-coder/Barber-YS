import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'webview_screen.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  Future<void> openUrl(String url) async {
    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),

      appBar: AppBar(title: const Text("Barber YS")),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // HEADER
              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(25),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),

                  gradient: const LinearGradient(
                    colors: [Color(0xFF7B1113), Color(0xFF3A0A0B)],
                  ),
                ),

                child: Column(
                  children: [
                    Text(
                      "Barber YS",

                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "Elegancia y estilo premium",

                      textAlign: TextAlign.center,

                      style: GoogleFonts.poppins(color: Colors.white70),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 35),

              Text(
                "Contacto y Redes",

                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // WHATSAPP
              infoCard(Icons.phone, "WhatsApp", "Enviar mensaje", () {
                openUrl("https://wa.me/526561234567");
              }),

              // MAPS
              infoCard(Icons.location_on, "Ubicación", "Abrir Google Maps", () {
                openUrl("https://maps.google.com");
              }),

              // INSTAGRAM
              infoCard(Icons.camera_alt, "Instagram", "Abrir Instagram", () {
                Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder: (_) => const WebViewScreen(
                      title: "Instagram Barber YS",

                      url: "https://instagram.com",
                    ),
                  ),
                );
              }),

              // FACEBOOK
              infoCard(Icons.facebook, "Facebook", "Abrir Facebook", () {
                Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder: (_) => const WebViewScreen(
                      title: "Facebook",

                      url: "https://facebook.com",
                    ),
                  ),
                );
              }),

              // TIKTOK
              infoCard(Icons.video_collection, "TikTok", "Abrir TikTok", () {
                Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder: (_) => const WebViewScreen(
                      title: "TikTok",

                      url: "https://tiktok.com",
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget infoCard(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        margin: const EdgeInsets.only(bottom: 18),

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
