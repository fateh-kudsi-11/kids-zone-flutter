import 'package:flutter/material.dart';
import 'package:kidszone/providers/theme.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import './pages/home.dart';

class AndroidMain extends StatelessWidget {
  const AndroidMain({super.key});

  @override
  Widget build(BuildContext context) {
    final themeDark = Provider.of<ThemeManager>(context).themeMode;

    return MaterialApp(
      title: "Kids Zone",
      home: const HomePage(),
      theme: ThemeData(
        brightness: themeDark ? Brightness.dark : Brightness.light,
        useMaterial3: true,
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
    );
  }
}
