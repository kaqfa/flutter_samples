import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var biodata = Map<String, String>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    biodata['name'] = 'Venti Genshin Impact';
    biodata['email'] = 'venti@genshinimpact.com';
    biodata['phone'] = '+62345678910';
    biodata['image'] = 'Venti_Card.png';
    biodata['hobby'] = 'Bermain Gitar';
    biodata['desc'] =
        'Karakter anemo yang suka main gitar. Berkawan baik dengan Storm Terror atau Naga bersayap empat';
    biodata['addr'] = 'St. Freeway in side of Moonstad';
  }

  Widget _header() {
    return Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.black),
        child: Text(
          biodata['name'] ?? '',
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
        ));
  }

  Widget _btn_contact(Color color, IconData icon, String url) {
    return ElevatedButton(
      onPressed: () {
        launch(url);
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white)),
      child: Icon(icon),
    );
  }

  dynamic launch(String url) async {
    // print(url);
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Tidak dapat memanggil: ${url}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _header(),
            const SizedBox(height: 30),
            Image(
              image: AssetImage('assets/${biodata['image'] ?? ''}'),
              width: 300,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                    child: _btn_contact(
                        Colors.blueAccent,
                        Icons.alternate_email,
                        "mailto:${biodata['email']}")),
                Expanded(
                    child: _btn_contact(
                        Colors.green,
                        Icons.mark_email_unread_rounded,
                        "https://wa.me/${biodata['phone']}")),
                Expanded(
                    child: _btn_contact(Colors.deepPurpleAccent, Icons.phone,
                        "tel:${biodata['phone']}"))
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                    width: 100,
                    child: const Text(
                      "- Hobby :",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )),
                Text(
                  biodata['hobby'] ?? '',
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
            Row(
              children: [
                Container(
                    width: 100,
                    child: const Text(
                      "- Alamat :",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )),
                Text(
                  biodata['addr'] ?? '',
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
            const SizedBox(height: 10),
            Container(
              color: Colors.black12,
              width: double.infinity,
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              margin: EdgeInsets.only(bottom: 10),
              alignment: Alignment.center,
              child: const Text("Deskripsi Singkat:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ),
            Text(
              biodata['desc'] ?? '',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
