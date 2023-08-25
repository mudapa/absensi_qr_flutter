import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/student_model.dart';
import '../../service/student_service.dart';

part 'student_state.dart';

class StudentCubit extends Cubit<StudentState> {
  StudentCubit() : super(StudentInitial());

  // Get all students from Firestore
  void getStudents() async {
    try {
      // Set StudentLoading
      emit(StudentLoading());

      // Get all students from Firestore
      List<StudentModel> students = await StudentService().getStudents();

      // Set StudentSuccess
      emit(StudentSuccess(students: students));
    } catch (e) {
      // Set StudentFailed
      emit(StudentFailed(error: e.toString()));
    }
  }

  // Add student to Firestore
  void addStudent({
    required int nis,
    required String name,
    required String gender,
    required String grade,
    required int phone,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) async {
    try {
      // Set StudentLoading
      emit(StudentLoading());

      // Add student to Firestore
      StudentModel addStudent = await StudentService().addStudent(
        nis: nis,
        name: name,
        gender: gender,
        grade: grade,
        phone: phone,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

      // Set StudentSuccess
      emit(AddStudentSuccess(addStudent: addStudent));
    } catch (e) {
      // Set StudentFailed
      emit(StudentFailed(error: e.toString()));
    }
  }

  // Update student in Firestore
  void updateStudent({
    required String id,
    required int nis,
    required String name,
    required String gender,
    required String grade,
    required int phone,
    required DateTime updatedAt,
  }) async {
    try {
      // Set StudentLoading
      emit(StudentLoading());

      // Update student in Firestore
      StudentModel updateStudent = await StudentService().updateStudent(
        id: id,
        nis: nis,
        name: name,
        gender: gender,
        grade: grade,
        phone: phone,
        updatedAt: updatedAt,
      );

      // Set StudentSuccess
      emit(UpdateStudentSuccess(updateStudent: updateStudent));
    } catch (e) {
      // Set StudentFailed
      emit(StudentFailed(error: e.toString()));
    }
  }

  // Delete student from Firestore
  void deleteStudent({required String id}) async {
    try {
      // Set StudentLoading
      emit(StudentLoading());

      // Delete student from Firestore
      await StudentService().deleteStudent(
        id: id,
      );

      // Set StudentSuccess
      emit(StudentInitial());
    } catch (e) {
      // Set StudentFailed
      emit(StudentFailed(error: e.toString()));
    }
  }
}
