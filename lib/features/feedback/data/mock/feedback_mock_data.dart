import '../../domain/entities/customer_feedback.dart';

/// Mock data for customer feedback
class FeedbackMockData {
  FeedbackMockData._();

  static final List<CustomerFeedback> feedbacks = [
    CustomerFeedback(
      id: 'fb-001',
      customerName: 'John Doe',
      email: 'john.doe@example.com',
      phone: '+1234567890',
      message:
          'Great product quality and excellent customer service! The team was very responsive and helpful throughout the process.',
      rating: 5,
      subject: 'Product Quality Feedback',
      status: FeedbackStatus.pending,
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    CustomerFeedback(
      id: 'fb-002',
      customerName: 'Jane Smith',
      email: 'jane.smith@example.com',
      phone: '+0987654321',
      message:
          'The delivery was faster than expected. Very impressed with the packaging quality.',
      rating: 4,
      subject: 'Delivery Experience',
      status: FeedbackStatus.reviewed,
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      updatedAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    CustomerFeedback(
      id: 'fb-003',
      customerName: 'Robert Johnson',
      email: 'robert.j@example.com',
      phone: '+1122334455',
      message:
          'Had an issue with my order initially, but the support team resolved it quickly. Appreciate the prompt response.',
      rating: 4,
      subject: 'Customer Support',
      status: FeedbackStatus.resolved,
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      updatedAt: DateTime.now().subtract(const Duration(days: 4)),
    ),
    CustomerFeedback(
      id: 'fb-004',
      customerName: 'Emily Davis',
      email: 'emily.d@example.com',
      message:
          'Love the new designs! Will definitely recommend to friends and family.',
      rating: 5,
      subject: 'Design Appreciation',
      status: FeedbackStatus.pending,
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      updatedAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    CustomerFeedback(
      id: 'fb-005',
      customerName: 'Michael Brown',
      email: 'michael.b@example.com',
      phone: '+5544332211',
      message:
          'Good products but could improve on the customization options available.',
      rating: 3,
      subject: 'Product Suggestions',
      status: FeedbackStatus.reviewed,
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      updatedAt: DateTime.now().subtract(const Duration(days: 6)),
    ),
    CustomerFeedback(
      id: 'fb-006',
      customerName: 'Sarah Wilson',
      email: 'sarah.w@example.com',
      phone: '+6677889900',
      message:
          'The installation service was professional and efficient. Very happy with the results!',
      rating: 5,
      subject: 'Installation Service',
      status: FeedbackStatus.resolved,
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      updatedAt: DateTime.now().subtract(const Duration(days: 8)),
    ),
    CustomerFeedback(
      id: 'fb-007',
      customerName: 'David Lee',
      email: 'david.lee@example.com',
      message:
          'Pricing is competitive. Would like to see more discount options for bulk orders.',
      rating: 4,
      subject: 'Pricing Feedback',
      status: FeedbackStatus.pending,
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(hours: 12)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 12)),
    ),
    CustomerFeedback(
      id: 'fb-008',
      customerName: 'Lisa Anderson',
      email: 'lisa.a@example.com',
      phone: '+1234509876',
      message:
          'Website is easy to navigate. Would appreciate a mobile app for easier ordering.',
      rating: 4,
      subject: 'Website Experience',
      status: FeedbackStatus.reviewed,
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 4)),
      updatedAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
  ];
}
