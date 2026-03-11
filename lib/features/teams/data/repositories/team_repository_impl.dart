import 'package:logger/logger.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/entities/team_member.dart';
import '../../domain/repositories/team_repository.dart';
import '../team_mapper.dart';
import '../../../../../generated_code/swagger.swagger.dart';

/// Implementation of TeamRepository with API integration
class TeamRepositoryImpl implements TeamRepository {
  final Swagger _api;
  final Logger _logger;

  TeamRepositoryImpl()
      : _api = ApiServiceProvider().restApi,
        _logger = Logger();

  @override
  Future<GetAllTeamsResponseDTO> getAllTeams() async {
    try {
      final response = await _api.GetAllTeams();
      if (response.body != null) {
        return response.body!;
       }
      throw Exception('Failed to get teams: ${response.error}');
    } catch (e) {
      _logger.e('Error getting all teams: $e');
      rethrow;
    }
  }

  @override
  Future<SingleTeamResponseDTO> getTeamById(String id) async {
    try {
      final response = await _api.GetTeamById(teamId: id);
      if (response.isSuccessful && response.body != null) {
        return response.body!;
      }
      throw Exception('Failed to get team member: ${response.error}');
    } catch (e) {
      _logger.e('Error getting team member by id: $e');
      rethrow;
    }
  }

  @override
  Future<TeamResponseDTO> createTeam(CreateTeamDTO member) async {
    try {
      final response = await _api.CreateTeam(
        body: member,
      );
      if (response.isSuccessful && response.body != null) {
        final dynamic body = response.body;
        if (body is Map<String, dynamic> && body.containsKey('data')) {
          return TeamResponseDTO.fromJson(body['data'] as Map<String, dynamic>);
        }
        if (body is TeamResponseDTO) {
          return body;
        }
        if (body is Map<String, dynamic>) {
          return TeamResponseDTO.fromJson(body);
        }
      }
      throw Exception('Failed to create team member: ${response.error}');
    } on TypeError catch (e) {
      if (e.toString().contains('is not a subtype of type')) {
        _logger.w('API create succeeded but response parsing failed: $e');
      }
      rethrow;
    } catch (e) {
      _logger.e('Error creating team member: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateTeam(CreateTeamDTO member,String memberId) async {
    try {
      final response = await _api.UpdateTeam(
        teamId: memberId,
        body: member
      );
      if (!response.isSuccessful) {
        throw Exception('Failed to update team member: ${response.error}');
      }
    } on TypeError catch (e) {
      if (e.toString().contains('is not a subtype of type')) {
        _logger.w('API update succeeded but response parsing failed: $e');
      }
      rethrow;
    } catch (e) {
      _logger.e('Error updating team member: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteTeam(String id) async {
    try {
      final response = await _api.DeleteTeam(teamId: id);
      if (!response.isSuccessful) {
        throw Exception('Failed to delete team member: ${response.error}');
      }
    } catch (e) {
      _logger.e('Error deleting team member: $e');
      rethrow;
    }
  }
}
