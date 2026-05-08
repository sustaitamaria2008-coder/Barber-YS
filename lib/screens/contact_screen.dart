import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  Future<void> openUrl(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw "No se pudo abrir el enlace";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contacto"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.chat),
              title: const Text("WhatsApp"),
              subtitle: const Text("Enviar mensaje"),
              onTap: () {
                openUrl("https://wa.me/5214440000000");
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text("Ubicación"),
              subtitle: const Text("Abrir Google Maps"),
              onTap: () {
                openUrl(
                  "https://www.google.com/maps/search/?api=1&query=Barberia",
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.facebook),
              title: const Text("Facebook"),
              subtitle: const Text("Abrir página"),
              onTap: () {
                openUrl("https://facebook.com");
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Instagram"),
              subtitle: const Text("Abrir Instagram"),
              onTap: () {
                openUrl("https://instagram.com");
              },
            ),
          ],
        ),
      ),
    );
  }
}
