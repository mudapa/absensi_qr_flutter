import 'package:flutter/material.dart';

import '../custom_button.dart';

class DataListAbsen extends StatefulWidget {
  const DataListAbsen({Key? key}) : super(key: key);

  @override
  State<DataListAbsen> createState() => _DataListAbsenState();
}

class _DataListAbsenState extends State<DataListAbsen> {
  DateTime date = DateTime.now();
  String _selectedAbsen = 'HADIR';
  final _keteranganController = TextEditingController();

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
                'Edit Data Kehadiran',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Asep Supardi',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ),
                child: Column(
                  children: [
                    const Text('Kehadiran'),
                    DropdownButtonFormField<String>(
                      value: _selectedAbsen,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedAbsen = newValue!;
                        });
                      },
                      items: <String>['HADIR', 'SAKIT', 'IZIN', 'ALFA']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _keteranganController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Keterangan',
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 40,
              child: Text(
                '1',
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              width: 120,
              child: Text(
                '1234567891123456',
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              width: 120,
              child: Text(
                'Asep Supardi',
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: 120,
              child: Container(
                height: 40,
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'HADIR',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 150,
              child: Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Text(
                  '${date.hour}:${date.minute}',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            SizedBox(
              width: 150,
              child: Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Text(
                  '${date.hour + 3}:${date.minute}',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(
              width: 120,
              child: Text(
                '-',
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: 120,
              child: CustomButton(
                title: 'Edit',
                onPressed: () {
                  editKelas();
                },
                width: 90,
                color: Colors.cyan,
              ),
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
