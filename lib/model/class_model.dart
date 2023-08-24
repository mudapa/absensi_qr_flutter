import 'package:equatable/equatable.dart';

class ClassModel extends Equatable {
  final String id;
  final String name;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ClassModel({
    required this.id,
    required this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory ClassModel.fromJson(String id, Map<String, dynamic> json) {
    return ClassModel(
      id: id,
      name: json['name'],
      createdAt: json['createdAt'].toDate(),
      updatedAt: json['updatedAt'].toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        createdAt,
        updatedAt,
      ];
}
