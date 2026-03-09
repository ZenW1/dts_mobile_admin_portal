import '../domain/entities/product_color.dart';
import '../../../../generated_code/swagger.swagger.dart';

extension ProductColorMapper on Map<String, dynamic> {
  ProductColor toDomain() {
    return ProductColor(
      id: this['_id'] ?? '',
      name: this['name'] ?? '',
      hexCode: this['hexCode'],
      isActive: this['isActive'] ?? true,
      createdAt: this['createdAt'] != null
          ? DateTime.tryParse(this['createdAt'])
          : null,
      updatedAt: this['updatedAt'] != null
          ? DateTime.tryParse(this['updatedAt'])
          : null,
    );
  }
}

extension ProductColorDomainMapper on ProductColor {
  CreateProductColorDTO toCreateDto() {
    return CreateProductColorDTO(
      name: name,
      hexCode: hexCode,
    );
  }
}
