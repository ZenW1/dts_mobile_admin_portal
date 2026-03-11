import 'package:dts_admin_portal/generated_code/swagger.swagger.dart';

import '../entities/team_member.dart';

/// Team repository interface
abstract class TeamRepository {
  /// Get all team members
  Future<GetAllTeamsResponseDTO> getAllTeams();

  /// Get team member by id
  Future<SingleTeamResponseDTO> getTeamById(String id);

  /// Create a new team member
  Future<TeamResponseDTO> createTeam(CreateTeamDTO member);

  /// Update an existing team member
  Future<void> updateTeam(CreateTeamDTO member,String memberId);

  /// Delete a team member
  Future<void> deleteTeam(String id);
}
