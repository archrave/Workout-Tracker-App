import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './screens/getting_started.dart';
import './screens/auth_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Workout Tracker',
      theme: ThemeData(
        // primarySwatch: Colors.red,
        primaryColor: const Color(0xffEB5050),
        colorScheme: const ColorScheme.light().copyWith(
          secondary: const Color(0xFF1B90E5),
        ),
        textTheme: TextTheme(
          bodyLarge:
              GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.w600),
          bodyMedium: GoogleFonts.poppins(fontSize: 20),
          bodySmall: GoogleFonts.poppins(fontSize: 16),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xffEB5050),
            textStyle: Theme.of(context).textTheme.bodyMedium,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
      home: const GettingStartedScreen(),
      routes: {
        // '/': (ctx) => GettingStartedScreen(),
        // GettingStartedScreen.routeName: (ctx) => GettingStartedScreen(),
        AuthScreen.routeName: (ctx) => const AuthScreen(),
      },
    );
  }
}
