// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'swagger.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginUserDTO _$LoginUserDTOFromJson(Map<String, dynamic> json) => LoginUserDTO(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$LoginUserDTOToJson(LoginUserDTO instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };

CreateUserDTO _$CreateUserDTOFromJson(Map<String, dynamic> json) =>
    CreateUserDTO(
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      role: createUserDTORoleFromJson(json['role']),
      phone: (json['phone'] as num).toDouble(),
      address: json['address'] as String?,
      isActive: json['isActive'] as bool?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      lastLogin: json['lastLogin'] == null
          ? null
          : DateTime.parse(json['lastLogin'] as String),
    );

Map<String, dynamic> _$CreateUserDTOToJson(CreateUserDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'role': createUserDTORoleToJson(instance.role),
      'phone': instance.phone,
      'address': instance.address,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'lastLogin': instance.lastLogin?.toIso8601String(),
    };

UserResponseDTO _$UserResponseDTOFromJson(Map<String, dynamic> json) =>
    UserResponseDTO(
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      role: userResponseDTORoleFromJson(json['role']),
      phone: (json['phone'] as num).toDouble(),
      address: json['address'] as String?,
      isActive: json['isActive'] as bool?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      lastLogin: json['lastLogin'] == null
          ? null
          : DateTime.parse(json['lastLogin'] as String),
      id: json['_id'] as String,
    );

Map<String, dynamic> _$UserResponseDTOToJson(UserResponseDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'role': userResponseDTORoleToJson(instance.role),
      'phone': instance.phone,
      'address': instance.address,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'lastLogin': instance.lastLogin?.toIso8601String(),
      '_id': instance.id,
    };

