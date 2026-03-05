/// Feedback statistics entity
class FeedbackStats {
  final int totalCount;
  final int pendingCount;
  final int reviewedCount;
  final int resolvedCount;
  final double averageRating;

  const FeedbackStats({
    this.totalCount = 0,
    this.pendingCount = 0,
    this.reviewedCount = 0,
    this.resolvedCount = 0,
    this.averageRating = 0.0,
  });

  FeedbackStats copyWith({
    int? totalCount,
    int? pendingCount,
    int? reviewedCount,
    int? resolvedCount,
    double? averageRating,
  }) {
    return FeedbackStats(
      totalCount: totalCount ?? this.totalCount,
      pendingCount: pendingCount ?? this.pendingCount,
      reviewedCount: reviewedCount ?? this.reviewedCount,
      resolvedCount: resolvedCount ?? this.resolvedCount,
      averageRating: averageRating ?? this.averageRating,
    );
  }

  /// Create from JSON (API response)
  factory FeedbackStats.fromJson(Map<String, dynamic> json) {
    return FeedbackStats(
      totalCount: json['totalCount'] ?? 0,
      pendingCount: json['pendingCount'] ?? 0,
      reviewedCount: json['reviewedCount'] ?? 0,
      resolvedCount: json['resolvedCount'] ?? 0,
      averageRating: (json['averageRating'] ?? 0.0).toDouble(),
    );
  }
}
