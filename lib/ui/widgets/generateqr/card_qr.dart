import 'package:absensi_qr/ui/widgets/generateqr/card_content_qr.dart';
import 'package:flutter/material.dart';

class CardQr extends StatelessWidget {
  const CardQr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 80,
        left: 8,
        right: 8,
        bottom: 32,
      ),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CardContentQr(),
        ],
      ),
    );
  }
}
