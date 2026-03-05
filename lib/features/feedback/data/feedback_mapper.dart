import '../domain/entities/customer_feedback.dart';
import '../domain/entities/feedback_stats.dart';
import '../../../../generated_code/swagger.swagger.dart';

extension CustomerFeedbackMapper on CustomerFeedbackResponseDTO {
  CustomerFeedback toDomain() {
    return CustomerFeedback(
      id: id,
      customerName: customerName,
      email: email,
      phone: phone,
      message: message,
      rating: rating?.toInt() ?? 0,
      subject: subject ?? '',
      status: FeedbackStatus.pending, // Fallback as Swagger model lacks it
      isActive: true, // Fallback as Swagger model lacks it
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }
}

extension CustomerFeedbackDomainMapper on CustomerFeedback {
  CreateCustomerFeedbackDTO toDto() {
    return CreateCustomerFeedbackDTO(
      customerName: customerName ?? '',
      email: email ?? '',
      phone: phone,
      message: message ?? '',
      rating: rating?.toDouble(),
      subject: subject,
    );
  }
}

extension FeedbackStatsMapper on Map<String, dynamic> {
  FeedbackStats toDomain() {
    return FeedbackStats(
      totalCount: this['totalCount'] ?? 0,
      pendingCount: this['pendingCount'] ?? 0,
      reviewedCount: this['reviewedCount'] ?? 0,
      resolvedCount: this['resolvedCount'] ?? 0,
      averageRating: (this['averageRating'] ?? 0.0).toDouble(),
    );
  }
}
