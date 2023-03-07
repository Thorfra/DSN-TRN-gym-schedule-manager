import 'package:flutter/material.dart';
import 'pagine/elenco_schede.dart';
import 'pagine/crea_mod_schede.dart';

void main() {
  runApp(const MaterialApp(
    home: MainApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: const Text("Home page"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Image(
            image: AssetImage('assets/images/logo/2.0x/logo.png'),
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
                      builder: (context) => const Elenco_schede()));
            },
          ),
          const SizedBox(height: 5),
          ElevatedButton.icon(
            icon: const Icon(Icons.arrow_forward),
            label: const Text("Crea o modifica schede"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Crea_mod_schede()));
            },
          ),
        ]),
      ),
    );
  }
}
