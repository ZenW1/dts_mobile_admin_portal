// import 'package:uuid/uuid.dart';
//
// /// Team member domain entity
// class TeamMember {
//   final String id;
//   final String name;
//   final String? avatar;
//   final String? description;
//   final String? role;
//   final bool isActive;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//
//   TeamMember({
//     String? id,
//     required this.name,
//     this.avatar,
//     this.description,
//     this.role,
//     this.isActive = true,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//   })  : id = id ?? const Uuid().v4(),
//         createdAt = createdAt ?? DateTime.now(),
//         updatedAt = updatedAt ?? DateTime.now();
//
//   TeamMember copyWith({
//     String? id,
//     String? name,
//     String? avatar,
//     String? description,
//     String? role,
//     bool? isActive,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//   }) {
//     return TeamMember(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       avatar: avatar ?? this.avatar,
//       description: description ?? this.description,
//       role: role ?? this.role,
//       isActive: isActive ?? this.isActive,
//       createdAt: createdAt ?? this.createdAt,
//       updatedAt: updatedAt ?? this.updatedAt,
//     );
//   }
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is TeamMember &&
//           runtimeType == other.runtimeType &&
//           id == other.id &&
//           name == other.name &&
//           avatar == other.avatar &&
//           description == other.description &&
//           role == other.role &&
//           isActive == other.isActive &&
//           createdAt == other.createdAt &&
//           updatedAt == other.updatedAt;
//
//   @override
//   int get hashCode =>
//       id.hashCode ^
//       name.hashCode ^
//       avatar.hashCode ^
//       description.hashCode ^
//       role.hashCode ^
//       isActive.hashCode ^
//       createdAt.hashCode ^
//       updatedAt.hashCode;
// }
