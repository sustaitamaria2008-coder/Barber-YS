import 'package:flutter/material.dart';
import 'admin_screen.dart';
import 'appointments_screen.dart';
import 'gallery_screen.dart';
import 'profile_screen.dart';
import 'works_screen.dart';
import 'info_screen.dart';

class AdminNavigationScreen extends StatefulWidget {
  const AdminNavigationScreen({super.key});

  @override
  State<AdminNavigationScreen> createState() => _AdminNavigationScreenState();
}

class _AdminNavigationScreenState extends State<AdminNavigationScreen> {
  int currentIndex = 0;

  final List<Widget> screens = [
    const AdminScreen(),
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

          BottomNavigationBarItem(
            icon: Icon(Icons.photo_library),
            label: "Galería",
          ),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: "Info"),
        ],
      ),
    );
  }
}
