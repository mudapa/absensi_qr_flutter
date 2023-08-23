import 'package:flutter/material.dart';

import '../../../widgets/cardAbsen/card_list_absen.dart';

class DataAbsenPage extends StatefulWidget {
  const DataAbsenPage({Key? key}) : super(key: key);

  @override
  State<DataAbsenPage> createState() => _DataAbsenPageState();
}

class _DataAbsenPageState extends State<DataAbsenPage> {
  String _filterClass = 'SEMUA KELAS';

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
        child: Stack(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 40),
              child: Column(
                children: [
                  CardListAbsen(),
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Daftar Absensi Siswa',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        width: 150,
                        height: 70,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.5),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          children: [
                            const Text(
                              'KELAS',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                            DropdownButtonFormField<String>(
                              dropdownColor: Colors.purple,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              value: _filterClass,
                              onChanged: (newValue) {
                                setState(() {
                                  _filterClass = newValue!;
                                });
                              },
                              items: <String>[
                                'SEMUA KELAS',
                                'VII',
                                'VIII',
                                'IX'
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
                    ],
                  ),
                ),
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
