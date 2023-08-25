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
}
