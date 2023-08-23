import 'package:flutter/material.dart';

import '../custom_button.dart';

class DataListKelas extends StatelessWidget {
  final String no;
  final String kelas;
  const DataListKelas({
    Key? key,
    required this.no,
    required this.kelas,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void editKelas() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Edit Data Kelas \nData Saat ini: test',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.1),
                  labelText: 'KELAS',
                  labelStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      16,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      32,
                    ),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            CustomButton(
              title: 'Batal',
              onPressed: () {
                Navigator.pop(context);
              },
              width: 100,
              color: Colors.grey,
            ),
            const SizedBox(width: 8),
            CustomButton(
              title: 'Edit',
              onPressed: () {
                Navigator.pop(context);
              },
              width: 100,
              color: Colors.orange,
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 40,
              child: Text(
                no,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: 120,
              child: Text(
                kelas,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            CustomButton(
              title: 'Edit',
              onPressed: () {
                editKelas();
              },
              width: 90,
              color: Colors.orange,
            ),
          ],
        ),
        const SizedBox(height: 18),
      ],
    );
  }
}
