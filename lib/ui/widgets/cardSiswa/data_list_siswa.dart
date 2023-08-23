import 'package:flutter/material.dart';

import '../custom_button.dart';
import '../custom_text_form_field.dart';

class DataListSiswa extends StatefulWidget {
  const DataListSiswa({Key? key}) : super(key: key);

  @override
  State<DataListSiswa> createState() => _DataListSiswaState();
}

class _DataListSiswaState extends State<DataListSiswa> {
  String _selectedGender = 'Laki-laki';
  String _selectedClass = 'VII';
  final _nisTextController = TextEditingController();
  final _nameTextController = TextEditingController();
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
                'Edit Data Kelas',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              CustomTextFormField(
                hintText: 'NIS',
                controller: _nisTextController,
              ),
              CustomTextFormField(
                hintText: 'NAMA SISWA',
                controller: _nameTextController,
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
                    const Text('Jenis Kelamin'),
                    DropdownButtonFormField<String>(
                      value: _selectedGender,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedGender = newValue!;
                        });
                      },
                      items: <String>['Laki-laki', 'Perempuan']
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
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ),
                child: Column(
                  children: [
                    const Text('KELAS'),
                    DropdownButtonFormField<String>(
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
              CustomTextFormField(
                hintText: 'NO HP',
                controller: _nameTextController,
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
              title: 'Ubah',
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

    void delete() {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Apakah anda yakin ingin menghapus data ini?'),
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
                    title: 'Hapus',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    width: 100,
                    color: Colors.red,
                  ),
                ],
              ));
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 40,
              child: Text('1'),
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
            const SizedBox(
              width: 120,
              child: Text(
                'Laki-Laki',
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              width: 120,
              child: Text(
                'VII',
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              width: 120,
              child: Text(
                '081212345678',
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: 190,
              child: Row(
                children: [
                  CustomButton(
                    title: 'Ubah',
                    onPressed: () {
                      editKelas();
                    },
                    width: 90,
                    color: Colors.orange,
                  ),
                  const SizedBox(width: 8),
                  CustomButton(
                    title: 'Delete',
                    onPressed: () {
                      delete();
                    },
                    width: 90,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
