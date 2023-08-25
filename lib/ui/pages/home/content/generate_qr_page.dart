import 'package:flutter/material.dart';

import '../../../widgets/generateqr/card_qr.dart';
import '../../../widgets/generateqr/qr_generate.dart';

class GenerateQrPage extends StatefulWidget {
  final VoidCallback onDataSiswaPageRequested;
  const GenerateQrPage({Key? key, required this.onDataSiswaPageRequested})
      : super(key: key);

  @override
  State<GenerateQrPage> createState() => _GenerateQrPageState();
}

class _GenerateQrPageState extends State<GenerateQrPage> {
  @override
  Widget build(BuildContext context) {
    Widget content() {
      return Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: 32,
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    children: [
                      CardQr(
                          onDataSiswaPageRequested:
                              widget.onDataSiswaPageRequested),
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'GENERATE QR',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Generate QR berdasarkan kelas',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white60,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Column(
                children: [
                  QrGenerate(),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return ListView(
      children: [
        content(),
      ],
    );
  }
}
