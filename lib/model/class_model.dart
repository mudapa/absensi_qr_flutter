import 'package:equatable/equatable.dart';

class ClassModel extends Equatable {
  final String id;
  final String grade;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ClassModel({
    required this.id,
    required this.grade,
    this.createdAt,
    this.updatedAt,
  });

  factory ClassModel.fromJson(String id, Map<String, dynamic> json) {
    return ClassModel(
      id: id,
      grade: json['grade'],
      createdAt: json['createdAt'].toDate(),
      updatedAt: json['updatedAt'].toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'grade': grade,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  List<Object?> get props => [
        id,
        grade,
        createdAt,
        updatedAt,
      ];
}
