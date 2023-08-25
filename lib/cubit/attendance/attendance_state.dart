part of 'attendance_cubit.dart';

sealed class AttendanceState extends Equatable {
  const AttendanceState();

  @override
  List<Object> get props => [];
}

final class AttendanceInitial extends AttendanceState {}

final class AttendanceLoading extends AttendanceState {}

final class AttendanceSuccess extends AttendanceState {
  final List<AttendanceModel> attendances;

  const AttendanceSuccess({
    required this.attendances,
  });

  @override
  List<Object> get props => [
        attendances,
      ];
}

final class AddAttendanceSuccess extends AttendanceState {
  final AttendanceModel addAttendance;

  const AddAttendanceSuccess({
    required this.addAttendance,
  });

  @override
  List<Object> get props => [
        addAttendance,
      ];
}

final class UpdateAttendanceSuccess extends AttendanceState {
  final AttendanceModel updateAttendance;

  const UpdateAttendanceSuccess({
    required this.updateAttendance,
  });

  @override
  List<Object> get props => [
        updateAttendance,
      ];
}

final class AttendanceFailed extends AttendanceState {
  final String error;

  const AttendanceFailed({
    required this.error,
  });

  @override
  List<Object> get props => [
        error,
      ];
}
