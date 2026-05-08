import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/contact_screen.dart';
import 'screens/gallery_screen.dart';
import 'screens/appointments_screen.dart';
import '../providers/appointment_provider.dart';
import 'providers/work_provider.dart';
import 'screens/works_screen.dart';
import 'providers/profile_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => AppointmentProvider()),
        ChangeNotifierProvider(create: (_) => WorkProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Barbería App',
        theme: ThemeData(
          brightness: Brightness.dark,

          scaffoldBackgroundColor: const Color(0xFF0D0D0D),

          colorScheme: const ColorScheme.dark(primary: Color(0xFF7B1113)),

          appBarTheme: AppBarTheme(
            backgroundColor: const Color(0xFF111111),
            centerTitle: true,
            elevation: 0,
            titleTextStyle: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),

          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7B1113),
              foregroundColor: Colors.white,

              elevation: 8,

              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),

              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: const Color(0xFF1A1A1A),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: Color(0xFF7B1113), width: 2),
            ),

            labelStyle: const TextStyle(color: Colors.white70),
          ),
        ),
        home: const SplashScreen(),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/home': (context) => const HomeScreen(),
          '/contact': (context) => const ContactScreen(),
          '/gallery': (context) => const GalleryScreen(),
          '/appointments': (context) => const AppointmentScreen(),
          '/works': (context) => const WorksScreen(),
        },
      ),
    );
  }
}
