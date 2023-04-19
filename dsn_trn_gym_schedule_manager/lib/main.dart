import 'package:dsn_trn_gym_schedule_manager1/themes.dart';
import 'package:flutter/material.dart';
import 'pagine/crea_mod_schede.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeClass.lightTheme,
      darkTheme: ThemeClass.darkTheme,
      themeMode: ThemeMode.system,
      home: const MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home page"),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Image(
            image: AssetImage('assets/images/logo/logo256x256.png'),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            label: const Text(
              "Vai alle schede",
              style: TextStyle(fontSize: 16),
            ),
            icon: const Icon(Icons.arrow_forward),
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
