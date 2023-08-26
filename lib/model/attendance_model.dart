import 'package:equatable/equatable.dart';

class AttendanceModel extends Equatable {
  final String id;
  final int? nis;
  final String? name;
  final String? attend;
  final String? grade;
  final DateTime? enter;
  final DateTime? exit;
  final String? description;
  final int? phone;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const AttendanceModel({
    required this.id,
    this.nis,
    this.name,
    this.attend,
    this.grade,
    this.enter,
    this.exit,
    this.description,
    this.phone,
    this.createdAt,
    this.updatedAt,
  });

  factory AttendanceModel.fromJson(String id, Map<String, dynamic> json) {
    return AttendanceModel(
      id: id,
      nis: json['nis'],
      name: json['name'],
      attend: json['attend'],
      grade: json['grade'],
      enter: json['enter'].toDate(),
      exit: json['exit'].toDate(),
      description: json['description'],
      phone: json['phone'],
      createdAt: json['createdAt'].toDate(),
      updatedAt: json['updatedAt'].toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nis': nis,
      'name': name,
      'attend': attend,
      'grade': grade,
      'enter': enter,
      'exit': exit,
      'description': description,
      'phone': phone,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        attend,
        grade,
        enter,
        exit,
        description,
        phone,
        createdAt,
        updatedAt,
      ];
}
