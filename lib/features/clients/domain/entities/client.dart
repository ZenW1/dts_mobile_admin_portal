import 'package:uuid/uuid.dart';

enum ClientStatus { active, inactive, prospect }

/// Client domain entity
class Client {
  final String id;
  final String name;
  final String company;
  final String email;
  final String? phone;
  final int totalProjects;
  final ClientStatus status;
  final String? imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  Client({
    String? id,
    required this.name,
    required this.company,
    required this.email,
    this.phone,
    this.totalProjects = 0,
    required this.status,
    this.imageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  Client copyWith({
    String? id,
    String? name,
    String? company,
    String? email,
    String? phone,
    int? totalProjects,
    ClientStatus? status,
    String? imageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Client(
      id: id ?? this.id,
      name: name ?? this.name,
      company: company ?? this.company,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      totalProjects: totalProjects ?? this.totalProjects,
      status: status ?? this.status,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
