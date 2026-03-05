import 'package:uuid/uuid.dart';

/// Portfolio item entity
class Portfolio {
  final String id;
  final String title;
  final String? description;
  final String? imageUrl;
  final List<String> galleryImages;
  final String categoryId;
  final String? clientName;
  final DateTime? projectDate;
  final bool isFeatured;
  final DateTime createdAt;
  final DateTime updatedAt;

  Portfolio({
    String? id,
    required this.title,
    this.description,
    this.imageUrl,
    this.galleryImages = const [],
    required this.categoryId,
    this.clientName,
    this.projectDate,
    this.isFeatured = false,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  Portfolio copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    List<String>? galleryImages,
    String? categoryId,
    String? clientName,
    DateTime? projectDate,
    bool? isFeatured,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Portfolio(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      galleryImages: galleryImages ?? this.galleryImages,
      categoryId: categoryId ?? this.categoryId,
      clientName: clientName ?? this.clientName,
      projectDate: projectDate ?? this.projectDate,
      isFeatured: isFeatured ?? this.isFeatured,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
