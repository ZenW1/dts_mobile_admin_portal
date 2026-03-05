import '../entities/customer_feedback.dart';
import '../entities/feedback_stats.dart';

/// Feedback repository interface
abstract class FeedbackRepository {
  /// Get all feedback
  Future<List<CustomerFeedback>> getAllFeedback();

  /// Get feedback by id
  Future<CustomerFeedback?> getFeedbackById(String id);

  /// Get all active feedback
  Future<List<CustomerFeedback>> getActiveFeedback();

  /// Create a new feedback
  Future<CustomerFeedback> createFeedback(CustomerFeedback feedback);

  /// Update an existing feedback
  Future<CustomerFeedback> updateFeedback(CustomerFeedback feedback);

  /// Delete a feedback
  Future<void> deleteFeedback(String id);

  /// Update feedback status
  Future<CustomerFeedback> updateStatus(String id, FeedbackStatus status);

  /// Get feedback statistics
  Future<FeedbackStats> getFeedbackStats();
}
