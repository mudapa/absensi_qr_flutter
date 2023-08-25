import 'package:absensi_qr/cubit/class/class_cubit.dart';
import 'package:absensi_qr/model/class_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../custom_button.dart';

class DataListKelas extends StatefulWidget {
  final ClassModel kelas;
  final int index;
  const DataListKelas(
    this.kelas,
    this.index, {
    Key? key,
  }) : super(key: key);

  @override
  State<DataListKelas> createState() => _DataListKelasState();
}

class _DataListKelasState extends State<DataListKelas> {
  final _valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void editKelas() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Edit Data Kelas \nData Saat ini: ${widget.kelas.grade}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: _valueController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.1),
                  labelText: widget.kelas.grade,
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
              title: 'Ubah',
              onPressed: () {
                context.read<ClassCubit>().updateClass(
                      id: widget.kelas.id,
                      grade: _valueController.text,
                      updatedAt: DateTime.now(),
                    );
                // Toast
                Fluttertoast.showToast(
                  msg: 'Berhasil mengubah data kelas',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.orange,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
                Navigator.pop(context);
              },
              width: 100,
              color: Colors.orange,
            ),
          ],
        ),
      );
    }

    void deleteKelas() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Hapus Data Kelas \nData Saat ini: ${widget.kelas.grade}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
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
              title: 'Hapus',
              onPressed: () {
                context.read<ClassCubit>().deleteClass(
                      id: widget.kelas.id,
                    );
                // Toast
                Fluttertoast.showToast(
                  msg: 'Berhasil menghapus data kelas',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
                Navigator.pop(context);
              },
              width: 100,
              color: Colors.red,
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              width: 100,
              child: Text(
                '${widget.index + 1}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: 120,
              child: Text(
                widget.kelas.grade,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
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
                  title: 'Hapus',
                  onPressed: () {
                    deleteKelas();
                  },
                  width: 90,
                  color: Colors.red,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 18),
      ],
    );
  }
}
