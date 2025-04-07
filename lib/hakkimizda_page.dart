import 'package:flutter/material.dart';
import 'drawer.dart';

class HakkimizdaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hakkımızda'),
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 10,
        shadowColor: Colors.purple,
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Biz Kimiz?',
                style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurpleAccent,
                    letterSpacing: 1.5),
                    textAlign: TextAlign.center,

              ),
              const SizedBox(height: 20),
              const Text(
                'Bu uygulama, kullanıcılara rastgele emoji gösterimi ve görev yönetimi gibi kolay ve eğlenceli özellikler sunmayı hedefleyen bir uygulamadır.',
                style: TextStyle(
                    fontSize: 20,
                    height: 1.8,
                    color: Colors.black87,
                    fontFamily: 'Roboto'),
              ),
              const SizedBox(height: 20),
              const Text(
                'Proje Ekibimiz:',
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurpleAccent),
              ),
              const SizedBox(height: 10),

              Text(
                'Enes ELHOVETE 030722060',
                style: TextStyle(
                    fontSize: 23,
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    letterSpacing: 1.3),
              ),
              const SizedBox(height: 20),

              Text(
                'Amr ACAR 030722108  Mohamad ALHAMOUD 030721079',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    letterSpacing: 1.2),
              ),
              const SizedBox(height: 20),
              const Text(
                'Mühendislik ve Doğa Bilimleri Fakültesi\nBIM324-25 Mobil Uygulama Geliştirme',
                style: TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    color: Colors.black54,
                    fontFamily: 'Roboto',
                    letterSpacing: 1.2),
              ),
              const SizedBox(height: 30),
              const Text(
                'Bu uygulama, sadece eğlence değil aynı zamanda kullanıcıların yaşamını kolaylaştıran araçlar sunmayı amaçlıyor. Ekibimiz, bu projeyi geliştirme sürecinde büyük bir heyecan ve özenle çalıştı.',
                style: TextStyle(
                    fontSize: 20,
                    height: 1.8,
                    color: Colors.black87,
                    fontFamily: 'Roboto'),
              ),
              const SizedBox(height: 50),

            ],
          ),
        ),
      ),
    );
  }
}
