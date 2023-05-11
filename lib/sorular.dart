import 'dart:async';

import 'package:bilgiyarismasi2023/bitir.dart';

import 'package:flutter/material.dart';

class Sorular extends StatefulWidget {
  const Sorular({Key? key}) : super(key: key);

  @override
  State<Sorular> createState() => _SorularState();
}

String zamaniFormatla(int milisaniye) {
  var saniye = milisaniye ~/ 1000; // ~/ Tam sayı bölme işlemidir
  var dakika = ((saniye % 3600) ~/ 60).toString().padLeft(2, '0');
  var saniyeler = (saniye % 60).toString().padLeft(2, '0');

  return "$dakika:$saniyeler";
}

class _SorularState extends State<Sorular> {
  String adSoyad = '';
  String ogrNo = '';

  int mevcutsoru = 0;
  String mevcutcevap = '';
  int puan = 0;

  int kullanilansure = 0;

  late Stopwatch _sayac;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _sayac = Stopwatch();
    _timer = new Timer.periodic(new Duration(seconds: 1), (timer) {
      setState(() {});
    });
    mevcutsoru = 0;
    mevcutcevap = '';
    puan = 0;
    kullanilansure = 0;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void BitireYolla() {
    var data = [];
    data.add(adSoyad);
    data.add(ogrNo);
    data.add(puan.toString());
    data.add(zamaniFormatla(kullanilansure));
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Bitir(),
            settings: RouteSettings(arguments: data)));
  }

  void kontrolEt() {
    if (mevcutsoru > 8) {
      mevcutsoru = 0;
      _timer.cancel();
      BitireYolla();
    } else {
      if (mevcutcevap == sorular[mevcutsoru]['dogrucevap']) {
        puan = puan + 10;
        mevcutsoru++;
        kullanilansure = kullanilansure + _sayac.elapsedMilliseconds;
        _sayac.reset();
      } else {
        puan = puan - 10;
        mevcutsoru++;
        kullanilansure = kullanilansure + _sayac.elapsedMilliseconds;
        _sayac.reset();
      }
    }
  }

  var sorular = [
    {
      'soru': 'Fatih Sultan Mehmet\'in babası kimdir?',
      'cevaplar': ['I. Mehmet', 'II. Murat', 'Yıldırım Beyazıt'],
      'dogrucevap': 'II. Murat'
    },
    {
      'soru': 'Hangi yabancı futbolcu Fenerbahçe forması giymiştir?',
      'cevaplar': ['Simoviç', 'Schumacher', 'Prekazi'],
      'dogrucevap': 'Schumacher'
    },
    {
      'soru': 'Magna Carta hangi ülkenin kralıyla yapılmış bir sözleşmedir?',
      'cevaplar': ['İngiltere', 'Fransa', 'İspanya'],
      'dogrucevap': 'İngiltere'
    },
    {
      'soru': 'Hangisi tarihteki Türk devletlerinden biri değildir?',
      'cevaplar': ['Avar Kağanlığı', 'Emevi Devleti', 'Hun İmparatorluğu'],
      'dogrucevap': 'Emevi Devleti'
    },
    {
      'soru': 'Hangi ülke Asya kıtasındadır?',
      'cevaplar': ['Madagaskar', 'Peru', 'Singapur'],
      'dogrucevap': 'Singapur'
    },
    {
      'soru':
      'ABD başkanlarından John Fitzgerald Kennedy’e suikast düzenleyerek öldüren kimdir ?',
      'cevaplar': ['Lee Harvey Oswald', 'Clay Shaw', 'Jack Ruby'],
      'dogrucevap': 'Lee Harvey Oswald'
    },
    {
      'soru':
      'Aşağıdaki hangi Anadolu takımı Türkiye Süper Liginde şampiyon olmuştur?',
      'cevaplar': ['Kocaelispor', 'Bursaspor', 'Eskişehirspor'],
      'dogrucevap': 'Bursaspor'
    },
    {
      'soru': 'Hangisi Kanuni Sultan Süleyman’ın eşidir?',
      'cevaplar': ['Safiye Sultan', 'Kösem Sultan', 'Hürrem Sultan'],
      'dogrucevap': 'Hürrem Sultan'
    },
    {
      'soru': 'Hangi hayvan memeli değildir?',
      'cevaplar': ['Penguen', 'Yunus', 'Yarasa'],
      'dogrucevap': 'Penguen'
    },
    {
      'soru': 'Osmanlı’da Lale devri hangi padişah döneminde yaşamıştır?',
      'cevaplar': ['III. Ahmet', 'IV. Murat', 'III. Selim'],
      'dogrucevap': 'III. Ahmet'
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<dynamic>? data = [];
    data = ModalRoute
        .of(context)
        ?.settings
        .arguments as List?;
    adSoyad = data![0];
    ogrNo = data[1];

    _sayac.start();
    if (_sayac.elapsedMilliseconds > 9999 && mevcutsoru < 9) {
      kullanilansure = kullanilansure + _sayac.elapsedMilliseconds;
      _sayac.reset(); //10 saniye cevap verilmezse diğer soruya geçiyor.
      mevcutsoru++;
    }

    if (mevcutsoru == 9 && _sayac.elapsedMilliseconds > 9999) {
      Future.delayed(Duration.zero, () async {
        _sayac.reset();
        _sayac.stop();
        _timer.cancel();
        mevcutsoru = 0;
        BitireYolla();
      });
    }

    var cevaplistesi = [];

    for (var obj in sorular) {
      cevaplistesi.add(obj['cevaplar']);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Sorular'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('e-Sınav', style: TextStyle(fontSize: 60)),
            Text('Ad Soyad: ' + adSoyad, style: TextStyle(fontSize: 24)),
            Text('Öğrneci No: ' + ogrNo, style: TextStyle(fontSize: 24)),
            Text('Mevcut Soru / Toplam Soru: ' + mevcutsoru.toString() + ' / ' +
                sorular.length.toString(), style: TextStyle(fontSize: 16)),
            Text('Puan: '+puan.toString(),style: TextStyle(fontSize: 16)),
            Text(sorular[mevcutsoru]['soru'].toString(),
                style: TextStyle(
                  fontSize: 18,
                )),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    mevcutcevap = cevaplistesi[mevcutsoru][0];
                  });
                  kontrolEt();
                },
                child: Text(cevaplistesi[mevcutsoru][0])),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    mevcutcevap = cevaplistesi[mevcutsoru][1];
                  });
                  kontrolEt();
                },
                child: Text(cevaplistesi[mevcutsoru][1])),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    mevcutcevap = cevaplistesi[mevcutsoru][2];
                  });
                  kontrolEt();
                },
                child: Text(cevaplistesi[mevcutsoru][2])),
            Text(
              zamaniFormatla(_sayac.elapsedMilliseconds),
              style: TextStyle(fontSize: 48),
            ),
            Text(
              'Kullanılan Süre: ' + zamaniFormatla(kullanilansure),
              style: TextStyle(fontSize: 48),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                }, child: Text('Anasayfa'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
