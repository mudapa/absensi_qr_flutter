import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/student/student_cubit.dart';
import 'qrcode.dart';

class QrGenerate extends StatelessWidget {
  const QrGenerate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentCubit, StudentState>(
      builder: (context, state) {
        if (state is StudentSuccess) {
          return Container(
            padding: const EdgeInsets.only(
              top: 32,
              left: 8,
              right: 8,
              bottom: 32,
            ),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'HASIL GENERATE QR CODE\nTotal QR Code: ${state.students.length}',
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.purple,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ...state.students.map((students) {
                  return Qrcode(students);
                }).toList(),
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
