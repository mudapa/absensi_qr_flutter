import 'package:flutter/material.dart';

import 'data_list_kelas.dart';

class CardListKelas extends StatelessWidget {
  const CardListKelas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 60,
        left: 8,
        right: 8,
      ),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: const Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
          SizedBox(height: 12),
          Column(
            children: [
              DataListKelas(
                no: '1',
                kelas: 'VII-A',
              ),
              DataListKelas(
                no: '1',
                kelas: 'VII-A',
              ),
              DataListKelas(
                no: '1',
                kelas: 'VII-A',
              ),
              DataListKelas(
                no: '1',
                kelas: 'VII-A',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
