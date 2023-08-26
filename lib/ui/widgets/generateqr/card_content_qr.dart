import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../cubit/student/student_cubit.dart';
import '../../../model/class_model.dart';
import '../custom_button.dart';

class CardContentQr extends StatefulWidget {
  final VoidCallback onDataSiswaPageRequested;
  final List<ClassModel> kelas;
  const CardContentQr(
    this.kelas, {
    Key? key,
    required this.onDataSiswaPageRequested,
  }) : super(key: key);

  @override
  State<CardContentQr> createState() => _CardContentQrState();
}

class _CardContentQrState extends State<CardContentQr> {
  late String newValueClass = widget.kelas[0].grade;
  @override
  Widget build(BuildContext context) {
    String selectedClass = widget.kelas.isEmpty ? '' : widget.kelas[0].grade;

    void generateQrCode() {
      if (selectedClass.isEmpty) {
        // toast
        Fluttertoast.showToast(
          msg: 'Silahkan pilih kelas terlebih dahulu!!!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16,
        );
      } else {
        context.read<StudentCubit>().filterStudent(grade: newValueClass);
      }
    }

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
          BlocBuilder<StudentCubit, StudentState>(
            builder: (context, state) {
              if (state is StudentSuccess) {
                return Text(
                  'Total Siswa : ${state.students.length}',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                );
              } else {
                return const Text(
                  'Total Siswa :',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                );
              }
            },
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
                  value: selectedClass,
                  onChanged: (newValue) {
                    setState(() {
                      selectedClass = newValue!;
                      newValueClass = selectedClass;
                    });
                  },
                  items: widget.kelas.map((students) {
                    return DropdownMenuItem<String>(
                      value: students.grade,
                      child: Text(students.grade),
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
                  onPressed: () {
                    // Memanggil callback untuk membuka halaman "Data Siswa"
                    context.read<StudentCubit>().getStudents();
                    widget.onDataSiswaPageRequested.call();
                  },
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
              onPressed: () {
                generateQrCode();
              },
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
