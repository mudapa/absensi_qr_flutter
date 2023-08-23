import 'package:absensi_qr/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class CardContentScan extends StatefulWidget {
  const CardContentScan({Key? key}) : super(key: key);

  @override
  State<CardContentScan> createState() => _CardContentScanState();
}

class _CardContentScanState extends State<CardContentScan> {
  String _selectedPresent = 'MASUK';

  String result = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          Text(
            '$_selectedPresent : $result',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color:
                  _selectedPresent == 'MASUK' ? Colors.green : Colors.redAccent,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.withOpacity(0.5),
              ),
            ),
            child: Column(
              children: [
                const Text(
                  'ABSENSI',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                DropdownButtonFormField<String>(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  value: _selectedPresent,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedPresent = newValue!;
                    });
                  },
                  items: <String>[
                    'MASUK',
                    'PULANG',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          CustomButton(
              onPressed: () async {
                var res = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SimpleBarcodeScannerPage(),
                    ));
                setState(() {
                  if (res is String) {
                    result = res;
                  }
                });
              },
              icon: const Icon(
                Icons.qr_code_scanner_rounded,
                color: Colors.white,
                size: 32,
              ),
              title: 'SCAN QR'),
        ],
      ),
    );
  }
}
