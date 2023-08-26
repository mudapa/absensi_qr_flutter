part of 'student_cubit.dart';

sealed class StudentState extends Equatable {
  const StudentState();

  @override
  List<Object> get props => [];
}

final class StudentInitial extends StudentState {}

final class StudentLoading extends StudentState {}

final class StudentSuccess extends StudentState {
  final List<StudentModel> students;

  const StudentSuccess({
    required this.students,
  });

  @override
  List<Object> get props => [
        students,
      ];
}

final class AddStudentSuccess extends StudentState {
  final StudentModel addStudent;

  const AddStudentSuccess({
    required this.addStudent,
  });

  @override
  List<Object> get props => [
        addStudent,
      ];
}

final class UpdateStudentSuccess extends StudentState {
  final StudentModel updateStudent;

  const UpdateStudentSuccess({
    required this.updateStudent,
  });

  @override
  List<Object> get props => [
        updateStudent,
      ];
}

final class FindStudentSuccess extends StudentState {
  final StudentModel findStudent;

  const FindStudentSuccess({
    required this.findStudent,
  });

  @override
  List<Object> get props => [
        findStudent,
      ];
}

final class StudentFailed extends StudentState {
  final String error;

  const StudentFailed({
    required this.error,
  });

  @override
  List<Object> get props => [
        error,
      ];
}
