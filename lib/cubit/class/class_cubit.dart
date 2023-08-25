import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/class_model.dart';
import '../../service/class_service.dart';

part 'class_state.dart';

class ClassCubit extends Cubit<ClassState> {
  ClassCubit() : super(ClassInitial());

  // Get all classes from Firestore
  void getClasses() async {
    try {
      // Set ClassLoading
      emit(ClassLoading());

      // Get all classes from Firestore
      List<ClassModel> classes = await ClassService().getClasses();

      // Set ClassSuccess
      emit(ClassSuccess(classes: classes));
    } catch (e) {
      // Set ClassFailed
      emit(ClassFailed(error: e.toString()));
    }
  }

  // Add class to Firestore
  void addClass({
    required String grade,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) async {
    try {
      // Set ClassLoading
      emit(ClassLoading());

      // Add class to Firestore
      ClassModel addClasses = await ClassService().addClass(
        grade: grade,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

      // Set AddClassSuccess
      emit(AddClassSuccess(addClasses: addClasses));
    } catch (e) {
      // Set ClassFailed
      emit(ClassFailed(error: e.toString()));
    }
  }

  // Update class to Firestore
  void updateClass({
    required String id,
    required String grade,
    required DateTime updatedAt,
  }) async {
    try {
      // Set ClassLoading
      emit(ClassLoading());

      // Update class to Firestore
      ClassModel updateClasses = await ClassService().updateClass(
        id: id,
        grade: grade,
        updatedAt: updatedAt,
      );

      // Set UpdateClassSuccess
      emit(UpdateClassSuccess(updateClasses: updateClasses));
    } catch (e) {
      // Set ClassFailed
      emit(ClassFailed(error: e.toString()));
    }
  }

  // Delete class from Firestore
  void deleteClass({
    required String id,
  }) async {
    try {
      // Set ClassLoading
      emit(ClassLoading());

      // Delete class from Firestore
      await ClassService().deleteClass(
        id: id,
      );

      // Set DeleteClassSuccess
      emit(ClassInitial());
    } catch (e) {
      // Set ClassFailed
      emit(ClassFailed(error: e.toString()));
    }
  }
}
