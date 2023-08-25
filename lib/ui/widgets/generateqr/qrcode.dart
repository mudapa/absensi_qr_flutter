// ignore_for_file: use_build_context_synchronously

import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import '../../../model/student_model.dart';
import '../custom_button.dart';

class Qrcode extends StatefulWidget {
  final StudentModel students;
  const Qrcode(this.students, {Key? key}) : super(key: key);

  @override
  State<Qrcode> createState() => _QrcodeState();
}

class _QrcodeState extends State<Qrcode> {
  final GlobalKey qrCodeKey = GlobalKey();

  void downloadQR() async {
    RenderRepaintBoundary boundary =
        qrCodeKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 4);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    // Menyimpan gambar ke galeri
    final result = await ImageGallerySaver.saveImage(pngBytes);

    // Memberikan umpan balik kepada pengguna
    if (result['isSuccess']) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Berhasil Mengunduh'),
          content: const Text('QR CODE berhasil disimpan ke galeri.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text(
              'Gagal menyimpan QR CODE, mungkin penyimpanan kamu penuh!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 16),
      width: MediaQuery.of(context).size.width * .8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          const Text(
            'QR CODE',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          RepaintBoundary(
            key: qrCodeKey,
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                children: [
                  PrettyQr(
                    image: const AssetImage('assets/logo.png'),
                    typeNumber: 3,
                    size: 200,
                    data: widget.students.id,
                    errorCorrectLevel: QrErrorCorrectLevel.M,
                    roundEdges: true,
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'NIS : ${widget.students.nis}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'NAMA : ${widget.students.name}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'KELAS : ${widget.students.grade}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          CustomButton(
              onPressed: () {
                downloadQR();
              },
              icon: const Icon(
                Icons.download_rounded,
                color: Colors.white,
                size: 32,
              ),
              title: 'Download QR CODE'),
        ],
      ),
    );
  }
}
