import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/class_model.dart';

class ClassService {
  final CollectionReference _classReference =
      FirebaseFirestore.instance.collection('classes');

  // get Class Data from Firestore
  Future<List<ClassModel>> getClasses() async {
    try {
      // get Class Data from Firestore
      QuerySnapshot result = await _classReference
          .orderBy(
            'createdAt',
            descending: false,
          )
          .get();

      // convert to list of classes
      List<ClassModel> classes = result.docs.map(
        (e) {
          return ClassModel.fromJson(e.id, e.data() as Map<String, dynamic>);
        },
      ).toList();

      // Return List of ClassModel
      return classes;
    } catch (e) {
      rethrow;
    }
  }

  // add Class Data to Firestore
  Future<ClassModel> addClass({
    required String kelas,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) async {
    try {
      // create Class Data to Firestore
      DocumentReference result = await _classReference.add({
        'name': kelas,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      });

      // Return ClassModel
      return ClassModel(
        id: result.id,
        name: kelas,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
    } catch (e) {
      rethrow;
    }
  }

  // update Class Data to Firestore
  Future<ClassModel> updateClass({
    required String id,
    required String kelas,
    required DateTime updatedAt,
  }) async {
    try {
      // update Class Data to Firestore
      await _classReference.doc(id).update({
        'name': kelas,
        'updatedAt': updatedAt,
      });

      // Return ClassModel
      return ClassModel(
        id: id,
        name: kelas,
        updatedAt: updatedAt,
      );
    } catch (e) {
      rethrow;
    }
  }

  // delete Class Data from Firestore
  Future<ClassModel> deleteClass({
    required String id,
  }) async {
    try {
      // delete Class Data from Firestore
      await _classReference.doc(id).delete();

      // Return ClassModel
      return ClassModel(
        id: id,
        name: '',
      );
    } catch (e) {
      rethrow;
    }
  }
}
