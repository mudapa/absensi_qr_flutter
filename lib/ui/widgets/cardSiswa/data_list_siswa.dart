import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../cubit/student/student_cubit.dart';
import '../../../model/class_model.dart';
import '../../../model/student_model.dart';
import '../custom_button.dart';
import '../custom_text_form_field.dart';

class DataListSiswa extends StatefulWidget {
  final StudentModel student;
  final List<ClassModel> kelas;
  final int index;
  const DataListSiswa(
    this.student,
    this.kelas,
    this.index, {
    Key? key,
  }) : super(key: key);

  @override
  State<DataListSiswa> createState() => _DataListSiswaState();
}

class _DataListSiswaState extends State<DataListSiswa> {
  final _nisTextController = TextEditingController();
  final _nameTextController = TextEditingController();
  String _selectedGender = 'Laki-laki';
  final _phoneTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String selectedClass = widget.kelas.isEmpty ? '' : widget.kelas[0].grade;
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
                hintText: '${widget.student.nis}',
                controller: _nisTextController,
                helperText: 'NIS',
              ),
              CustomTextFormField(
                hintText: widget.student.name,
                controller: _nameTextController,
                helperText: 'NAMA SISWA',
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
                      items: <String>[
                        'Laki-laki',
                        'Perempuan',
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
                      value: selectedClass,
                      onChanged: (newValue) {
                        setState(() {
                          selectedClass = newValue!;
                        });
                      },
                      items: widget.kelas.map((kelas) {
                        return DropdownMenuItem<String>(
                          value: kelas.grade,
                          child: Text(kelas.grade),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              CustomTextFormField(
                hintText: '0${widget.student.phone}',
                controller: _phoneTextController,
                helperText: 'NO HP/WA WALI',
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
                if (_nisTextController.text.isEmpty) {
                  _nisTextController.text = widget.student.nis.toString();
                }
                if (_nameTextController.text.isEmpty) {
                  _nameTextController.text = widget.student.name;
                }
                if (_phoneTextController.text.isEmpty) {
                  _phoneTextController.text = widget.student.phone.toString();
                }
                context.read<StudentCubit>().updateStudent(
                      id: widget.student.id,
                      nis: int.parse(_nisTextController.text),
                      name: _nameTextController.text,
                      gender: _selectedGender,
                      grade: selectedClass,
                      phone: int.parse(_phoneTextController.text),
                      updatedAt: DateTime.now(),
                    );
                // Toast
                Fluttertoast.showToast(
                  msg: 'Berhasil mengubah data siswa',
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
                      context.read<StudentCubit>().deleteStudent(
                            id: widget.student.id,
                          );
                      // Toast
                      Fluttertoast.showToast(
                        msg: 'Berhasil menghapus data siswa',
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
              ));
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 40,
              child: Text('${widget.index + 1}'),
            ),
            SizedBox(
              width: 120,
              child: Text(
                '${widget.student.nis}',
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: 120,
              child: Text(
                widget.student.name,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: 120,
              child: Text(
                widget.student.gender,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: 120,
              child: Text(
                widget.student.grade,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: 120,
              child: Text(
                '0${widget.student.phone}',
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
