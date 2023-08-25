import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/class/class_cubit.dart';
import 'card_content_qr.dart';

class CardQr extends StatefulWidget {
  final VoidCallback onDataSiswaPageRequested;
  const CardQr({Key? key, required this.onDataSiswaPageRequested})
      : super(key: key);

  @override
  State<CardQr> createState() => _CardQrState();
}

class _CardQrState extends State<CardQr> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 80,
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
          BlocBuilder<ClassCubit, ClassState>(
            builder: (context, state) {
              if (state is ClassSuccess) {
                return CardContentQr(
                  state.classes,
                  onDataSiswaPageRequested: widget.onDataSiswaPageRequested,
                );
              } else {
                context.read<ClassCubit>().getClasses();
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
