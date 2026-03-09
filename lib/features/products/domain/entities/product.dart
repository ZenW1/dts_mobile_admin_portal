/// Product entity
// class Product {
//   final String id;
//   final String name;
//   final String? description;
//   final double price;
//   final String? imageUrl;
//   final String? categoryId;
//   final String? colorId;
//   final String? materialId;
//   final bool isActive;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//
//   Product({
//     String? id,
//     required this.name,
//     this.description,
//     required this.price,
//     this.imageUrl,
//     this.categoryId,
//     this.colorId,
//     this.materialId,
//     this.isActive = true,
//     this.createdAt,
//     this.updatedAt,
//   }) : id = id ?? '';
//
//   Product copyWith({
//     String? id,
//     String? name,
//     String? description,
//     double? price,
//     String? imageUrl,
//     String? categoryId,
//     String? colorId,
//     String? materialId,
//     bool? isActive,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//   }) {
//     return Product(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       description: description ?? this.description,
//       price: price ?? this.price,
//       imageUrl: imageUrl ?? this.imageUrl,
//       categoryId: categoryId ?? this.categoryId,
//       colorId: colorId ?? this.colorId,
//       materialId: materialId ?? this.materialId,
//       isActive: isActive ?? this.isActive,
//       createdAt: createdAt ?? this.createdAt,
//       updatedAt: updatedAt ?? this.updatedAt,
//     );
//   }
// }
