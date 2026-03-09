// import '../domain/entities/product.dart';
// import '../../../../generated_code/swagger.swagger.dart';
//
// extension ProductMapper on Map<String, dynamic> {
//   Product toDomain() {
//     return Product(
//       id: this['_id'] ?? '',
//       name: this['name'] ?? '',
//       description: this['description'],
//       price: (this['price'] as num?)?.toDouble() ?? 0.0,
//       imageUrl: this['image'],
//       categoryId: this['categoryId'],
//       colorId: this['colorId'],
//       materialId: this['materialId'],
//       isActive: this['isActive'] ?? true,
//       createdAt: this['createdAt'] != null
//           ? DateTime.tryParse(this['createdAt'])
//           : null,
//       updatedAt: this['updatedAt'] != null
//           ? DateTime.tryParse(this['updatedAt'])
//           : null,
//     );
//   }
// }
//
// extension ProductDomainMapper on Product {
//   CreateProductDTO toCreateDto() {
//     return CreateProductDTO(
//       name: name,
//       price: price,
//       stock: 0,
//       description: description,
//       image: imageUrl,
//       categoryId: categoryId ?? '',
//       isActive: isActive,
//     );
//   }
// }
