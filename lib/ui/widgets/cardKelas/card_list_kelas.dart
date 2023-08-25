import 'package:absensi_qr/cubit/class/class_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data_list_kelas.dart';

class CardListKelas extends StatefulWidget {
  const CardListKelas({Key? key}) : super(key: key);

  @override
  State<CardListKelas> createState() => _CardListKelasState();
}

class _CardListKelasState extends State<CardListKelas> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 60,
        left: 32,
        right: 32,
      ),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  'KELAS',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
              ),
              SizedBox(
                width: 100,
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
          const SizedBox(height: 12),
          BlocBuilder<ClassCubit, ClassState>(
            builder: (context, state) {
              if (state is ClassSuccess) {
                return Column(
                  children: state.classes.map((kelas) {
                    return DataListKelas(kelas, state.classes.indexOf(kelas));
                  }).toList(),
                );
              } else {
                BlocProvider.of<ClassCubit>(context).getClasses();
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
