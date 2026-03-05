import 'package:dts_admin_portal/generated_code/swagger.swagger.dart';

/// Job repository interface
abstract class JobRepository {
  /// Get all jobs
  Future<GetAllCareersResponseDTO> getAllJobs();

  /// Get job by id
  Future<CareerResponseDTO?> getJobById(String id);

  /// Create a new job
  Future<CareerResponseDTO> createJob(CreateCareerDTO job);

  /// Update an existing job
  Future<CareerResponseDTO> updateJob(String id, CreateCareerDTO job);

  /// Delete a job
  Future<void> deleteJob(String id);
}
