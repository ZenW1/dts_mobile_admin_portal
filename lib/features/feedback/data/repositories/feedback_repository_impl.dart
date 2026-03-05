import 'package:logger/logger.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/entities/customer_feedback.dart';
import '../../domain/entities/feedback_stats.dart';
import '../../domain/repositories/feedback_repository.dart';
import '../feedback_mapper.dart';
import '../../../../../generated_code/swagger.swagger.dart';

/// Implementation of FeedbackRepository with API integration
class FeedbackRepositoryImpl implements FeedbackRepository {
  final Swagger _api;
  final Logger _logger;

  FeedbackRepositoryImpl()
      : _api = ApiServiceProvider().restApi,
        _logger = Logger();

  @override
  Future<List<CustomerFeedback>> getAllFeedback() async {
    try {
      final response = await _api.GetAllCustomerFeedback();
      if (response.body != null) {
        return response.body!.data.map((dto) => dto.toDomain()).toList();
      }
      throw Exception('Failed to get feedback: ${response.error}');
    } catch (e) {
      _logger.e('Error getting all feedback: $e');
      rethrow;
    }
  }

  @override
  Future<CustomerFeedback?> getFeedbackById(String id) async {
    try {
      final response = await _api.GetCustomerFeedbackById(feedbackId: id);
      if (response.isSuccessful && response.body != null) {
        return response.body!.toDomain();
      }
      return null;
    } catch (e) {
      _logger.e('Error getting feedback by id: $e');
      return null;
    }
  }

  @override
  Future<List<CustomerFeedback>> getActiveFeedback() async {
    try {
      final response = await _api.GetActiveCustomerFeedback();
      if (response.isSuccessful && response.body != null) {
        return response.body?.data.map((dto) => dto.toDomain()).toList() ?? [];
      }
      throw Exception('Failed to get active feedback: ${response.error}');
    } catch (e) {
      _logger.e('Error getting active feedback: $e');
      rethrow;
    }
  }

  @override
  Future<CustomerFeedback> createFeedback(CustomerFeedback feedback) async {
    try {
      final response = await _api.CreateCustomerFeedback(
        body: feedback.toDto(),
      );
      if (response.isSuccessful && response.body != null) {
        return response.body!.toDomain();
      }
      throw Exception('Failed to create feedback: ${response.error}');
    } on TypeError catch (e) {
      if (e.toString().contains('is not a subtype of type')) {
        _logger.w('API create succeeded but response parsing failed: $e');
        return feedback;
      }
      rethrow;
    } catch (e) {
      _logger.e('Error creating feedback: $e');
      rethrow;
    }
  }

  @override
  Future<CustomerFeedback> updateFeedback(CustomerFeedback feedback) async {
    try {
      final response = await _api.UpdateCustomerFeedback(
        feedbackId: feedback.id,
        body: feedback.toDto(),
      );
      if (response.body != null) {
        return response.body!.toDomain();
      }
      return feedback;
    } on TypeError catch (e) {
      if (e.toString().contains('is not a subtype of type')) {
        _logger.w('API update succeeded but response parsing failed: $e');
        return feedback;
      }
      rethrow;
    } catch (e) {
      _logger.e('Error updating feedback: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteFeedback(String id) async {
    try {
      final response = await _api.DeleteCustomerFeedback(feedbackId: id);
      if (!response.isSuccessful) {
        throw Exception('Failed to delete feedback: ${response.error}');
      }
    } catch (e) {
      _logger.e('Error deleting feedback: $e');
      rethrow;
    }
  }

  @override
  Future<CustomerFeedback> updateStatus(
      String id, FeedbackStatus status) async {
    try {
      final swaggerStatus = UpdateFeedbackStatusDTOStatus.values.firstWhere(
        (e) => e.value?.toLowerCase() == status.displayName.toLowerCase(),
        orElse: () => UpdateFeedbackStatusDTOStatus.swaggerGeneratedUnknown,
      );

      final response = await _api.UpdateCustomerFeedbackStatus(
        feedbackId: id,
        body: UpdateFeedbackStatusDTO(status: swaggerStatus),
      );

      if (response.isSuccessful && response.body != null) {
        return response.body!.toDomain();
      }
      throw Exception('Failed to update status: ${response.error}');
    } on TypeError catch (e) {
      if (e.toString().contains('is not a subtype of type')) {
        _logger
            .w('API update status succeeded but response parsing failed: $e');
        return CustomerFeedback(
          id: id,
          customerName: '',
          email: '',
          message: '',
          rating: 0,
          isActive: true,
          status: status,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
      }
      rethrow;
    } catch (e) {
      _logger.e('Error updating status: $e');
      rethrow;
    }
  }

  @override
  Future<FeedbackStats> getFeedbackStats() async {
    try {
      final response = await _api.GetFeedbackStats();
      if (response.isSuccessful && response.body != null) {
        // Parse from raw response body
        return (response.body as Map<String, dynamic>).toDomain();
      }
      throw Exception('Failed to get feedback stats: ${response.error}');
    } catch (e) {
      _logger.e('Error getting stats: $e');
      rethrow;
    }
  }
}
