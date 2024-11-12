import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Beranda Pemesanan Mobil')),
      body: Center(
        child: Text('Selamat Datang di Aplikasi Pemesanan Mobil!'),
      ),
    );
  }
}
