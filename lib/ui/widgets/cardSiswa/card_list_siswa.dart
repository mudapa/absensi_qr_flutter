import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/class/class_cubit.dart';
import '../../../cubit/student/student_cubit.dart';
import 'data_list_siswa.dart';

class CardListSiswa extends StatelessWidget {
  const CardListSiswa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 80,
        left: 8,
        right: 8,
      ),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                SizedBox(
                  width: 40,
                  child: Text(
                    'NO',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: Text(
                    'NIS',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: Text(
                    'NAMA SISWA',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: Text(
                    'JENIS KELAMIN',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: Text(
                    'KELAS',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: Text(
                    'NO HP/WA WALI',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                ),
                SizedBox(
                  width: 190,
                  child: Text(
                    'AKSI',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
            BlocBuilder<StudentCubit, StudentState>(
              builder: (context, state1) {
                if (state1 is StudentSuccess) {
                  return Column(
                    children: state1.students.map((student) {
                      return BlocBuilder<ClassCubit, ClassState>(
                        builder: (context, state2) {
                          if (state2 is ClassSuccess) {
                            return DataListSiswa(
                              student,
                              state2.classes,
                              state1.students.indexOf(student),
                            );
                          } else {
                            BlocProvider.of<ClassCubit>(context).getClasses();
                            return const SizedBox();
                          }
                        },
                      );
                    }).toList(),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
