import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/attendance_model.dart';

class AttendanceService {
  final CollectionReference _attendReference =
      FirebaseFirestore.instance.collection('attendance');

  // final CollectionReference _classReference =
  //     FirebaseFirestore.instance.collection('classes');

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
  }) async {
    try {
      // update Attendance Data to Firestore
      await _attendReference.doc(id).update({
        'attend': attend,
        'description': description,
      });

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
}
