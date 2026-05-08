import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'admin_screen.dart';
import 'admin_navigation_screen.dart';

class BiometricScreen extends StatefulWidget {
  const BiometricScreen({super.key});

  @override
  State<BiometricScreen> createState() => _BiometricScreenState();
}

class _BiometricScreenState extends State<BiometricScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  String message = "Verificación requerida";

  Future<void> authenticate() async {
    try {
      bool canCheck = await auth.canCheckBiometrics;
      bool supported = await auth.isDeviceSupported();

      if (!canCheck && !supported) {
        setState(() {
          message = "Dispositivo no compatible con biometría";
        });
        return;
      }

      bool authenticated = await auth.authenticate(
        localizedReason: "Acceso administrador (huella o PIN)",
        options: const AuthenticationOptions(
          biometricOnly: false,
          stickyAuth: true,
        ),
      );

      if (authenticated) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const AdminNavigationScreen()),
        );
      } else {
        setState(() {
          message = "Falló la autenticación";
        });
      }
    } catch (e) {
      setState(() {
        message = "Error: $e";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    authenticate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Acceso Administrador")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.fingerprint, size: 120),
              const SizedBox(height: 15),
              Text(message, textAlign: TextAlign.center),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: authenticate,
                child: const Text("Intentar de nuevo"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
