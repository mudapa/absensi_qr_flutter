import 'package:absensi_qr/cubit/class/class_cubit.dart';
import 'package:absensi_qr/cubit/student/student_cubit.dart';
import 'package:absensi_qr/ui/widgets/cardSiswa/card_list_siswa.dart';
import 'package:absensi_qr/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../model/class_model.dart';
import '../../../widgets/custom_button.dart';

class DataSiswaPage extends StatefulWidget {
  final List<ClassModel> kelas;
  const DataSiswaPage(this.kelas, {Key? key}) : super(key: key);

  @override
  State<DataSiswaPage> createState() => _DataSiswaPageState();
}

class _DataSiswaPageState extends State<DataSiswaPage> {
  String _filterClass = 'SEMUA';

  final _nisTextController = TextEditingController();
  final _nameTextController = TextEditingController();
  String _selectedGender = 'Laki-laki';
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String selectedClass = widget.kelas.isEmpty ? '' : widget.kelas[0].grade;
    void tambahSiswa() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Tambah Data Siswa',
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
                child: BlocBuilder<ClassCubit, ClassState>(
                  builder: (context, state) {
                    if (state is ClassSuccess) {
                      return Column(
                        children: [
                          const Text('KELAS'),
                          DropdownButtonFormField<String>(
                            value: selectedClass,
                            onChanged: (newValue) {
                              setState(() {
                                selectedClass = newValue!;
                              });
                            },
                            items: widget.kelas.isEmpty
                                ? const <String>[''].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList()
                                : state.classes.map((kelas) {
                                    return DropdownMenuItem<String>(
                                      value: kelas.grade,
                                      child: Text(kelas.grade),
                                    );
                                  }).toList(),
                          ),
                        ],
                      );
                    } else {
                      BlocProvider.of<ClassCubit>(context).getClasses();
                      return const SizedBox();
                    }
                  },
                ),
              ),
              CustomTextFormField(
                hintText: 'NO HP/WA WALI',
                controller: _phoneController,
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
              title: 'Simpan',
              onPressed: () {
                context.read<StudentCubit>().addStudent(
                      nis: int.parse(_nisTextController.text),
                      name: _nameTextController.text,
                      gender: _selectedGender,
                      grade: selectedClass,
                      phone: int.parse(_phoneController.text),
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    );
                _nisTextController.clear();
                _nameTextController.clear();
                _phoneController.clear();
                context.read<StudentCubit>().getStudents();
                Navigator.pop(context);
              },
              width: 100,
              color: Colors.green,
            ),
          ],
        ),
      );
    }

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
                  CardListSiswa(),
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
                        'Daftar Siswa',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        width: 120,
                        height: 70,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.5),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'URUTKAN KELAS',
                              style: TextStyle(
                                fontSize: 10,
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
                              items: [
                                DropdownMenuItem<String>(
                                  value: 'SEMUA',
                                  child: const Text('SEMUA'),
                                  onTap: () {
                                    context.read<StudentCubit>().getStudents();
                                  },
                                ),
                                ...widget.kelas.map((kelas) {
                                  return DropdownMenuItem<String>(
                                    value: kelas.grade,
                                    child: Text(kelas.grade),
                                    onTap: () {
                                      context
                                          .read<StudentCubit>()
                                          .filterStudent(
                                            grade: kelas.grade,
                                          );
                                    },
                                  );
                                }).toList(),
                              ],
                            ),
                          ],
                        ),
                      ),
                      CustomButton(
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        // title: 'Tambah',
                        width: 80,
                        color: Colors.green,
                        onPressed: () {
                          tambahSiswa();
                        },
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
