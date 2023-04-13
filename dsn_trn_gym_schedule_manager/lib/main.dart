import 'package:flutter/material.dart';
import 'pagine/crea_mod_schede.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: GoogleFonts.bebasNeue().fontFamily,
      primaryColor: Colors.black,
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
    ),
    home: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text("Home page"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Image(
            image: AssetImage('assets/images/logo/2.0x/logo.jpg'),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            icon: const Icon(Icons.arrow_forward),
            label: const Text("Vai alle schede"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreaModSchede()));
            },
          ),
        ]),
      ),
    );
  }
}
