import 'package:equatable/equatable.dart';

class StudentModel extends Equatable {
  final String id;
  final int nis;
  final String name;
  final String gender;
  final String grade;
  final int phone;
  final DateTime? createdAt;
  final DateTime updatedAt;

  const StudentModel({
    required this.id,
    required this.nis,
    required this.name,
    required this.gender,
    required this.grade,
    required this.phone,
    this.createdAt,
    required this.updatedAt,
  });

  factory StudentModel.fromJson(String id, Map<String, dynamic> json) {
    return StudentModel(
      id: id,
      nis: json['nis'],
      name: json['name'],
      gender: json['gender'],
      grade: json['grade'],
      phone: json['phone'],
      createdAt: json['createdAt'].toDate(),
      updatedAt: json['updatedAt'].toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nis': nis,
      'name': name,
      'gender': gender,
      'grade': grade,
      'phone': phone,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        gender,
        grade,
        phone,
        createdAt,
        updatedAt,
      ];
}
