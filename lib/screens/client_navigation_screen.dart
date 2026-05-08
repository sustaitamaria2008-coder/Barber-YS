import 'package:flutter/material.dart';

import 'client_screen.dart';
import 'appointments_screen.dart';
import 'works_screen.dart';
import 'profile_screen.dart';
import 'info_screen.dart';

class ClientNavigationScreen extends StatefulWidget {
  const ClientNavigationScreen({super.key});

  @override
  State<ClientNavigationScreen> createState() => _ClientNavigationScreenState();
}

class _ClientNavigationScreenState extends State<ClientNavigationScreen> {
  int currentIndex = 0;

  final List<Widget> screens = [
    const ClientScreen(),
    const AppointmentScreen(),
    const WorksScreen(),
    const ProfileScreen(),
    const InfoScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        backgroundColor: const Color(0xFF111111),

        selectedItemColor: const Color(0xFF7B1113),

        unselectedItemColor: Colors.white54,

        type: BottomNavigationBarType.fixed,

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),

          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "Citas",
          ),

          BottomNavigationBarItem(icon: Icon(Icons.cut), label: "Cortes"),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: "Info"),
        ],
      ),
    );
  }
}
