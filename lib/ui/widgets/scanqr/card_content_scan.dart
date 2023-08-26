import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../../../cubit/attendance/attendance_cubit.dart';
import '../../../cubit/student/student_cubit.dart';
import '../custom_button.dart';

class CardContentScan extends StatefulWidget {
  const CardContentScan({Key? key}) : super(key: key);

  @override
  State<CardContentScan> createState() => _CardContentScanState();
}

class _CardContentScanState extends State<CardContentScan> {
  String _selectedPresent = 'MASUK';

  String result = '';

  late String selectPresent;

  @override
  Widget build(BuildContext context) {
    setState(() {
      if (_selectedPresent == 'MASUK') {
        selectPresent = 'HADIR';
      }
    });
    return BlocConsumer<StudentCubit, StudentState>(
      listener: (context, state) {
        if (state is FindStudentSuccess) {
          if (_selectedPresent == 'MASUK') {
            context.read<AttendanceCubit>().scanAttendancesEnter(
                  id: result,
                  attend: selectPresent,
                  description: '-',
                  enter: DateTime.now(),
                  exit: DateTime(2000),
                  name: state.findStudent.name,
                  grade: state.findStudent.grade,
                  phone: state.findStudent.phone,
                  nis: state.findStudent.nis,
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                );
          }
          if (_selectedPresent == 'PULANG') {
            context.read<AttendanceCubit>().scanAttendancesExit(
                  id: result,
                  exit: DateTime.now(),
                  grade: state.findStudent.grade,
                  enter: DateTime.now(),
                );
          }
        } else if (state is StudentFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is AttendanceLoading) {
          return const Center(child: CircularProgressIndicator());
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
              BlocBuilder<StudentCubit, StudentState>(
                builder: (context, state) {
                  if (state is FindStudentSuccess) {
                    return Text(
                      '$_selectedPresent : ${state.findStudent.name}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: _selectedPresent == 'MASUK'
                            ? Colors.green
                            : Colors.redAccent,
                      ),
                    );
                  } else {
                    return Text(
                      '$_selectedPresent : - ',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: _selectedPresent == 'MASUK'
                            ? Colors.green
                            : Colors.redAccent,
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
                          builder: (context) =>
                              const SimpleBarcodeScannerPage(),
                        ));
                    setState(() {
                      if (res is String) {
                        result = res;
                      }
                      context.read<StudentCubit>().findStudent(id: result);
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
      },
    );
  }
}
