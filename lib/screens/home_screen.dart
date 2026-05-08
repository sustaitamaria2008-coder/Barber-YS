import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

import 'biometric_screen.dart';
import 'client_navigation_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    if (auth.isAdmin) {
      return const BiometricScreen();
    } else {
      return const ClientNavigationScreen();
    }
  }
}
