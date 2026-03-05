import '../../../../core/network/dio_client.dart';
import '../../../../generated_code/swagger.swagger.dart';
import '../../domain/repositories/job_repository.dart';

/// Implementation of JobRepository using Career API via ApiServiceProvider
/// Implementation of JobRepository using Career API via ApiServiceProvider
class JobRepositoryImpl implements JobRepository {
  final _api = ApiServiceProvider().restApi;

  @override
  Future<GetAllCareersResponseDTO> getAllJobs() async {
    try {
      final response = await ApiServiceProvider().restApi.GetAllCareers();
       return response.body ?? GetAllCareersResponseDTO(data : []);
    } catch (e) {
      throw Exception('Error fetching jobs: $e');
    }
  }

  @override
  Future<CareerResponseDTO?> getJobById(String id) async {
    final response = await _api.GetCareerById(careerId: id);
    if (response.isSuccessful && response.body != null) {
      return response.body!;
    }
    return null;
  }

  @override
  Future<CareerResponseDTO> createJob(CreateCareerDTO job) async {
    final response = await _api.CreateCareer(body: job);
    if (response.isSuccessful && response.body != null) {
      return response.body!;
    }
    throw Exception('Failed to create job: ${response.error}');
  }

  @override
  Future<CareerResponseDTO> updateJob(String id, CreateCareerDTO job) async {
    final response = await _api.UpdateCareer(
      careerId: id,
      body: job,
    );
    if (response.isSuccessful && response.body != null) {
      return response.body!;
    }
    throw Exception('Failed to update job: ${response.error}');
  }

  @override
  Future<void> deleteJob(String id) async {
    final response = await _api.DeleteCareer(careerId: id);
    if (!response.isSuccessful) {
      throw Exception('Failed to delete job: ${response.error}');
    }
  }
}
