// import '../../../../generated_code/swagger.swagger.dart';
// import '../domain/entities/team_member.dart';
//
// extension TeamMemberMapper on TeamResponseDTO {
//   TeamMember toDomain() {
//     return TeamMember(
//       id: id,
//       name: name,
//       avatar: avatar,
//       description: description,
//       role: role,
//       isActive: isActive ?? true,
//       createdAt: createdAt ?? DateTime.now(),
//       updatedAt: updatedAt ?? DateTime.now(),
//     );
//   }
// }
//
// extension TeamMemberMapMapper on Map<String, dynamic> {
//   TeamMember toDomain() {
//     return TeamMember(
//       id: this['_id'] ?? this['id'] ?? '',
//       name: this['name'] ?? '',
//       avatar: this['avatar'],
//       description: this['description'],
//       role: this['role'],
//       isActive: this['isActive'] ?? true,
//       createdAt: this['createdAt'] != null
//           ? DateTime.tryParse(this['createdAt'])
//           : null,
//       updatedAt: this['updatedAt'] != null
//           ? DateTime.tryParse(this['updatedAt'])
//           : null,
//     );
//   }
// }
//
// extension TeamMemberDomainMapper on TeamMember {
//   CreateTeamDTO toCreateDto() {
//     return CreateTeamDTO(
//       name: name,
//       avatar: avatar,
//       description: description,
//       role: role,
//       isActive: isActive,
//     );
//   }
//
//   CreateTeamDTO toUpdateDto() {
//     return CreateTeamDTO(
//       name: name,
//       avatar: avatar,
//       description: description,
//       role: role,
//       isActive: isActive,
//     );
//   }
// }
