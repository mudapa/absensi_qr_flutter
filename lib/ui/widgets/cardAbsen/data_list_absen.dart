import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../cubit/attendance/attendance_cubit.dart';
import '../../../model/attendance_model.dart';
import '../custom_button.dart';

class DataListAbsen extends StatefulWidget {
  final AttendanceModel absen;
  final int index;

  const DataListAbsen(
    this.absen,
    this.index, {
    Key? key,
  }) : super(key: key);

  @override
  State<DataListAbsen> createState() => _DataListAbsenState();
}

class _DataListAbsenState extends State<DataListAbsen> {
  DateTime date = DateTime.now();
  String _selectedAbsen = 'HADIR';
  final _keteranganController = TextEditingController();

  void _sendWhatsAppMessage(int phone, String name) async {
    String phoneNumber =
        '+62$phone'; // Replace with the recipient's phone number
    String message =
        'Status Kehadiran $name hari ini ${widget.absen.attend} ${widget.absen.enter}'; // Replace with your desired message

    String link =
        "https://api.whatsapp.com/send/?phone=$phoneNumber&text=$message";

    // ignore: deprecated_member_use
    await launch(link);
  }

  @override
  Widget build(BuildContext context) {
    void editKelas() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Edit Data Kehadiran',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  widget.absen.name!,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Text('Kehadiran'),
                      DropdownButtonFormField<String>(
                        value: _selectedAbsen,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedAbsen = newValue!;
                          });
                        },
                        items: <String>['HADIR', 'SAKIT', 'IZIN', 'ALFA']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _keteranganController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Keterangan',
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomButton(
                      title: 'Batal',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      width: 100,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    CustomButton(
                      title: 'Ubah',
                      onPressed: () {
                        if (_keteranganController.text.isEmpty) {
                          _keteranganController.text = '-';
                        }
                        context.read<AttendanceCubit>().updateAttendance(
                              id: widget.absen.id,
                              attend: _selectedAbsen,
                              description: _keteranganController.text,
                              grade: widget.absen.grade!,
                              enter: widget.absen.enter!,
                            );
                        // Toast
                        Fluttertoast.showToast(
                          msg: 'Berhasil mengubah data',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          backgroundColor: Colors.orange,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                        _keteranganController.clear();
                        context.read<AttendanceCubit>().getAttendances();
                        Navigator.pop(context);
                      },
                      width: 100,
                      color: Colors.orange,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 40,
              child: Text(
                '${widget.index + 1}',
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: 120,
              child: Text(
                '${widget.absen.nis}',
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: 120,
              child: Text(
                widget.absen.name!,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: 130,
              child: Container(
                height: 40,
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: widget.absen.attend == 'HADIR'
                      ? Colors.green
                      : widget.absen.attend == 'SAKIT'
                          ? Colors.orange
                          : widget.absen.attend == 'IZIN'
                              ? Colors.blue
                              : Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    widget.absen.attend!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 130,
              child: Padding(
                padding: const EdgeInsets.only(left: 26),
                child: Text(
                  widget.absen.grade!,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            SizedBox(
              width: 150,
              child: Padding(
                padding: const EdgeInsets.only(left: 32),
                child: Text(
                  '${widget.absen.enter!.hour}:${widget.absen.enter!.minute}',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            SizedBox(
              width: 150,
              child: Padding(
                padding: const EdgeInsets.only(left: 36),
                child: Text(
                  '${widget.absen.exit!.hour}:${widget.absen.exit!.minute}',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            SizedBox(
              width: 120,
              child: Text(
                widget.absen.description!,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 16),
              width: 220,
              child: Row(
                children: [
                  CustomButton(
                    title: 'Ubah',
                    onPressed: () {
                      editKelas();
                    },
                    width: 90,
                    color: Colors.orange,
                  ),
                  const SizedBox(width: 8),
                  // button send message Whatsapp
                  CustomButton(
                    icon: Image.asset(
                      'assets/whatsapp.png',
                      width: 24,
                      height: 24,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _sendWhatsAppMessage(
                        widget.absen.phone!,
                        widget.absen.name!,
                      );
                    },
                    width: 100,
                    color: Colors.green,
                  ),
                ],
              ),
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
