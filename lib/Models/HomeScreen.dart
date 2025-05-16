import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beranda Konsultasi'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // tengah vertikal
            crossAxisAlignment: CrossAxisAlignment.center, // tengah horizontal
            children: [
              const Text(
                'Selamat datang di Aplikasi Konsultasi Gus2an!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/Schedule');
                },
                icon: const Icon(Icons.chat),
                label: const Text('Mulai Konsultasi'),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/viewSchedules');
                },
                icon: const Icon(Icons.history),
                label: const Text('Riwayat Konsultasi'),
              ),
              const SizedBox(height: 30),
              const Text(
                'Informasi:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              const Text(
                'Aplikasi ini menyediakan layanan konsultasi langsung bersama para Gus/ustadz terpercaya. Silakan mulai konsultasi kapan saja.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
