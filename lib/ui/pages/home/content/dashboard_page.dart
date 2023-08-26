import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../cubit/auth/auth_cubit.dart';
import '../../../../cubit/class/class_cubit.dart';
import '../../../../cubit/student/student_cubit.dart';
import '../../../widgets/card_custom.dart';
import '../../../widgets/tile_card_custom.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.custom(
      padding: const EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16,
        bottom: 32,
      ),
      gridDelegate: SliverQuiltedGridDelegate(
        crossAxisCount: 4,
        mainAxisSpacing: 12,
        crossAxisSpacing: 8,
        repeatPattern: QuiltedGridRepeatPattern.inverted,
        pattern: [
          const QuiltedGridTile(2, 2),
          const QuiltedGridTile(2, 2),
          const QuiltedGridTile(2, 4),
          // const QuiltedGridTile(2, 4),
          // const QuiltedGridTile(2, 4),
        ],
      ),
      childrenDelegate: SliverChildListDelegate(
        [
          BlocBuilder<StudentCubit, StudentState>(
            builder: (context, state) {
              if (state is StudentSuccess) {
                return CardCustom(
                  icon: const Icon(
                    Icons.people,
                    color: Colors.white,
                    size: 50,
                  ),
                  name: 'Jumlah Siswa',
                  value: state.students.length.toString(),
                  color: Colors.blue,
                );
              } else {
                return const CardCustom(
                  icon: Icon(
                    Icons.people,
                    color: Colors.white,
                    size: 50,
                  ),
                  name: 'Jumlah Siswa',
                  value: '-',
                  color: Colors.blue,
                );
              }
            },
          ),
          BlocBuilder<ClassCubit, ClassState>(
            builder: (context, state) {
              if (state is ClassSuccess) {
                return CardCustom(
                  icon: const Icon(
                    Icons.list_alt_rounded,
                    color: Colors.white,
                    size: 50,
                  ),
                  name: 'Jumlah Kelas',
                  value: state.classes.length.toString(),
                  color: Colors.green,
                );
              } else {
                return const CardCustom(
                  icon: Icon(
                    Icons.list_alt_rounded,
                    color: Colors.white,
                    size: 50,
                  ),
                  name: 'Jumlah Kelas',
                  value: '-',
                  color: Colors.green,
                );
              }
            },
          ),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is ListAuthSuccess) {
                return CardCustom(
                  icon: const Icon(
                    Icons.people_outline_rounded,
                    color: Colors.white,
                    size: 50,
                  ),
                  name: 'Jumlah User',
                  value: state.users.length.toString(),
                  color: Colors.orange,
                );
              } else {
                return const CardCustom(
                  icon: Icon(
                    Icons.people_outline_rounded,
                    color: Colors.white,
                    size: 50,
                  ),
                  name: 'Jumlah User',
                  value: '-',
                  color: Colors.orange,
                );
              }
            },
          ),
          const TileCardCustom(),
        ],
      ),
    );
  }
}