CreateProductDTO _$CreateProductDTOFromJson(Map<String, dynamic> json) =>
    CreateProductDTO(
      name: json['name'] as String,
      image: json['image'] as String?,
      categoryId: json['categoryId'] as String,
      price: (json['price'] as num).toDouble(),
      stock: (json['stock'] as num).toDouble(),
      discount: (json['discount'] as num?)?.toDouble(),
      description: json['description'] as String?,
      isActive: json['isActive'] as bool?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      variantImages: (json['variantImages'] as List<dynamic>?)
          ?.map((e) => CreateProductDTO$VariantImages$Item.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CreateProductDTOToJson(CreateProductDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
      'categoryId': instance.categoryId,
      'price': instance.price,
      'stock': instance.stock,
      'discount': instance.discount,
      'description': instance.description,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'variantImages': instance.variantImages?.map((e) => e.toJson()).toList(),
    };

ProductResponseDTO _$ProductResponseDTOFromJson(Map<String, dynamic> json) =>
    ProductResponseDTO(
      name: json['name'] as String,
      image: json['image'] as String?,
      categoryId: json['categoryId'] as String,
      price: (json['price'] as num).toDouble(),
      stock: (json['stock'] as num).toDouble(),
      discount: (json['discount'] as num?)?.toDouble(),
      description: json['description'] as String?,
      isActive: json['isActive'] as bool?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      variantImages: (json['variantImages'] as List<dynamic>?)
          ?.map((e) => ProductResponseDTO$VariantImages$Item.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      id: json['_id'] as String,
    );

Map<String, dynamic> _$ProductResponseDTOToJson(ProductResponseDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
      'categoryId': instance.categoryId,
      'price': instance.price,
      'stock': instance.stock,
      'discount': instance.discount,
      'description': instance.description,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'variantImages': instance.variantImages?.map((e) => e.toJson()).toList(),
      '_id': instance.id,
    };

MessageResponseDTO _$MessageResponseDTOFromJson(Map<String, dynamic> json) =>
    MessageResponseDTO(
      message: json['message'] as String,
    );

Map<String, dynamic> _$MessageResponseDTOToJson(MessageResponseDTO instance) =>
    <String, dynamic>{
      'message': instance.message,
    };

CreateProductCategoryDTO _$CreateProductCategoryDTOFromJson(
        Map<String, dynamic> json) =>
    CreateProductCategoryDTO(
      name: json['name'] as String,
      description: json['description'] as String?,
      isActive: json['isActive'] as bool?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CreateProductCategoryDTOToJson(
        CreateProductCategoryDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

ProductCategoryResponseDTO _$ProductCategoryResponseDTOFromJson(
        Map<String, dynamic> json) =>
    ProductCategoryResponseDTO(
      name: json['name'] as String,
      description: json['description'] as String?,
      isActive: json['isActive'] as bool?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      id: json['_id'] as String,
    );

Map<String, dynamic> _$ProductCategoryResponseDTOToJson(
        ProductCategoryResponseDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '_id': instance.id,
    };

GetAllProductCategoriesResponseDTO _$GetAllProductCategoriesResponseDTOFromJson(
        Map<String, dynamic> json) =>
    GetAllProductCategoriesResponseDTO(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => ProductCategoryResponseDTO.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$GetAllProductCategoriesResponseDTOToJson(
        GetAllProductCategoriesResponseDTO instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

OrderItemDTO _$OrderItemDTOFromJson(Map<String, dynamic> json) => OrderItemDTO(
      orderId: json['orderId'] as String?,
      productId: json['productId'] as String,
      quantity: (json['quantity'] as num).toDouble(),
    );

Map<String, dynamic> _$OrderItemDTOToJson(OrderItemDTO instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'productId': instance.productId,
      'quantity': instance.quantity,
    };

CreateOrderDTO _$CreateOrderDTOFromJson(Map<String, dynamic> json) =>
    CreateOrderDTO(
      userId: json['userId'] as String,
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => OrderItemDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$CreateOrderDTOToJson(CreateOrderDTO instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };

OrderResponseDTO _$OrderResponseDTOFromJson(Map<String, dynamic> json) =>
    OrderResponseDTO(
      userId: json['userId'] as String,
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => OrderItemDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      id: json['_id'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$OrderResponseDTOToJson(OrderResponseDTO instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'items': instance.items.map((e) => e.toJson()).toList(),
      '_id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

CreateCareerDTO _$CreateCareerDTOFromJson(Map<String, dynamic> json) =>
    CreateCareerDTO(
      title: json['title'] as String?,
      description: json['description'] as String?,
      location: json['location'] as String?,
      type: json['type'] as String?,
      salary: json['salary'] as String?,
      isActive: json['isActive'] as bool?,
    );

Map<String, dynamic> _$CreateCareerDTOToJson(CreateCareerDTO instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'location': instance.location,
      'type': instance.type,
      'salary': instance.salary,
      'isActive': instance.isActive,
    };

CareerResponseDTO _$CareerResponseDTOFromJson(Map<String, dynamic> json) =>
    CareerResponseDTO(
      title: json['title'] as String?,
      description: json['description'] as String?,
      location: json['location'] as String?,
      type: json['type'] as String?,
      salary: json['salary'] as String?,
      isActive: json['isActive'] as bool?,
      id: json['_id'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CareerResponseDTOToJson(CareerResponseDTO instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'location': instance.location,
      'type': instance.type,
      'salary': instance.salary,
      'isActive': instance.isActive,
      '_id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

GetAllCareersResponseDTO _$GetAllCareersResponseDTOFromJson(
        Map<String, dynamic> json) =>
    GetAllCareersResponseDTO(
      data: (json['data'] as List<dynamic>?)
              ?.map(
                  (e) => CareerResponseDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$GetAllCareersResponseDTOToJson(
        GetAllCareersResponseDTO instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

CreateProductColorDTO _$CreateProductColorDTOFromJson(
        Map<String, dynamic> json) =>
    CreateProductColorDTO(
      name: json['name'] as String,
      hexCode: json['hexCode'] as String?,
      isActive: json['isActive'] as bool?,
    );

Map<String, dynamic> _$CreateProductColorDTOToJson(
        CreateProductColorDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'hexCode': instance.hexCode,
      'isActive': instance.isActive,
    };

ProductColorResponseDTO _$ProductColorResponseDTOFromJson(
        Map<String, dynamic> json) =>
    ProductColorResponseDTO(
      name: json['name'] as String,
      hexCode: json['hexCode'] as String?,
      isActive: json['isActive'] as bool?,
      id: json['_id'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ProductColorResponseDTOToJson(
        ProductColorResponseDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'hexCode': instance.hexCode,
      'isActive': instance.isActive,
      '_id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

GetAllProductColorsResponseDTO _$GetAllProductColorsResponseDTOFromJson(
        Map<String, dynamic> json) =>
    GetAllProductColorsResponseDTO(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) =>
                  ProductColorResponseDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$GetAllProductColorsResponseDTOToJson(
        GetAllProductColorsResponseDTO instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

CreateProductTypeDTO _$CreateProductTypeDTOFromJson(
        Map<String, dynamic> json) =>
    CreateProductTypeDTO(
      name: json['name'] as String,
      description: json['description'] as String?,
      isActive: json['isActive'] as bool?,
    );

Map<String, dynamic> _$CreateProductTypeDTOToJson(
        CreateProductTypeDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'isActive': instance.isActive,
    };

ProductTypeResponseDTO _$ProductTypeResponseDTOFromJson(
        Map<String, dynamic> json) =>
    ProductTypeResponseDTO(
      name: json['name'] as String,
      description: json['description'] as String?,
      isActive: json['isActive'] as bool?,
      id: json['_id'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ProductTypeResponseDTOToJson(
        ProductTypeResponseDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'isActive': instance.isActive,
      '_id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

GetAllProductTypesResponseDTO _$GetAllProductTypesResponseDTOFromJson(
        Map<String, dynamic> json) =>
    GetAllProductTypesResponseDTO(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) =>
                  ProductTypeResponseDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$GetAllProductTypesResponseDTOToJson(
        GetAllProductTypesResponseDTO instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

CreateProductMaterialDTO _$CreateProductMaterialDTOFromJson(
        Map<String, dynamic> json) =>
    CreateProductMaterialDTO(
      name: json['name'] as String,
      description: json['description'] as String?,
      isActive: json['isActive'] as bool?,
    );

Map<String, dynamic> _$CreateProductMaterialDTOToJson(
        CreateProductMaterialDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'isActive': instance.isActive,
    };

ProductMaterialResponseDTO _$ProductMaterialResponseDTOFromJson(
        Map<String, dynamic> json) =>
    ProductMaterialResponseDTO(
      name: json['name'] as String,
      description: json['description'] as String?,
      isActive: json['isActive'] as bool?,
      id: json['_id'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ProductMaterialResponseDTOToJson(
        ProductMaterialResponseDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'isActive': instance.isActive,
      '_id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

GetAllProductMaterialsResponseDTO _$GetAllProductMaterialsResponseDTOFromJson(
        Map<String, dynamic> json) =>
    GetAllProductMaterialsResponseDTO(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => ProductMaterialResponseDTO.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$GetAllProductMaterialsResponseDTOToJson(
        GetAllProductMaterialsResponseDTO instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

CreatePortfolioDTO _$CreatePortfolioDTOFromJson(Map<String, dynamic> json) =>
    CreatePortfolioDTO(
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      imageUrl: json['imageUrl'] as String,
      projectUrl: json['projectUrl'] as String?,
      $client: json['client'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      jobScope: json['jobScope'] as String?,
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      isActive: json['isActive'] as bool?,
    );

Map<String, dynamic> _$CreatePortfolioDTOToJson(CreatePortfolioDTO instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'category': instance.category,
      'imageUrl': instance.imageUrl,
      'projectUrl': instance.projectUrl,
      'client': instance.$client,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'jobScope': instance.jobScope,
      'images': instance.images,
      'isActive': instance.isActive,
    };

PortfolioCategoryResponseDTO _$PortfolioCategoryResponseDTOFromJson(
        Map<String, dynamic> json) =>
    PortfolioCategoryResponseDTO(
      name: json['name'] as String,
      description: json['description'] as String?,
      isActive: json['isActive'] as bool?,
      id: json['_id'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$PortfolioCategoryResponseDTOToJson(
        PortfolioCategoryResponseDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'isActive': instance.isActive,
      '_id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

PortfolioResponseDTO _$PortfolioResponseDTOFromJson(
        Map<String, dynamic> json) =>
    PortfolioResponseDTO(
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      projectUrl: json['projectUrl'] as String?,
      $client: json['client'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      jobScope: json['jobScope'] as String?,
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      isActive: json['isActive'] as bool?,
      id: json['_id'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      category: json['category'] == null
          ? null
          : PortfolioCategoryResponseDTO.fromJson(
              json['category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PortfolioResponseDTOToJson(
        PortfolioResponseDTO instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'projectUrl': instance.projectUrl,
      'client': instance.$client,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'jobScope': instance.jobScope,
      'images': instance.images,
      'isActive': instance.isActive,
      '_id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'category': instance.category?.toJson(),
    };

GetAllPortfoliosResponseDTO _$GetAllPortfoliosResponseDTOFromJson(
        Map<String, dynamic> json) =>
    GetAllPortfoliosResponseDTO(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) =>
                  PortfolioResponseDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$GetAllPortfoliosResponseDTOToJson(
        GetAllPortfoliosResponseDTO instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

GetPortfolioDetailResponseDTO _$GetPortfolioDetailResponseDTOFromJson(
        Map<String, dynamic> json) =>
    GetPortfolioDetailResponseDTO(
      data: PortfolioResponseDTO.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetPortfolioDetailResponseDTOToJson(
        GetPortfolioDetailResponseDTO instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

UpdatePortfolioResponseDTO _$UpdatePortfolioResponseDTOFromJson(
        Map<String, dynamic> json) =>
    UpdatePortfolioResponseDTO(
      message: json['message'] as String,
      data: PortfolioResponseDTO.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdatePortfolioResponseDTOToJson(
        UpdatePortfolioResponseDTO instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data.toJson(),
    };

CreatePortfolioCategoryDTO _$CreatePortfolioCategoryDTOFromJson(
        Map<String, dynamic> json) =>
    CreatePortfolioCategoryDTO(
      name: json['name'] as String,
      description: json['description'] as String?,
      isActive: json['isActive'] as bool?,
    );

Map<String, dynamic> _$CreatePortfolioCategoryDTOToJson(
        CreatePortfolioCategoryDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'isActive': instance.isActive,
    };

GetAllPortfolioCategoriesResponseDTO
    _$GetAllPortfolioCategoriesResponseDTOFromJson(Map<String, dynamic> json) =>
        GetAllPortfolioCategoriesResponseDTO(
          data: (json['data'] as List<dynamic>?)
                  ?.map((e) => PortfolioCategoryResponseDTO.fromJson(
                      e as Map<String, dynamic>))
                  .toList() ??
              [],
        );

Map<String, dynamic> _$GetAllPortfolioCategoriesResponseDTOToJson(
        GetAllPortfolioCategoriesResponseDTO instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

CreateCustomerFeedbackDTO _$CreateCustomerFeedbackDTOFromJson(
        Map<String, dynamic> json) =>
    CreateCustomerFeedbackDTO(
      customerName: json['customerName'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      message: json['message'] as String,
      rating: (json['rating'] as num?)?.toDouble(),
      subject: json['subject'] as String?,
    );

Map<String, dynamic> _$CreateCustomerFeedbackDTOToJson(
        CreateCustomerFeedbackDTO instance) =>
    <String, dynamic>{
      'customerName': instance.customerName,
      'email': instance.email,
      'phone': instance.phone,
      'message': instance.message,
      'rating': instance.rating,
      'subject': instance.subject,
    };

CustomerFeedbackResponseDTO _$CustomerFeedbackResponseDTOFromJson(
        Map<String, dynamic> json) =>
    CustomerFeedbackResponseDTO(
      customerName: json['customerName'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      message: json['message'] as String,
      rating: (json['rating'] as num?)?.toDouble(),
      subject: json['subject'] as String?,
      id: json['_id'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CustomerFeedbackResponseDTOToJson(
        CustomerFeedbackResponseDTO instance) =>
    <String, dynamic>{
      'customerName': instance.customerName,
      'email': instance.email,
      'phone': instance.phone,
      'message': instance.message,
      'rating': instance.rating,
      'subject': instance.subject,
      '_id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

GetAllCustomerFeedbackResponseDTO _$GetAllCustomerFeedbackResponseDTOFromJson(
        Map<String, dynamic> json) =>
    GetAllCustomerFeedbackResponseDTO(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => CustomerFeedbackResponseDTO.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$GetAllCustomerFeedbackResponseDTOToJson(
        GetAllCustomerFeedbackResponseDTO instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

UpdateFeedbackStatusDTO _$UpdateFeedbackStatusDTOFromJson(
        Map<String, dynamic> json) =>
    UpdateFeedbackStatusDTO(
      status: updateFeedbackStatusDTOStatusNullableFromJson(json['status']),
    );

Map<String, dynamic> _$UpdateFeedbackStatusDTOToJson(
        UpdateFeedbackStatusDTO instance) =>
    <String, dynamic>{
      'status': updateFeedbackStatusDTOStatusNullableToJson(instance.status),
    };

TelegramIntentDTO _$TelegramIntentDTOFromJson(Map<String, dynamic> json) =>
    TelegramIntentDTO(
      productId: json['product_id'] as String,
      productName: json['product_name'] as String,
      price: json['price'] as String,
      currency: json['currency'] as String,
      sourceUrl: json['source_url'] as String,
      userId: json['user_id'] as String?,
    );

Map<String, dynamic> _$TelegramIntentDTOToJson(TelegramIntentDTO instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'product_name': instance.productName,
      'price': instance.price,
      'currency': instance.currency,
      'source_url': instance.sourceUrl,
      'user_id': instance.userId,
    };

TelegramIntentResponseDTO _$TelegramIntentResponseDTOFromJson(
        Map<String, dynamic> json) =>
    TelegramIntentResponseDTO(
      status: json['status'] as String,
      leadId: json['lead_id'] as String,
      config: json['config'] as Object,
    );

Map<String, dynamic> _$TelegramIntentResponseDTOToJson(
        TelegramIntentResponseDTO instance) =>
    <String, dynamic>{
      'status': instance.status,
      'lead_id': instance.leadId,
      'config': instance.config,
    };

ContactUsDTO _$ContactUsDTOFromJson(Map<String, dynamic> json) => ContactUsDTO(
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String,
      serviceInterest: json['serviceInterest'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ContactUsDTOToJson(ContactUsDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'serviceInterest': instance.serviceInterest,
      'message': instance.message,
    };

LeadResponseDTO _$LeadResponseDTOFromJson(Map<String, dynamic> json) =>
    LeadResponseDTO(
      productId: json['product_id'] as String,
      productName: json['product_name'] as String,
      price: json['price'] as String,
      currency: json['currency'] as String,
      sourceUrl: json['source_url'] as String,
      userId: json['user_id'] as String?,
      id: json['_id'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$LeadResponseDTOToJson(LeadResponseDTO instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'product_name': instance.productName,
      'price': instance.price,
      'currency': instance.currency,
      'source_url': instance.sourceUrl,
      'user_id': instance.userId,
      '_id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

GetAllLeadsResponseDTO _$GetAllLeadsResponseDTOFromJson(
        Map<String, dynamic> json) =>
    GetAllLeadsResponseDTO(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => LeadResponseDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$GetAllLeadsResponseDTOToJson(
        GetAllLeadsResponseDTO instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

CreateProductDTO$VariantImages$Item
    _$CreateProductDTO$VariantImages$ItemFromJson(Map<String, dynamic> json) =>
        CreateProductDTO$VariantImages$Item(
          image: json['image'] as String?,
          color: json['color'] as String?,
          material: json['material'] as String?,
        );

Map<String, dynamic> _$CreateProductDTO$VariantImages$ItemToJson(
        CreateProductDTO$VariantImages$Item instance) =>
    <String, dynamic>{
      'image': instance.image,
      'color': instance.color,
      'material': instance.material,
    };

ProductResponseDTO$VariantImages$Item
    _$ProductResponseDTO$VariantImages$ItemFromJson(
            Map<String, dynamic> json) =>
        ProductResponseDTO$VariantImages$Item(
          image: json['image'] as String?,
          color: json['color'] as String?,
          material: json['material'] as String?,
        );

Map<String, dynamic> _$ProductResponseDTO$VariantImages$ItemToJson(
        ProductResponseDTO$VariantImages$Item instance) =>
    <String, dynamic>{
      'image': instance.image,
      'color': instance.color,
      'material': instance.material,
    };
