import 'package:absensi_qr/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class CardContentQr extends StatefulWidget {
  const CardContentQr({Key? key}) : super(key: key);

  @override
  State<CardContentQr> createState() => _CardContentQrState();
}

class _CardContentQrState extends State<CardContentQr> {
  String _selectedClass = 'VII';

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
          const Text(
            'Data Siswa',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Total Siswa : 30',
            style: TextStyle(
              fontSize: 16,
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
                  'KELAS',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                DropdownButtonFormField<String>(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  value: _selectedClass,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedClass = newValue!;
                    });
                  },
                  items: <String>['VII', 'VIII', 'IX'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Lihat Data Siswa',
                    style: TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.purple,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          CustomButton(
              onPressed: () {},
              icon: const Icon(
                Icons.qr_code_2_rounded,
                color: Colors.white,
                size: 32,
              ),
              title: 'GENERATE QR'),
        ],
      ),
    );
  }
}
