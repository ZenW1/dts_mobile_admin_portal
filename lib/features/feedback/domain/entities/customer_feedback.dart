/// Customer feedback status enum
enum FeedbackStatus {
  pending,
  reviewed,
  resolved,
}

/// Extension for FeedbackStatus
extension FeedbackStatusExtension on FeedbackStatus {
  String get displayName {
    switch (this) {
      case FeedbackStatus.pending:
        return 'Pending';
      case FeedbackStatus.reviewed:
        return 'Reviewed';
      case FeedbackStatus.resolved:
        return 'Resolved';
    }
  }

  static FeedbackStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'reviewed':
        return FeedbackStatus.reviewed;
      case 'resolved':
        return FeedbackStatus.resolved;
      default:
        return FeedbackStatus.pending;
    }
  }
}

/// Customer feedback entity
///
class CustomerFeedback {
  final String id;
  final String? customerName;
  final String? email;
  final String? phone;
  final String? message;
  final int? rating;
  final String? subject;
  final FeedbackStatus status;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  CustomerFeedback({
    required this.id,
    required this.customerName,
    required this.email,
    this.phone,
    required this.message,
     this.rating,
    this.subject,
    this.status = FeedbackStatus.pending,
    this.isActive = true,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  CustomerFeedback copyWith({
    String? id,
    String? customerName,
    String? email,
    String? phone,
    String? message,
    int? rating,
    String? subject,
    FeedbackStatus? status,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CustomerFeedback(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      message: message ?? this.message,
      rating: rating ?? this.rating,
      subject: subject ?? this.subject,
      status: status ?? this.status,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Create from JSON (API response)
  factory CustomerFeedback.fromJson(Map<String, dynamic> json) {
    return CustomerFeedback(
      id: json['_id'] ?? json['id'] ?? '',
      customerName: json['customerName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      message: json['message'] ?? '',
      rating: json['rating'] ?? 0,
      subject: json['subject'] ?? '',
      status: FeedbackStatusExtension.fromString(json['status'] ?? 'pending'),
      isActive: json['isActive'] ?? true,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
    );
  }

  /// Convert to JSON (for API request)
  Map<String, dynamic> toJson() {
    return {
      'customerName': customerName,
      'email': email,
      'phone': phone,
      'message': message,
      'rating': rating,
      'subject': subject,
    };
  }
}
