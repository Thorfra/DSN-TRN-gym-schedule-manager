import 'package:flutter/material.dart';
import 'elenco_schede.dart';
import 'crea_mod_schede.dart';

void main() {
  runApp(const MaterialApp(home: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text("Home page"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Image(
              image: AssetImage('assets/image/logo/logo.png'),
              width: 128,
              height: 128),
          SizedBox(height: 5),
          ElevatedButton.icon(
            icon: Icon(Icons.arrow_forward),
            label: Text("Vai alle schede"),
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Elenco_schede()));
            },
          ),
          SizedBox(height: 5),
          ElevatedButton.icon(
            icon: Icon(Icons.arrow_forward),
            label: Text("Crea o modifica schede"),
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Crea_mod_schede()));
            },
          ),
        ]),
      ),
    );
  }
}
