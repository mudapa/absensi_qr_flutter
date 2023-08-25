import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/student_model.dart';

class StudentService {
  final CollectionReference _studentReference =
      FirebaseFirestore.instance.collection('students');

  // get Student Data from Firestore
  Future<List<StudentModel>> getStudents() async {
    try {
      // get Student Data from Firestore
      QuerySnapshot result = await _studentReference
          .orderBy(
            'createdAt',
            descending: false,
          )
          .get();

      // convert to list of students
      List<StudentModel> students = result.docs.map(
        (e) {
          return StudentModel.fromJson(e.id, e.data() as Map<String, dynamic>);
        },
      ).toList();

      // Return List of StudentModel
      return students;
    } catch (e) {
      rethrow;
    }
  }

  // add Student Data to Firestore
  Future<StudentModel> addStudent({
    required int nis,
    required String name,
    required String gender,
    required String grade,
    required int phone,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) async {
    try {
      // create Student Data to Firestore
      DocumentReference result = await _studentReference.add({
        'nis': nis,
        'name': name,
        'gender': gender,
        'grade': grade,
        'phone': phone,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      });

      // Return StudentModel
      return StudentModel(
        id: result.id,
        nis: nis,
        name: name,
        gender: gender,
        grade: grade,
        phone: phone,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
    } catch (e) {
      rethrow;
    }
  }

  // update Student Data to Firestore
  Future<StudentModel> updateStudent({
    required String id,
    required int nis,
    required String name,
    required String gender,
    required String grade,
    required int phone,
    required DateTime updatedAt,
  }) async {
    try {
      // update Student Data to Firestore
      await _studentReference.doc(id).update({
        'nis': nis,
        'name': name,
        'gender': gender,
        'grade': grade,
        'phone': phone,
        'updatedAt': updatedAt,
      });

      // Return StudentModel
      return StudentModel(
        id: id,
        nis: nis,
        name: name,
        gender: gender,
        grade: grade,
        phone: phone,
        updatedAt: updatedAt,
      );
    } catch (e) {
      rethrow;
    }
  }

  // delete Student Data from Firestore
  Future<StudentModel> deleteStudent({
    required String id,
  }) async {
    try {
      // delete Class Data from Firestore
      await _studentReference.doc(id).delete();

      // Return StudentModel
      return StudentModel(
        id: id,
        nis: 0,
        name: '',
        gender: '',
        grade: '',
        phone: 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    } catch (e) {
      rethrow;
    }
  }

  // filter Student Data from Firestore
  Future<List<StudentModel>> filterStudent({
    required String grade,
  }) async {
    try {
      // get Student Data from Firestore
      QuerySnapshot result = await _studentReference
          .where(
            'grade',
            isEqualTo: grade,
          )
          .get();

      // convert to list of students
      List<StudentModel> students = result.docs.map(
        (e) {
          return StudentModel.fromJson(e.id, e.data() as Map<String, dynamic>);
        },
      ).toList();

      // Return List of StudentModel
      return students;
    } catch (e) {
      rethrow;
    }
  }
}
