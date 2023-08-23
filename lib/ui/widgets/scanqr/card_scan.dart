import 'package:flutter/material.dart';

import 'card_content_scan.dart';

class CardScan extends StatelessWidget {
  const CardScan({Key? key}) : super(key: key);

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
          CardContentScan(),
        ],
      ),
    );
  }
}
