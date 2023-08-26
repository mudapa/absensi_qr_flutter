import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/attendance/attendance_cubit.dart';

class TileCardCustom extends StatefulWidget {
  const TileCardCustom({Key? key}) : super(key: key);

  @override
  State<TileCardCustom> createState() => _TileCardCustomState();
}

class _TileCardCustomState extends State<TileCardCustom> {
  final date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blueGrey[900],
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.checklist_rounded,
                color: Colors.white,
                size: 50,
              ),
              const SizedBox(width: 10),
              const Text(
                'ABSENSI SISWA',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '${date.day} - ${date.month} - ${date.year}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'HADIR',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'SAKIT',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'IZIN',
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'ALFA',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BlocBuilder<AttendanceCubit, AttendanceState>(
                builder: (context, state) {
                  if (state is AttendanceSuccess) {
                    return Text(
                      '${state.attendances.where((element) => element.attend == 'HADIR').length}',
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  } else {
                    return const Text(
                      '-',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  }
                },
              ),
              BlocBuilder<AttendanceCubit, AttendanceState>(
                  builder: (context, state) {
                if (state is AttendanceSuccess) {
                  return Text(
                    '${state.attendances.where((element) => element.attend == 'SAKIT').length}',
                    style: const TextStyle(
                      color: Colors.orange,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                } else {
                  return const Text(
                    '-',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                }
              }),
              BlocBuilder<AttendanceCubit, AttendanceState>(
                builder: (context, state) {
                  if (state is AttendanceSuccess) {
                    return Text(
                      '${state.attendances.where((element) => element.attend == 'IZIN').length}',
                      style: const TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  } else {
                    return const Text(
                      '-',
                      style: TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  }
                },
              ),
              BlocBuilder<AttendanceCubit, AttendanceState>(
                builder: (context, state) {
                  if (state is AttendanceSuccess) {
                    return Text(
                      '${state.attendances.where((element) => element.attend == 'ALFA').length}',
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  } else {
                    return const Text(
                      '-',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
