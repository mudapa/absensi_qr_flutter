import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/attendance_model.dart';
import '../../service/attendance_service.dart';

part 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  AttendanceCubit() : super(AttendanceInitial());

  // Get all attendances from Firestore
  void getAttendances() async {
    try {
      // Set AttendanceLoading
      emit(AttendanceLoading());

      // Get all attendances from Firestore
      List<AttendanceModel> attendances =
          await AttendanceService().getAttendances();

      // Set AttendanceSuccess
      emit(AttendanceSuccess(attendances: attendances));
    } catch (e) {
      // Set AttendanceFailed
      emit(AttendanceFailed(error: e.toString()));
    }
  }

  // Update attendance to Firestore
  void updateAttendance({
    required String id,
    required String attend,
    required String description,
    required String grade,
    required DateTime enter,
  }) async {
    try {
      // Set AttendanceLoading
      emit(AttendanceLoading());

      // Update attendance to Firestore
      AttendanceModel updateAttendance =
          await AttendanceService().updateAttendance(
        id: id,
        attend: attend,
        description: description,
        grade: grade,
        enter: enter,
      );

      // Set UpdateAttendanceSuccess
      emit(UpdateAttendanceSuccess(updateAttendance: updateAttendance));
    } catch (e) {
      // Set AttendanceFailed
      emit(AttendanceFailed(error: e.toString()));
    }
  }

  // filter attendance by grade from Firestore
  void filterAttendance({
    required String grade,
  }) async {
    try {
      // Set AttendanceLoading
      emit(AttendanceLoading());

      // filter attendance by grade from Firestore
      List<AttendanceModel> attendances =
          await AttendanceService().filterAttendances(
        grade: grade,
      );

      // Set AttendanceSuccess
      emit(AttendanceSuccess(attendances: attendances));
    } catch (e) {
      // Set AttendanceFailed
      emit(AttendanceFailed(error: e.toString()));
    }
  }

  // Add attendance to Firestore
  void scanAttendancesEnter({
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
      // Set AttendanceLoading
      emit(AttendanceLoading());

      // Add attendance to Firestore
      await AttendanceService().scanAttendancesEnter(
        id: id,
        attend: attend,
        description: description,
        enter: enter,
        exit: exit,
        name: name,
        grade: grade,
        phone: phone,
        nis: nis,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

      // Set AddAttendanceSuccess
      emit(AddAttendanceSuccess(
        addAttendance: AttendanceModel(
          id: id,
          attend: attend,
          description: description,
          enter: enter,
          exit: exit,
          name: name,
          grade: grade,
          phone: phone,
          nis: nis,
          createdAt: createdAt,
          updatedAt: updatedAt,
        ),
      ));
    } catch (e) {
      // Set AttendanceFailed
      emit(AttendanceFailed(error: e.toString()));
    }
  }

  // Exit attendance to Firestore
  void scanAttendancesExit({
    required String id,
    required DateTime exit,
    required String grade,
    required DateTime enter,
  }) async {
    try {
      // Set AttendanceLoading
      emit(AttendanceLoading());

      // Exit attendance to Firestore
      await AttendanceService().scanAttendancesExit(
        id: id,
        exit: exit,
        grade: grade,
        enter: enter,
      );

      // Set AddAttendanceSuccess
      emit(AddAttendanceSuccess(
        addAttendance: AttendanceModel(
          id: id,
          exit: exit,
        ),
      ));
    } catch (e) {
      // Set AttendanceFailed
      emit(AttendanceFailed(error: e.toString()));
    }
  }

  // get attendance by attend HADIR from Firestore
  void getAttendancesHadir() async {
    try {
      // Set AttendanceLoading
      emit(AttendanceLoading());

      // get attendance by attend HADIR from Firestore
      List<AttendanceModel> attendances =
          await AttendanceService().getAttendancesHadir();

      // Set AttendanceSuccess
      emit(AttendanceSuccess(attendances: attendances));
    } catch (e) {
      // Set AttendanceFailed
      emit(AttendanceFailed(error: e.toString()));
    }
  }
}
