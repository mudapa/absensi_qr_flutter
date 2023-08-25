import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubit/attendance/attendance_cubit.dart';
import '../../../../model/class_model.dart';
import '../../../widgets/cardAbsen/card_list_absen.dart';

class DataAbsenPage extends StatefulWidget {
  final List<ClassModel> kelas;
  const DataAbsenPage(
    this.kelas, {
    Key? key,
  }) : super(key: key);

  @override
  State<DataAbsenPage> createState() => _DataAbsenPageState();
}

class _DataAbsenPageState extends State<DataAbsenPage> {
  String _filterClass = 'SEMUA';
  late DateTime _dateTime;

  @override
  void initState() {
    super.initState();
    _dateTime = DateTime.now(); // Initialize _dateTime in initState

    // Set up a Timer to update _dateTime every second
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _dateTime = DateTime.now();
        });
      }
    });
  }

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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Daftar Absensi Siswa',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${_dateTime.year}-${_dateTime.month}-${_dateTime.day} ${_dateTime.hour}:${_dateTime.minute}:${_dateTime.second}',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
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
                        padding: const EdgeInsets.symmetric(horizontal: 12),
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
                                    context
                                        .read<AttendanceCubit>()
                                        .getAttendances();
                                  },
                                ),
                                ...widget.kelas.map((kelas) {
                                  return DropdownMenuItem<String>(
                                    value: kelas.grade,
                                    child: Text(kelas.grade),
                                    onTap: () {
                                      context
                                          .read<AttendanceCubit>()
                                          .filterAttendance(
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
