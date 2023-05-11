import 'package:bilgiyarismasi2023/hakkinda.dart';
import 'package:bilgiyarismasi2023/sorular.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        //'/':(context)=>MyHomePage(title: "Anasayfa",),
        '/hakkinda': (context) => Hakkinda(),
      },
      home: const MyHomePage(title: 'e-Sınav'),
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
  String adSoyad = '';
  String ogrNo = '';

  void kontrol() {
    if ((adSoyad.length > 9) && (ogrNo.length == 9)) {
      var data = [];
      data.add(adSoyad);
      data.add(ogrNo);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Sorular(),
              settings: RouteSettings(
                arguments: data,
              )));

      //Navigator.pushNamed(context, '/sorular');
    } else {
      Navigator.pushNamed(context, '/hata');
    }
  }

  void _adSoyadKaydet(String text) {
    setState(() {
      adSoyad = text;
    });
  }

  void _ogrNoKaydet(String text) {
    setState(() {
      ogrNo = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool butonpasif = true;
    if ((adSoyad.length > 9) && (ogrNo.length == 9)) {
      butonpasif = false;
    } else {
      butonpasif = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Adınız Soyadınız:',
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (text) {
                  _adSoyadKaydet(text);
                },
                decoration: const InputDecoration(
                    hintText: 'Adınızı ve Soyadınızı giriniz'),
                keyboardType: TextInputType.text,
                inputFormatters: [
                  FilteringTextInputFormatter.singleLineFormatter
                ],
              ),
            ),
            Text(
              'Öğrenci Numaranız:',
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (text) {
                  _ogrNoKaydet(text);
                },
                decoration: const InputDecoration(
                    hintText: 'Öğrenci numaranızı giriniz'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: butonpasif ? null : kontrol,
                  child: Text('Sınava Başla')),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Hakkinda()));
                  },
                  child: Text('Hakkında')),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
