import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../model/attendance_model.dart';

class AttendanceService {
  final CollectionReference _attendReference =
      FirebaseFirestore.instance.collection('attendance');

  final CollectionReference _classReference =
      FirebaseFirestore.instance.collection('classes');

  // Timer to reset data after an interval
  Timer? resetTimer;

  // Interval for resetting data (5 menit = 300 detik)
  final Duration resetInterval = const Duration(seconds: 300);

  AttendanceService() {
    // Start the timer when the AttendanceService is created
    startResetTimer();
  }

  // Method to start the reset timer
  void startResetTimer() {
    // Calculate the next reset time at midnight
    DateTime now = DateTime.now();
    DateTime nextMidnight = DateTime(now.year, now.month, now.day + 1, 0, 0, 0);

    // Calculate the duration until next midnight
    Duration timeUntilMidnight = nextMidnight.difference(now);

    // Schedule the timer to reset data at next midnight
    resetTimer = Timer(timeUntilMidnight, () {
      resetData();
      // Start the timer again for the next midnight
      startResetTimer();
    });
  }

  // get Attendance Data from Firestore
  Future<List<AttendanceModel>> getAttendances() async {
    try {
      // get Attendance Data from Firestore
      QuerySnapshot result = await _attendReference
          .orderBy(
            'createdAt',
            descending: false,
          )
          .get();

      // convert to list of attendances
      List<AttendanceModel> attendances = result.docs.map(
        (e) {
          return AttendanceModel.fromJson(
              e.id, e.data() as Map<String, dynamic>);
        },
      ).toList();

      // Return List of AttendanceModel
      return attendances;
    } catch (e) {
      rethrow;
    }
  }

  // update Attendance Data to Firestore
  Future<AttendanceModel> updateAttendance({
    required String id,
    required String attend,
    required String description,
    required String grade,
    required DateTime enter,
  }) async {
    try {
      // update Attendance Data to Firestore
      await _attendReference.doc(id).update({
        'attend': attend,
        'description': description,
      });

      // find classes by grade in firestore
      QuerySnapshot result = await _classReference
          .where(
            'grade',
            isEqualTo: grade,
          )
          .get();

      // update subcollection attendance in collection classes in firestore
      await _classReference
          .doc(result.docs.first.id)
          .collection('attendance')
          .doc(id +
              (enter.day.toString()) +
              (enter.month.toString() + (enter.year.toString())))
          .set(
        {
          'attend': attend,
          'description': description,
        },
        SetOptions(merge: true),
      );

      // Return AttendanceModel
      return AttendanceModel(
        id: id,
        attend: attend,
        description: description,
      );
    } catch (e) {
      rethrow;
    }
  }

  // filter Attendance Data from Firestore
  Future<List<AttendanceModel>> filterAttendances({
    required String grade,
  }) async {
    try {
      // get Attendance Data from Firestore
      QuerySnapshot result = await _attendReference
          .where(
            'grade',
            isEqualTo: grade,
          )
          .get();

      // convert to list of attendances
      List<AttendanceModel> attendances = result.docs.map(
        (e) {
          return AttendanceModel.fromJson(
              e.id, e.data() as Map<String, dynamic>);
        },
      ).toList();

      // Return List of AttendanceModel
      return attendances;
    } catch (e) {
      rethrow;
    }
  }

  // Scan QR Code Attendance Enter Data from Firestore
  Future<void> scanAttendancesEnter({
    required String id,
    required String attend,
    required String description,
    required DateTime enter,
    required DateTime exit,
    required String name,
    required String grade,
    required int phone,
    required int nis,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) async {
    try {
      // create collection attendance in firestore
      // check if attendance is exist or not in firestore
      DocumentSnapshot result = await _attendReference.doc(id).get();

      // if attendance is exist
      if (result.exists) {
        // toast
        Fluttertoast.showToast(
          msg: 'Siswa sudah absen masuk hari ini',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      } else {
        // create attendance in firestore
        await _attendReference.doc(id).set({
          'attend': attend,
          'description': description,
          'enter': enter,
          'exit': exit,
          'name': name,
          'grade': grade,
          'phone': phone,
          'nis': nis,
          'createdAt': createdAt,
          'updatedAt': updatedAt,
        });

        // find classes by grade in firestore
        QuerySnapshot result = await _classReference
            .where(
              'grade',
              isEqualTo: grade,
            )
            .get();

        // create subcollection attendance with customID in collection classes in firestore
        await _classReference
            .doc(result.docs.first.id)
            .collection('attendance')
            .doc(id +
                (enter.day.toString()) +
                (enter.month.toString() + (enter.year.toString())))
            .set({
          'attend': attend,
          'description': description,
          'enter': enter,
          'exit': exit,
          'name': name,
          'grade': grade,
          'phone': phone,
          'nis': nis,
          'createdAt': createdAt,
          'updatedAt': updatedAt,
        });

        // toast
        Fluttertoast.showToast(
          msg: 'Siswa berhasil absen masuk',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  // Scan QR Code Attendance Exit Data from Firestore
  Future<void> scanAttendancesExit({
    required String id,
    required DateTime exit,
    required String grade,
    required DateTime enter,
  }) async {
    try {
      // create collection attendance in firestore
      // check if attendance is exist or not in firestore
      DocumentSnapshot result = await _attendReference.doc(id).get();

      // if attendance is exist
      if (result.exists) {
        // update attendance in firestore
        await _attendReference.doc(id).set(
          {
            'exit': exit,
          },
          SetOptions(merge: true),
        );

        // find classes by grade in firestore
        QuerySnapshot result = await _classReference
            .where(
              'grade',
              isEqualTo: grade,
            )
            .get();

        // update subcollection attendance without id in collection classes in firestore
        await _classReference
            .doc(result.docs.first.id)
            .collection('attendance')
            .doc(id +
                (enter.day.toString()) +
                (enter.month.toString() + (enter.year.toString())))
            .set(
          {
            'exit': exit,
          },
          SetOptions(merge: true),
        );

        // toast
        Fluttertoast.showToast(
          msg: 'Siswa berhasil absen pulang',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.orange,
          textColor: Colors.white,
        );
      } else {
        // toast
        Fluttertoast.showToast(
          msg: 'Siswa belum absen masuk hari ini',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.orange,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  // Method to reset data
  Future<void> resetData() async {
    try {
      // Implement your logic here to reset data
      // For example, you can delete all documents in the collection
      QuerySnapshot snapshot = await _attendReference.get();
      for (DocumentSnapshot doc in snapshot.docs) {
        await doc.reference.delete();
      }

      // Show toast indicating data reset
      Fluttertoast.showToast(
        msg: 'Data direset',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.yellow,
        textColor: Colors.black,
      );
    } catch (e) {
      rethrow;
    }
  }

  // get Attendance Data from Firestore
  Future<List<AttendanceModel>> getAttendancesHadir() async {
    try {
      // get Attendance Data from Firestore
      QuerySnapshot result = await _attendReference.get();

      // convert to list of attendances
      List<AttendanceModel> attendances = result.docs.map(
        (e) {
          return AttendanceModel.fromJson(
              e.id, e.data() as Map<String, dynamic>);
        },
      ).toList();

      // Return List of AttendanceModel
      return attendances;
    } catch (e) {
      rethrow;
    }
  }
}
