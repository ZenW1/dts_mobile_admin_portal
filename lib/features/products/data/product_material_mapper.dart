import '../domain/entities/product_material.dart';
import '../../../../generated_code/swagger.swagger.dart';

extension ProductMaterialMapper on Map<String, dynamic> {
  ProductMaterial toDomain() {
    return ProductMaterial(
      id: this['_id'] ?? '',
      name: this['name'] ?? '',
      description: this['description'],
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

extension ProductMaterialDomainMapper on ProductMaterial {
  CreateProductMaterialDTO toCreateDto() {
    return CreateProductMaterialDTO(
      name: name,
      description: description,
    );
  }
}
