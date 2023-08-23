import 'dart:async';

import 'package:absensi_qr/ui/pages/sign_in_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay selama 2 detik, lalu navigasi ke halaman berikutnya
    Timer(const Duration(seconds: 2), () async {
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/login',
          (route) => false,
        );
      } else {
        FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            Map<String, dynamic> userData =
                documentSnapshot.data() as Map<String, dynamic>;
            int? role = userData['role'];

            if (role == 2) {
              // Pengguna memiliki role == 2, masukkan ke halaman siswa
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/siswa',
                (route) => false,
              );
            } else if (role == 1) {
              // Pengguna memiliki role == 1, masukkan ke halaman admin
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/main',
                (route) => false,
              );
            }
          }
        }).catchError((error) {
          // Error saat mengambil data pengguna dari Firestore
          // Bisa lakukan tindakan lainnya, misalnya tampilkan pesan kesalahan
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', width: 200, height: 200),
            const SizedBox(height: 16),
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            const Text(
              'Absensi QR',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 8,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
