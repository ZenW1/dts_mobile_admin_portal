/// ProductColor entity
class ProductColor {
  final String id;
  final String name;
  final String? hexCode;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ProductColor({
    required this.id,
    required this.name,
    this.hexCode,
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
  });

  ProductColor copyWith({
    String? id,
    String? name,
    String? hexCode,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductColor(
      id: id ?? this.id,
      name: name ?? this.name,
      hexCode: hexCode ?? this.hexCode,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
