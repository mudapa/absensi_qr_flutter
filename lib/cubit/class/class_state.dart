part of 'class_cubit.dart';

sealed class ClassState extends Equatable {
  const ClassState();

  @override
  List<Object> get props => [];
}

final class ClassInitial extends ClassState {}

final class ClassLoading extends ClassState {}

final class ClassSuccess extends ClassState {
  final List<ClassModel> classes;

  const ClassSuccess({
    required this.classes,
  });

  @override
  List<Object> get props => [classes];
}

final class AddClassSuccess extends ClassState {
  final ClassModel addClasses;

  const AddClassSuccess({
    required this.addClasses,
  });

  @override
  List<Object> get props => [addClasses];
}

final class UpdateClassSuccess extends ClassState {
  final ClassModel updateClasses;

  const UpdateClassSuccess({
    required this.updateClasses,
  });

  @override
  List<Object> get props => [updateClasses];
}

final class DeleteClassSuccess extends ClassState {
  final ClassModel deleteClasses;

  const DeleteClassSuccess({
    required this.deleteClasses,
  });

  @override
  List<Object> get props => [deleteClasses];
}

final class ClassFailed extends ClassState {
  final String error;

  const ClassFailed({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
