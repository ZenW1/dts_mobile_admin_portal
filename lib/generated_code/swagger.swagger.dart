// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:collection/collection.dart';
import 'dart:convert';

import 'package:chopper/chopper.dart';

import 'client_mapping.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show MultipartFile;
import 'package:chopper/chopper.dart' as chopper;
import 'swagger.enums.swagger.dart' as enums;
export 'swagger.enums.swagger.dart';

part 'swagger.swagger.chopper.dart';
part 'swagger.swagger.g.dart';

// **************************************************************************
// SwaggerChopperGenerator
// **************************************************************************

@ChopperApi()
abstract class Swagger extends ChopperService {
  static Swagger create({
    ChopperClient? client,
    http.Client? httpClient,
    Authenticator? authenticator,
    ErrorConverter? errorConverter,
    Converter? converter,
    Uri? baseUrl,
    List<Interceptor>? interceptors,
  }) {
    if (client != null) {
      return _$Swagger(client);
    }

    final newClient = ChopperClient(
      services: [_$Swagger()],
      converter: converter ?? $JsonSerializableConverter(),
      interceptors: interceptors ?? [],
      client: httpClient,
      authenticator: authenticator,
      errorConverter: errorConverter,
      baseUrl: baseUrl ?? Uri.parse('http://'),
    );
    return _$Swagger(newClient);
  }

  ///User login
  Future<chopper.Response<LoginUserDTO>> Login({required LoginUserDTO? body}) {
    generatedMapping.putIfAbsent(
      LoginUserDTO,
      () => LoginUserDTO.fromJsonFactory,
    );

    return _Login(body: body);
  }

  ///User login
  @POST(path: '/auth/login', optionalBody: true)
  Future<chopper.Response<LoginUserDTO>> _Login({
    @Body() required LoginUserDTO? body,
  });

  ///Check auth status
  Future<chopper.Response<String>> GetAuthStatus() {
    return _GetAuthStatus();
  }

  ///Check auth status
  @GET(path: '/auth/status')
  Future<chopper.Response<String>> _GetAuthStatus();

  ///Create a new user
  Future<chopper.Response<UserResponseDTO>> CreateUser({
    required CreateUserDTO? body,
  }) {
    generatedMapping.putIfAbsent(
      UserResponseDTO,
      () => UserResponseDTO.fromJsonFactory,
    );

    return _CreateUser(body: body);
  }

  ///Create a new user
  @POST(path: '/users/create', optionalBody: true)
  Future<chopper.Response<UserResponseDTO>> _CreateUser({
    @Body() required CreateUserDTO? body,
  });

  ///Get all users
  Future<chopper.Response<List<UserResponseDTO>>> GetAllUsers() {
    generatedMapping.putIfAbsent(
      UserResponseDTO,
      () => UserResponseDTO.fromJsonFactory,
    );

    return _GetAllUsers();
  }

  ///Get all users
  @GET(path: '/users/get-user')
  Future<chopper.Response<List<UserResponseDTO>>> _GetAllUsers();

  ///Get a user by ID
  ///@param userId
  Future<chopper.Response<UserResponseDTO>> GetUserById({
    required String? userId,
  }) {
    generatedMapping.putIfAbsent(
      UserResponseDTO,
      () => UserResponseDTO.fromJsonFactory,
    );

    return _GetUserById(userId: userId);
  }

  ///Get a user by ID
  ///@param userId
  @GET(path: '/users/get-user/{userId}')
  Future<chopper.Response<UserResponseDTO>> _GetUserById({
    @Path('userId') required String? userId,
  });

  ///Update a user
  ///@param userId
  Future<chopper.Response<UserResponseDTO>> UpdateUser({
    required String? userId,
    required CreateUserDTO? body,
  }) {
    generatedMapping.putIfAbsent(
      UserResponseDTO,
      () => UserResponseDTO.fromJsonFactory,
    );

    return _UpdateUser(userId: userId, body: body);
  }

  ///Update a user
  ///@param userId
  @POST(path: '/users/update-user/{userId}', optionalBody: true)
  Future<chopper.Response<UserResponseDTO>> _UpdateUser({
    @Path('userId') required String? userId,
    @Body() required CreateUserDTO? body,
  });

  ///Delete a user
  ///@param userId
  Future<chopper.Response<UserResponseDTO>> DeleteUser({
    required String? userId,
  }) {
    generatedMapping.putIfAbsent(
      UserResponseDTO,
      () => UserResponseDTO.fromJsonFactory,
    );

    return _DeleteUser(userId: userId);
  }

  ///Delete a user
  ///@param userId
  @DELETE(path: '/users/delete-user/{userId}')
  Future<chopper.Response<UserResponseDTO>> _DeleteUser({
    @Path('userId') required String? userId,
  });

  ///Create a new product
  Future<chopper.Response<SingleProductResponseDTO>> CreateProduct({
    required CreateProductDTO? body,
  }) {
    generatedMapping.putIfAbsent(
      SingleProductResponseDTO,
      () => SingleProductResponseDTO.fromJsonFactory,
    );

    return _CreateProduct(body: body);
  }

  ///Create a new product
  @POST(path: '/products/create', optionalBody: true)
  Future<chopper.Response<SingleProductResponseDTO>> _CreateProduct({
    @Body() required CreateProductDTO? body,
  });

  ///Get all products
  ///@param categoryId Filter products by category ID
  Future<chopper.Response<GetAllProductsResponseDTO>> GetAllProducts({
    String? categoryId,
  }) {
    generatedMapping.putIfAbsent(
      GetAllProductsResponseDTO,
      () => GetAllProductsResponseDTO.fromJsonFactory,
    );

    return _GetAllProducts(categoryId: categoryId);
  }

  ///Get all products
  ///@param categoryId Filter products by category ID
  @GET(path: '/products/get-all-products')
  Future<chopper.Response<GetAllProductsResponseDTO>> _GetAllProducts({
    @Query('categoryId') String? categoryId,
  });

  ///Get a product by ID
  ///@param productId
  Future<chopper.Response<SingleProductResponseDTO>> GetProductById({
    required String? productId,
  }) {
    generatedMapping.putIfAbsent(
      SingleProductResponseDTO,
      () => SingleProductResponseDTO.fromJsonFactory,
    );

    return _GetProductById(productId: productId);
  }

  ///Get a product by ID
  ///@param productId
  @GET(path: '/products/{productId}')
  Future<chopper.Response<SingleProductResponseDTO>> _GetProductById({
    @Path('productId') required String? productId,
  });

  ///Update a product
  ///@param productId
  Future<chopper.Response<SingleProductResponseDTO>> UpdateProduct({
    required String? productId,
    required CreateProductDTO? body,
  }) {
    generatedMapping.putIfAbsent(
      SingleProductResponseDTO,
      () => SingleProductResponseDTO.fromJsonFactory,
    );

    return _UpdateProduct(productId: productId, body: body);
  }

  ///Update a product
  ///@param productId
  @POST(path: '/products/update/{productId}', optionalBody: true)
  Future<chopper.Response<SingleProductResponseDTO>> _UpdateProduct({
    @Path('productId') required String? productId,
    @Body() required CreateProductDTO? body,
  });

  ///Delete a product
  ///@param productId
  Future<chopper.Response<MessageResponseDTO>> DeleteProduct({
    required String? productId,
  }) {
    generatedMapping.putIfAbsent(
      MessageResponseDTO,
      () => MessageResponseDTO.fromJsonFactory,
    );

    return _DeleteProduct(productId: productId);
  }

  ///Delete a product
  ///@param productId
  @POST(path: '/products/delete/{productId}', optionalBody: true)
  Future<chopper.Response<MessageResponseDTO>> _DeleteProduct({
    @Path('productId') required String? productId,
  });

  ///Create a new product category
  Future<chopper.Response<ProductCategoryResponseDTO>> CreateProductCategory({
    required CreateProductCategoryDTO? body,
  }) {
    generatedMapping.putIfAbsent(
      ProductCategoryResponseDTO,
      () => ProductCategoryResponseDTO.fromJsonFactory,
    );

    return _CreateProductCategory(body: body);
  }

  ///Create a new product category
  @POST(path: '/product-categories/create', optionalBody: true)
  Future<chopper.Response<ProductCategoryResponseDTO>> _CreateProductCategory({
    @Body() required CreateProductCategoryDTO? body,
  });

  ///Get all product categories
  Future<chopper.Response<GetAllProductCategoriesResponseDTO>>
      GetAllProductCategories() {
    generatedMapping.putIfAbsent(
      GetAllProductCategoriesResponseDTO,
      () => GetAllProductCategoriesResponseDTO.fromJsonFactory,
    );

    return _GetAllProductCategories();
  }

  ///Get all product categories
  @GET(path: '/product-categories/get-all')
  Future<chopper.Response<GetAllProductCategoriesResponseDTO>>
      _GetAllProductCategories();

  ///Get a product category by ID
  ///@param categoryId
  Future<chopper.Response<ProductCategoryResponseDTO>> GetProductCategoryById({
    required String? categoryId,
  }) {
    generatedMapping.putIfAbsent(
      ProductCategoryResponseDTO,
      () => ProductCategoryResponseDTO.fromJsonFactory,
    );

    return _GetProductCategoryById(categoryId: categoryId);
  }

  ///Get a product category by ID
  ///@param categoryId
  @GET(path: '/product-categories/{categoryId}')
  Future<chopper.Response<ProductCategoryResponseDTO>> _GetProductCategoryById({
    @Path('categoryId') required String? categoryId,
  });

  ///Update a product category
  ///@param categoryId
  Future<chopper.Response<ProductCategoryResponseDTO>> UpdateProductCategory({
    required String? categoryId,
    required CreateProductCategoryDTO? body,
  }) {
    generatedMapping.putIfAbsent(
      ProductCategoryResponseDTO,
      () => ProductCategoryResponseDTO.fromJsonFactory,
    );

    return _UpdateProductCategory(categoryId: categoryId, body: body);
  }

  ///Update a product category
  ///@param categoryId
  @POST(path: '/product-categories/update/{categoryId}', optionalBody: true)
  Future<chopper.Response<ProductCategoryResponseDTO>> _UpdateProductCategory({
    @Path('categoryId') required String? categoryId,
    @Body() required CreateProductCategoryDTO? body,
  });

  ///Delete a product category
  ///@param categoryId
  Future<chopper.Response<MessageResponseDTO>> DeleteProductCategory({
    required String? categoryId,
  }) {
    generatedMapping.putIfAbsent(
      MessageResponseDTO,
      () => MessageResponseDTO.fromJsonFactory,
    );

    return _DeleteProductCategory(categoryId: categoryId);
  }

  ///Delete a product category
  ///@param categoryId
  @POST(path: '/product-categories/delete/{categoryId}', optionalBody: true)
  Future<chopper.Response<MessageResponseDTO>> _DeleteProductCategory({
    @Path('categoryId') required String? categoryId,
  });

  ///Create a new order
  Future<chopper.Response<OrderResponseDTO>> CreateOrder({
    required CreateOrderDTO? body,
  }) {
    generatedMapping.putIfAbsent(
      OrderResponseDTO,
      () => OrderResponseDTO.fromJsonFactory,
    );

    return _CreateOrder(body: body);
  }

  ///Create a new order
  @POST(path: '/orders/create', optionalBody: true)
  Future<chopper.Response<OrderResponseDTO>> _CreateOrder({
    @Body() required CreateOrderDTO? body,
  });

  ///Get all orders
  Future<chopper.Response<List<OrderResponseDTO>>> GetAllOrders() {
    generatedMapping.putIfAbsent(
      OrderResponseDTO,
      () => OrderResponseDTO.fromJsonFactory,
    );

    return _GetAllOrders();
  }

  ///Get all orders
  @GET(path: '/orders/get-all')
  Future<chopper.Response<List<OrderResponseDTO>>> _GetAllOrders();

  ///Get an order by ID
  ///@param orderId
  Future<chopper.Response<OrderResponseDTO>> GetOrderById({
    required String? orderId,
  }) {
    generatedMapping.putIfAbsent(
      OrderResponseDTO,
      () => OrderResponseDTO.fromJsonFactory,
    );

    return _GetOrderById(orderId: orderId);
  }

  ///Get an order by ID
  ///@param orderId
  @GET(path: '/orders/{orderId}')
  Future<chopper.Response<OrderResponseDTO>> _GetOrderById({
    @Path('orderId') required String? orderId,
  });

  ///Delete an order
  ///@param orderId
  Future<chopper.Response<MessageResponseDTO>> DeleteOrder({
    required String? orderId,
  }) {
    generatedMapping.putIfAbsent(
      MessageResponseDTO,
      () => MessageResponseDTO.fromJsonFactory,
    );

    return _DeleteOrder(orderId: orderId);
  }

  ///Delete an order
  ///@param orderId
  @POST(path: '/orders/delete/{orderId}', optionalBody: true)
  Future<chopper.Response<MessageResponseDTO>> _DeleteOrder({
    @Path('orderId') required String? orderId,
  });

  ///Create a new career opportunity
  Future<chopper.Response<CareerResponseDTO>> CreateCareer({
    required CreateCareerDTO? body,
  }) {
    generatedMapping.putIfAbsent(
      CareerResponseDTO,
      () => CareerResponseDTO.fromJsonFactory,
    );

    return _CreateCareer(body: body);
  }

  ///Create a new career opportunity
  @POST(path: '/careers/create', optionalBody: true)
  Future<chopper.Response<CareerResponseDTO>> _CreateCareer({
    @Body() required CreateCareerDTO? body,
  });

  ///Get all career opportunities
  Future<chopper.Response<GetAllCareersResponseDTO>> GetAllCareers() {
    generatedMapping.putIfAbsent(
      GetAllCareersResponseDTO,
      () => GetAllCareersResponseDTO.fromJsonFactory,
    );

    return _GetAllCareers();
  }

  ///Get all career opportunities
  @GET(path: '/careers/get-all')
  Future<chopper.Response<GetAllCareersResponseDTO>> _GetAllCareers();

  ///Get a career opportunity by ID
  ///@param careerId
  Future<chopper.Response<CareerResponseDTO>> GetCareerById({
    required String? careerId,
  }) {
    generatedMapping.putIfAbsent(
      CareerResponseDTO,
      () => CareerResponseDTO.fromJsonFactory,
    );

    return _GetCareerById(careerId: careerId);
  }

  ///Get a career opportunity by ID
  ///@param careerId
  @GET(path: '/careers/{careerId}')
  Future<chopper.Response<CareerResponseDTO>> _GetCareerById({
    @Path('careerId') required String? careerId,
  });

  ///Update a career opportunity
  ///@param careerId
  Future<chopper.Response<CareerResponseDTO>> UpdateCareer({
    required String? careerId,
    required CreateCareerDTO? body,
  }) {
    generatedMapping.putIfAbsent(
      CareerResponseDTO,
      () => CareerResponseDTO.fromJsonFactory,
    );

    return _UpdateCareer(careerId: careerId, body: body);
  }

  ///Update a career opportunity
  ///@param careerId
  @POST(path: '/careers/update/{careerId}', optionalBody: true)
  Future<chopper.Response<CareerResponseDTO>> _UpdateCareer({
    @Path('careerId') required String? careerId,
    @Body() required CreateCareerDTO? body,
  });

  ///Delete a career opportunity
  ///@param careerId
  Future<chopper.Response<MessageResponseDTO>> DeleteCareer({
    required String? careerId,
  }) {
    generatedMapping.putIfAbsent(
      MessageResponseDTO,
      () => MessageResponseDTO.fromJsonFactory,
    );

    return _DeleteCareer(careerId: careerId);
  }

  ///Delete a career opportunity
  ///@param careerId
  @POST(path: '/careers/delete/{careerId}', optionalBody: true)
  Future<chopper.Response<MessageResponseDTO>> _DeleteCareer({
    @Path('careerId') required String? careerId,
  });

  ///Create a new product color
  Future<chopper.Response<ProductColorResponseDTO>> CreateProductColor({
    required CreateProductColorDTO? body,
  }) {
    generatedMapping.putIfAbsent(
      ProductColorResponseDTO,
      () => ProductColorResponseDTO.fromJsonFactory,
    );

    return _CreateProductColor(body: body);
  }

  ///Create a new product color
  @POST(path: '/product-colors/create', optionalBody: true)
  Future<chopper.Response<ProductColorResponseDTO>> _CreateProductColor({
    @Body() required CreateProductColorDTO? body,
  });

  ///Get all product colors
  Future<chopper.Response<GetAllProductColorsResponseDTO>>
      GetAllProductColors() {
    generatedMapping.putIfAbsent(
      GetAllProductColorsResponseDTO,
      () => GetAllProductColorsResponseDTO.fromJsonFactory,
    );

    return _GetAllProductColors();
  }

  ///Get all product colors
  @GET(path: '/product-colors/get-all')
  Future<chopper.Response<GetAllProductColorsResponseDTO>>
      _GetAllProductColors();

  ///Get a product color by ID
  ///@param colorId
  Future<chopper.Response<ProductColorResponseDTO>> GetProductColorById({
    required String? colorId,
  }) {
    generatedMapping.putIfAbsent(
      ProductColorResponseDTO,
      () => ProductColorResponseDTO.fromJsonFactory,
    );

    return _GetProductColorById(colorId: colorId);
  }

  ///Get a product color by ID
  ///@param colorId
  @GET(path: '/product-colors/{colorId}')
  Future<chopper.Response<ProductColorResponseDTO>> _GetProductColorById({
    @Path('colorId') required String? colorId,
  });

  ///Update a product color
  ///@param colorId
  Future<chopper.Response<ProductColorResponseDTO>> UpdateProductColor({
    required String? colorId,
    required CreateProductColorDTO? body,
  }) {
    generatedMapping.putIfAbsent(
      ProductColorResponseDTO,
      () => ProductColorResponseDTO.fromJsonFactory,
    );

    return _UpdateProductColor(colorId: colorId, body: body);
  }

  ///Update a product color
  ///@param colorId
  @POST(path: '/product-colors/update/{colorId}', optionalBody: true)
  Future<chopper.Response<ProductColorResponseDTO>> _UpdateProductColor({
    @Path('colorId') required String? colorId,
    @Body() required CreateProductColorDTO? body,
  });

  ///Delete a product color
  ///@param colorId
  Future<chopper.Response<MessageResponseDTO>> DeleteProductColor({
    required String? colorId,
  }) {
    generatedMapping.putIfAbsent(
      MessageResponseDTO,
      () => MessageResponseDTO.fromJsonFactory,
    );

    return _DeleteProductColor(colorId: colorId);
  }

  ///Delete a product color
  ///@param colorId
  @POST(path: '/product-colors/delete/{colorId}', optionalBody: true)
  Future<chopper.Response<MessageResponseDTO>> _DeleteProductColor({
    @Path('colorId') required String? colorId,
  });

  ///Create a new product type
  Future<chopper.Response<ProductTypeResponseDTO>> CreateProductType({
    required CreateProductTypeDTO? body,
  }) {
    generatedMapping.putIfAbsent(
      ProductTypeResponseDTO,
      () => ProductTypeResponseDTO.fromJsonFactory,
    );

    return _CreateProductType(body: body);
  }

  ///Create a new product type
  @POST(path: '/product-types/create', optionalBody: true)
  Future<chopper.Response<ProductTypeResponseDTO>> _CreateProductType({
    @Body() required CreateProductTypeDTO? body,
  });

  ///Get all product types
  Future<chopper.Response<GetAllProductTypesResponseDTO>> GetAllProductTypes() {
    generatedMapping.putIfAbsent(
      GetAllProductTypesResponseDTO,
      () => GetAllProductTypesResponseDTO.fromJsonFactory,
    );

    return _GetAllProductTypes();
  }

  ///Get all product types
  @GET(path: '/product-types/get-all')
  Future<chopper.Response<GetAllProductTypesResponseDTO>> _GetAllProductTypes();

  ///Get a product type by ID
  ///@param typeId
  Future<chopper.Response<ProductTypeResponseDTO>> GetProductTypeById({
    required String? typeId,
  }) {
    generatedMapping.putIfAbsent(
      ProductTypeResponseDTO,
      () => ProductTypeResponseDTO.fromJsonFactory,
    );

    return _GetProductTypeById(typeId: typeId);
  }

  ///Get a product type by ID
  ///@param typeId
  @GET(path: '/product-types/{typeId}')
  Future<chopper.Response<ProductTypeResponseDTO>> _GetProductTypeById({
    @Path('typeId') required String? typeId,
  });

  ///Update a product type
  ///@param typeId
  Future<chopper.Response<ProductTypeResponseDTO>> UpdateProductType({
    required String? typeId,
    required CreateProductTypeDTO? body,
  }) {
    generatedMapping.putIfAbsent(
      ProductTypeResponseDTO,
      () => ProductTypeResponseDTO.fromJsonFactory,
    );

    return _UpdateProductType(typeId: typeId, body: body);
  }

  ///Update a product type
  ///@param typeId
  @POST(path: '/product-types/update/{typeId}', optionalBody: true)
  Future<chopper.Response<ProductTypeResponseDTO>> _UpdateProductType({
    @Path('typeId') required String? typeId,
    @Body() required CreateProductTypeDTO? body,
  });

  ///Delete a product type
  ///@param typeId
  Future<chopper.Response<MessageResponseDTO>> DeleteProductType({
    required String? typeId,
  }) {
    generatedMapping.putIfAbsent(
      MessageResponseDTO,
      () => MessageResponseDTO.fromJsonFactory,
    );

    return _DeleteProductType(typeId: typeId);
  }

  ///Delete a product type
  ///@param typeId
  @POST(path: '/product-types/delete/{typeId}', optionalBody: true)
  Future<chopper.Response<MessageResponseDTO>> _DeleteProductType({
    @Path('typeId') required String? typeId,
  });

  ///Create a new product material
  Future<chopper.Response<ProductMaterialResponseDTO>> CreateProductMaterial({
    required CreateProductMaterialDTO? body,
  }) {
    generatedMapping.putIfAbsent(
      ProductMaterialResponseDTO,
      () => ProductMaterialResponseDTO.fromJsonFactory,
    );

    return _CreateProductMaterial(body: body);
  }

  ///Create a new product material
  @POST(path: '/product-materials/create', optionalBody: true)
  Future<chopper.Response<ProductMaterialResponseDTO>> _CreateProductMaterial({
    @Body() required CreateProductMaterialDTO? body,
  });

  ///Get all product materials
  Future<chopper.Response<GetAllProductMaterialsResponseDTO>>
      GetAllProductMaterials() {
    generatedMapping.putIfAbsent(
      GetAllProductMaterialsResponseDTO,
      () => GetAllProductMaterialsResponseDTO.fromJsonFactory,
    );

    return _GetAllProductMaterials();
  }

  ///Get all product materials
  @GET(path: '/product-materials/get-all')
  Future<chopper.Response<GetAllProductMaterialsResponseDTO>>
      _GetAllProductMaterials();

  ///Get a product material by ID
  ///@param materialId
  Future<chopper.Response<ProductMaterialResponseDTO>> GetProductMaterialById({
    required String? materialId,
  }) {
    generatedMapping.putIfAbsent(
      ProductMaterialResponseDTO,
      () => ProductMaterialResponseDTO.fromJsonFactory,
    );

    return _GetProductMaterialById(materialId: materialId);
  }

  ///Get a product material by ID
  ///@param materialId
  @GET(path: '/product-materials/{materialId}')
  Future<chopper.Response<ProductMaterialResponseDTO>> _GetProductMaterialById({
    @Path('materialId') required String? materialId,
  });

  ///Update a product material
  ///@param materialId
  Future<chopper.Response<ProductMaterialResponseDTO>> UpdateProductMaterial({
    required String? materialId,
    required CreateProductMaterialDTO? body,
  }) {
    generatedMapping.putIfAbsent(
      ProductMaterialResponseDTO,
      () => ProductMaterialResponseDTO.fromJsonFactory,
    );

    return _UpdateProductMaterial(materialId: materialId, body: body);
  }

  ///Update a product material
  ///@param materialId
  @POST(path: '/product-materials/update/{materialId}', optionalBody: true)
  Future<chopper.Response<ProductMaterialResponseDTO>> _UpdateProductMaterial({
    @Path('materialId') required String? materialId,
    @Body() required CreateProductMaterialDTO? body,
  });

  ///Delete a product material
  ///@param materialId
  Future<chopper.Response<MessageResponseDTO>> DeleteProductMaterial({
    required String? materialId,
  }) {
    generatedMapping.putIfAbsent(
      MessageResponseDTO,
      () => MessageResponseDTO.fromJsonFactory,
    );

    return _DeleteProductMaterial(materialId: materialId);
  }

  ///Delete a product material
  ///@param materialId
  @POST(path: '/product-materials/delete/{materialId}', optionalBody: true)
  Future<chopper.Response<MessageResponseDTO>> _DeleteProductMaterial({
    @Path('materialId') required String? materialId,
  });

  ///Create a new portfolio item
  Future<chopper.Response<CreatePortfolioResponseDTO>> CreatePortfolio({
    required CreatePortfolioDTO? body,
  }) {
    generatedMapping.putIfAbsent(
      CreatePortfolioResponseDTO,
      () => CreatePortfolioResponseDTO.fromJsonFactory,
    );

    return _CreatePortfolio(body: body);
  }

  ///Create a new portfolio item
  @POST(path: '/portfolio/create', optionalBody: true)
  Future<chopper.Response<CreatePortfolioResponseDTO>> _CreatePortfolio({
    @Body() required CreatePortfolioDTO? body,
  });

  ///Get all portfolio items
  Future<chopper.Response<GetAllPortfoliosResponseDTO>> GetAllPortfolios() {
    generatedMapping.putIfAbsent(
      GetAllPortfoliosResponseDTO,
      () => GetAllPortfoliosResponseDTO.fromJsonFactory,
    );

    return _GetAllPortfolios();
  }

  ///Get all portfolio items
  @GET(path: '/portfolio/get-all')
  Future<chopper.Response<GetAllPortfoliosResponseDTO>> _GetAllPortfolios();

  ///Get a portfolio item by ID
  ///@param portfolioId
  Future<chopper.Response<GetPortfolioDetailResponseDTO>> GetPortfolioById({
    required String? portfolioId,
  }) {
    generatedMapping.putIfAbsent(
      GetPortfolioDetailResponseDTO,
      () => GetPortfolioDetailResponseDTO.fromJsonFactory,
    );

    return _GetPortfolioById(portfolioId: portfolioId);
  }

  ///Get a portfolio item by ID
  ///@param portfolioId
  @GET(path: '/portfolio/{portfolioId}')
  Future<chopper.Response<GetPortfolioDetailResponseDTO>> _GetPortfolioById({
    @Path('portfolioId') required String? portfolioId,
  });

  ///Update a portfolio item
  ///@param portfolioId
  Future<chopper.Response<UpdatePortfolioResponseDTO>> UpdatePortfolio({
    required String? portfolioId,
    required CreatePortfolioDTO? body,
  }) {
    generatedMapping.putIfAbsent(
      UpdatePortfolioResponseDTO,
      () => UpdatePortfolioResponseDTO.fromJsonFactory,
    );

    return _UpdatePortfolio(portfolioId: portfolioId, body: body);
  }

  ///Update a portfolio item
  ///@param portfolioId
  @POST(path: '/portfolio/update/{portfolioId}', optionalBody: true)
  Future<chopper.Response<UpdatePortfolioResponseDTO>> _UpdatePortfolio({
    @Path('portfolioId') required String? portfolioId,
    @Body() required CreatePortfolioDTO? body,
  });

  ///Delete a portfolio item
  ///@param portfolioId
  Future<chopper.Response<MessageResponseDTO>> DeletePortfolio({
    required String? portfolioId,
  }) {
    generatedMapping.putIfAbsent(
      MessageResponseDTO,
      () => MessageResponseDTO.fromJsonFactory,
    );

    return _DeletePortfolio(portfolioId: portfolioId);
  }

  ///Delete a portfolio item
  ///@param portfolioId
  @POST(path: '/portfolio/delete/{portfolioId}', optionalBody: true)
  Future<chopper.Response<MessageResponseDTO>> _DeletePortfolio({
    @Path('portfolioId') required String? portfolioId,
  });

  ///Create a new portfolio category
  Future<chopper.Response<PortfolioCategoryResponseDTO>>
      CreatePortfolioCategory({required CreatePortfolioCategoryDTO? body}) {
    generatedMapping.putIfAbsent(
      PortfolioCategoryResponseDTO,
      () => PortfolioCategoryResponseDTO.fromJsonFactory,
    );

    return _CreatePortfolioCategory(body: body);
  }

  ///Create a new portfolio category
  @POST(path: '/portfolio-categories/create', optionalBody: true)
  Future<chopper.Response<PortfolioCategoryResponseDTO>>
      _CreatePortfolioCategory(
          {@Body() required CreatePortfolioCategoryDTO? body});

  ///Get all portfolio categories
  Future<chopper.Response<GetAllPortfolioCategoriesResponseDTO>>
      GetAllPortfolioCategories() {
    generatedMapping.putIfAbsent(
      GetAllPortfolioCategoriesResponseDTO,
      () => GetAllPortfolioCategoriesResponseDTO.fromJsonFactory,
    );

    return _GetAllPortfolioCategories();
  }

  ///Get all portfolio categories
  @GET(path: '/portfolio-categories/get-all')
  Future<chopper.Response<GetAllPortfolioCategoriesResponseDTO>>
      _GetAllPortfolioCategories();

  ///Get a portfolio category by ID
  ///@param id
  Future<chopper.Response<PortfolioCategoryResponseDTO>>
      GetPortfolioCategoryById({required String? id}) {
    generatedMapping.putIfAbsent(
      PortfolioCategoryResponseDTO,
      () => PortfolioCategoryResponseDTO.fromJsonFactory,
    );

    return _GetPortfolioCategoryById(id: id);
  }

  ///Get a portfolio category by ID
  ///@param id
  @GET(path: '/portfolio-categories/{id}')
  Future<chopper.Response<PortfolioCategoryResponseDTO>>
      _GetPortfolioCategoryById({@Path('id') required String? id});

  ///Update a portfolio category
  ///@param id
  Future<chopper.Response<PortfolioCategoryResponseDTO>>
      UpdatePortfolioCategory({
    required String? id,
    required CreatePortfolioCategoryDTO? body,
  }) {
    generatedMapping.putIfAbsent(
      PortfolioCategoryResponseDTO,
      () => PortfolioCategoryResponseDTO.fromJsonFactory,
    );

    return _UpdatePortfolioCategory(id: id, body: body);
  }

  ///Update a portfolio category
  ///@param id
  @POST(path: '/portfolio-categories/update/{id}', optionalBody: true)
  Future<chopper.Response<PortfolioCategoryResponseDTO>>
      _UpdatePortfolioCategory({
    @Path('id') required String? id,
    @Body() required CreatePortfolioCategoryDTO? body,
  });

  ///Delete a portfolio category
  ///@param id
  Future<chopper.Response<MessageResponseDTO>> DeletePortfolioCategory({
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
      MessageResponseDTO,
      () => MessageResponseDTO.fromJsonFactory,
    );

    return _DeletePortfolioCategory(id: id);
  }

  ///Delete a portfolio category
  ///@param id
  @POST(path: '/portfolio-categories/delete/{id}', optionalBody: true)
  Future<chopper.Response<MessageResponseDTO>> _DeletePortfolioCategory({
    @Path('id') required String? id,
  });

  ///Submit customer feedback
  Future<chopper.Response<CustomerFeedbackResponseDTO>> CreateCustomerFeedback({
    required CreateCustomerFeedbackDTO? body,
  }) {
    generatedMapping.putIfAbsent(
      CustomerFeedbackResponseDTO,
      () => CustomerFeedbackResponseDTO.fromJsonFactory,
    );

    return _CreateCustomerFeedback(body: body);
  }

  ///Submit customer feedback
  @POST(path: '/customer-feedback/create', optionalBody: true)
  Future<chopper.Response<CustomerFeedbackResponseDTO>> _CreateCustomerFeedback(
      {@Body() required CreateCustomerFeedbackDTO? body});

  ///Get all customer feedback
  Future<chopper.Response<GetAllCustomerFeedbackResponseDTO>>
      GetAllCustomerFeedback() {
    generatedMapping.putIfAbsent(
      GetAllCustomerFeedbackResponseDTO,
      () => GetAllCustomerFeedbackResponseDTO.fromJsonFactory,
    );

    return _GetAllCustomerFeedback();
  }

  ///Get all customer feedback
  @GET(path: '/customer-feedback/get-all')
  Future<chopper.Response<GetAllCustomerFeedbackResponseDTO>>
      _GetAllCustomerFeedback();

  ///Get all active customer feedback
  Future<chopper.Response<GetAllCustomerFeedbackResponseDTO>>
      GetActiveCustomerFeedback() {
    generatedMapping.putIfAbsent(
      GetAllCustomerFeedbackResponseDTO,
      () => GetAllCustomerFeedbackResponseDTO.fromJsonFactory,
    );

    return _GetActiveCustomerFeedback();
  }

  ///Get all active customer feedback
  @GET(path: '/customer-feedback/active')
  Future<chopper.Response<GetAllCustomerFeedbackResponseDTO>>
      _GetActiveCustomerFeedback();

  ///Get feedback statistics
  Future<chopper.Response> GetFeedbackStats() {
    return _GetFeedbackStats();
  }

  ///Get feedback statistics
  @GET(path: '/customer-feedback/stats')
  Future<chopper.Response> _GetFeedbackStats();

  ///Get feedback by status
  ///@param status
  Future<chopper.Response<GetAllCustomerFeedbackResponseDTO>>
      GetFeedbackByStatus({
    required enums.CustomerFeedbackByStatusGetStatus? status,
  }) {
    generatedMapping.putIfAbsent(
      GetAllCustomerFeedbackResponseDTO,
      () => GetAllCustomerFeedbackResponseDTO.fromJsonFactory,
    );

    return _GetFeedbackByStatus(status: status?.value?.toString());
  }

  ///Get feedback by status
  ///@param status
  @GET(path: '/customer-feedback/by-status')
  Future<chopper.Response<GetAllCustomerFeedbackResponseDTO>>
      _GetFeedbackByStatus({@Query('status') required String? status});

  ///Get feedback by ID
  ///@param feedbackId
  Future<chopper.Response<CustomerFeedbackResponseDTO>> GetCustomerFeedbackById(
      {required String? feedbackId}) {
    generatedMapping.putIfAbsent(
      CustomerFeedbackResponseDTO,
      () => CustomerFeedbackResponseDTO.fromJsonFactory,
    );

    return _GetCustomerFeedbackById(feedbackId: feedbackId);
  }

  ///Get feedback by ID
  ///@param feedbackId
  @GET(path: '/customer-feedback/{feedbackId}')
  Future<chopper.Response<CustomerFeedbackResponseDTO>>
      _GetCustomerFeedbackById(
          {@Path('feedbackId') required String? feedbackId});

  ///Update customer feedback
  ///@param feedbackId
  Future<chopper.Response<CustomerFeedbackResponseDTO>> UpdateCustomerFeedback({
    required String? feedbackId,
    required CreateCustomerFeedbackDTO? body,
  }) {
    generatedMapping.putIfAbsent(
      CustomerFeedbackResponseDTO,
      () => CustomerFeedbackResponseDTO.fromJsonFactory,
    );

    return _UpdateCustomerFeedback(feedbackId: feedbackId, body: body);
  }

  ///Update customer feedback
  ///@param feedbackId
  @POST(path: '/customer-feedback/update/{feedbackId}', optionalBody: true)
  Future<chopper.Response<CustomerFeedbackResponseDTO>>
      _UpdateCustomerFeedback({
    @Path('feedbackId') required String? feedbackId,
    @Body() required CreateCustomerFeedbackDTO? body,
  });

  ///Update feedback status
  ///@param feedbackId
  Future<chopper.Response<CustomerFeedbackResponseDTO>>
      UpdateCustomerFeedbackStatus({
    required String? feedbackId,
    required UpdateFeedbackStatusDTO? body,
  }) {
    generatedMapping.putIfAbsent(
      CustomerFeedbackResponseDTO,
      () => CustomerFeedbackResponseDTO.fromJsonFactory,
    );

    return _UpdateCustomerFeedbackStatus(feedbackId: feedbackId, body: body);
  }

  ///Update feedback status
  ///@param feedbackId
  @POST(
    path: '/customer-feedback/update-status/{feedbackId}',
    optionalBody: true,
  )
  Future<chopper.Response<CustomerFeedbackResponseDTO>>
      _UpdateCustomerFeedbackStatus({
    @Path('feedbackId') required String? feedbackId,
    @Body() required UpdateFeedbackStatusDTO? body,
  });

  ///Delete customer feedback
  ///@param feedbackId
  Future<chopper.Response<MessageResponseDTO>> DeleteCustomerFeedback({
    required String? feedbackId,
  }) {
    generatedMapping.putIfAbsent(
      MessageResponseDTO,
      () => MessageResponseDTO.fromJsonFactory,
    );

    return _DeleteCustomerFeedback(feedbackId: feedbackId);
  }

  ///Delete customer feedback
  ///@param feedbackId
  @POST(path: '/customer-feedback/delete/{feedbackId}', optionalBody: true)
  Future<chopper.Response<MessageResponseDTO>> _DeleteCustomerFeedback({
    @Path('feedbackId') required String? feedbackId,
  });

  ///Log telegram contact intent and get redirect config
  ///@param Content-Type application/json
  Future<chopper.Response<TelegramIntentResponseDTO>> CreateTelegramIntent({
    String? contentType,
    required TelegramIntentDTO? body,
  }) {
    generatedMapping.putIfAbsent(
      TelegramIntentResponseDTO,
      () => TelegramIntentResponseDTO.fromJsonFactory,
    );

    return _CreateTelegramIntent(
      contentType: contentType?.toString(),
      body: body,
    );
  }

  ///Log telegram contact intent and get redirect config
  ///@param Content-Type application/json
  @POST(path: '/api/leads/telegram-intent', optionalBody: true)
  Future<chopper.Response<TelegramIntentResponseDTO>> _CreateTelegramIntent({
    @Header('Content-Type') String? contentType,
    @Body() required TelegramIntentDTO? body,
  });

  ///Submit contact us form
  ///@param Content-Type application/json
  Future<chopper.Response<MessageResponseDTO>> SubmitContactUs({
    String? contentType,
    required ContactUsDTO? body,
  }) {
    generatedMapping.putIfAbsent(
      MessageResponseDTO,
      () => MessageResponseDTO.fromJsonFactory,
    );

    return _SubmitContactUs(contentType: contentType?.toString(), body: body);
  }

  ///Submit contact us form
  ///@param Content-Type application/json
  @POST(path: '/api/leads/contact-us', optionalBody: true)
  Future<chopper.Response<MessageResponseDTO>> _SubmitContactUs({
    @Header('Content-Type') String? contentType,
    @Body() required ContactUsDTO? body,
  });

  ///Get all telegram leads
  Future<chopper.Response<GetAllLeadsResponseDTO>> GetAllLeads() {
    generatedMapping.putIfAbsent(
      GetAllLeadsResponseDTO,
      () => GetAllLeadsResponseDTO.fromJsonFactory,
    );

    return _GetAllLeads();
  }

  ///Get all telegram leads
  @GET(path: '/api/leads/get-all')
  Future<chopper.Response<GetAllLeadsResponseDTO>> _GetAllLeads();

  ///Get leads statistics
  Future<chopper.Response> GetLeadsStats() {
    return _GetLeadsStats();
  }

  ///Get leads statistics
  @GET(path: '/api/leads/stats')
  Future<chopper.Response> _GetLeadsStats();

  ///Get lead by ID
  ///@param leadId
  Future<chopper.Response<LeadResponseDTO>> GetLeadById({
    required String? leadId,
  }) {
    generatedMapping.putIfAbsent(
      LeadResponseDTO,
      () => LeadResponseDTO.fromJsonFactory,
    );

    return _GetLeadById(leadId: leadId);
  }

  ///Get lead by ID
  ///@param leadId
  @GET(path: '/api/leads/{leadId}')
  Future<chopper.Response<LeadResponseDTO>> _GetLeadById({
    @Path('leadId') required String? leadId,
  });

  ///Update lead status
  ///@param leadId
  Future<chopper.Response<MessageResponseDTO>> UpdateLeadStatus({
    required String? leadId,
  }) {
    generatedMapping.putIfAbsent(
      MessageResponseDTO,
      () => MessageResponseDTO.fromJsonFactory,
    );

    return _UpdateLeadStatus(leadId: leadId);
  }

  ///Update lead status
  ///@param leadId
  @POST(path: '/api/leads/update-status/{leadId}', optionalBody: true)
  Future<chopper.Response<MessageResponseDTO>> _UpdateLeadStatus({
    @Path('leadId') required String? leadId,
  });

  ///Upload an image
  Future<chopper.Response> uploadImage({required List<int> file}) {
    return _uploadImage(file: file);
  }

  ///Upload an image
  @POST(path: '/images/upload', optionalBody: true)
  @Multipart()
  Future<chopper.Response> _uploadImage({@PartFile() required List<int> file});

  ///
  Future<chopper.Response> createClient({required CreateClientDTO? body}) {
    return _createClient(body: body);
  }

  ///
  @POST(path: '/api/clients', optionalBody: true)
  Future<chopper.Response> _createClient({
    @Body() required CreateClientDTO? body,
  });

  ///
  ///@param q Search query for name and company
  ///@param status Filter by status
  ///@param sortBy Sort field
  ///@param sortOrder Sort order
  ///@param page Page number for pagination
  ///@param limit Items per page
  Future<chopper.Response> getAllClients({
    String? q,
    enums.ApiClientsGetStatus? status,
    String? sortBy,
    enums.ApiClientsGetSortOrder? sortOrder,
    num? page,
    num? limit,
  }) {
    return _getAllClients(
      q: q,
      status: status?.value?.toString(),
      sortBy: sortBy,
      sortOrder: sortOrder?.value?.toString(),
      page: page,
      limit: limit,
    );
  }

  ///
  ///@param q Search query for name and company
  ///@param status Filter by status
  ///@param sortBy Sort field
  ///@param sortOrder Sort order
  ///@param page Page number for pagination
  ///@param limit Items per page
  @GET(path: '/api/clients')
  Future<chopper.Response> _getAllClients({
    @Query('q') String? q,
    @Query('status') String? status,
    @Query('sortBy') String? sortBy,
    @Query('sortOrder') String? sortOrder,
    @Query('page') num? page,
    @Query('limit') num? limit,
  });

  ///
  ///@param q Search query for name and company
  ///@param status Filter by status
  ///@param sortBy Sort field
  ///@param sortOrder Sort order
  ///@param page Page number for pagination
  ///@param limit Items per page
  Future<chopper.Response> searchClients({
    String? q,
    enums.ApiClientsSearchGetStatus? status,
    String? sortBy,
    enums.ApiClientsSearchGetSortOrder? sortOrder,
    num? page,
    num? limit,
  }) {
    return _searchClients(
      q: q,
      status: status?.value?.toString(),
      sortBy: sortBy,
      sortOrder: sortOrder?.value?.toString(),
      page: page,
      limit: limit,
    );
  }

  ///
  ///@param q Search query for name and company
  ///@param status Filter by status
  ///@param sortBy Sort field
  ///@param sortOrder Sort order
  ///@param page Page number for pagination
  ///@param limit Items per page
  @GET(path: '/api/clients/search')
  Future<chopper.Response> _searchClients({
    @Query('q') String? q,
    @Query('status') String? status,
    @Query('sortBy') String? sortBy,
    @Query('sortOrder') String? sortOrder,
    @Query('page') num? page,
    @Query('limit') num? limit,
  });

  ///
  ///@param id
  Future<chopper.Response> getClientById({required String? id}) {
    return _getClientById(id: id);
  }

  ///
  ///@param id
  @GET(path: '/api/clients/{id}')
  Future<chopper.Response> _getClientById({@Path('id') required String? id});

  ///
  ///@param id
  Future<chopper.Response> updateClient({
    required String? id,
    required UpdateClientDTO? body,
  }) {
    return _updateClient(id: id, body: body);
  }

  ///
  ///@param id
  @PUT(path: '/api/clients/{id}', optionalBody: true)
  Future<chopper.Response> _updateClient({
    @Path('id') required String? id,
    @Body() required UpdateClientDTO? body,
  });

  ///
  ///@param id
  Future<chopper.Response> deleteClient({required String? id}) {
    return _deleteClient(id: id);
  }

  ///
  ///@param id
  @DELETE(path: '/api/clients/{id}')
  Future<chopper.Response> _deleteClient({@Path('id') required String? id});

  ///
  ///@param id
  Future<chopper.Response> uploadClientImage({required String? id}) {
    return _uploadClientImage(id: id);
  }

  ///
  ///@param id
  @POST(path: '/api/clients/{id}/image', optionalBody: true)
  Future<chopper.Response> _uploadClientImage({
    @Path('id') required String? id,
  });

  ///
  ///@param id
  Future<chopper.Response> removeClientImage({required String? id}) {
    return _removeClientImage(id: id);
  }

  ///
  ///@param id
  @DELETE(path: '/api/clients/{id}/image')
  Future<chopper.Response> _removeClientImage({
    @Path('id') required String? id,
  });
}

@JsonSerializable(explicitToJson: true)
class LoginUserDTO {
  const LoginUserDTO({required this.email, required this.password});

  factory LoginUserDTO.fromJson(Map<String, dynamic> json) =>
      _$LoginUserDTOFromJson(json);

  static const toJsonFactory = _$LoginUserDTOToJson;
  Map<String, dynamic> toJson() => _$LoginUserDTOToJson(this);

  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'password')
  final String password;
  static const fromJsonFactory = _$LoginUserDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is LoginUserDTO &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality().equals(
                  other.password,
                  password,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(password) ^
      runtimeType.hashCode;
}

extension $LoginUserDTOExtension on LoginUserDTO {
  LoginUserDTO copyWith({String? email, String? password}) {
    return LoginUserDTO(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  LoginUserDTO copyWithWrapped({
    Wrapped<String>? email,
    Wrapped<String>? password,
  }) {
    return LoginUserDTO(
      email: (email != null ? email.value : this.email),
      password: (password != null ? password.value : this.password),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CreateUserDTO {
  const CreateUserDTO({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.phone,
    this.address,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.lastLogin,
  });

  factory CreateUserDTO.fromJson(Map<String, dynamic> json) =>
      _$CreateUserDTOFromJson(json);

  static const toJsonFactory = _$CreateUserDTOToJson;
  Map<String, dynamic> toJson() => _$CreateUserDTOToJson(this);

  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'password')
  final String password;
  @JsonKey(
    name: 'role',
    toJson: createUserDTORoleToJson,
    fromJson: createUserDTORoleFromJson,
  )
  final enums.CreateUserDTORole role;
  @JsonKey(name: 'phone')
  final double phone;
  @JsonKey(name: 'address')
  final String? address;
  @JsonKey(name: 'isActive')
  final bool? isActive;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;
  @JsonKey(name: 'lastLogin')
  final DateTime? lastLogin;
  static const fromJsonFactory = _$CreateUserDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CreateUserDTO &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality().equals(
                  other.password,
                  password,
                )) &&
            (identical(other.role, role) ||
                const DeepCollectionEquality().equals(other.role, role)) &&
            (identical(other.phone, phone) ||
                const DeepCollectionEquality().equals(other.phone, phone)) &&
            (identical(other.address, address) ||
                const DeepCollectionEquality().equals(
                  other.address,
                  address,
                )) &&
            (identical(other.isActive, isActive) ||
                const DeepCollectionEquality().equals(
                  other.isActive,
                  isActive,
                )) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(
                  other.createdAt,
                  createdAt,
                )) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality().equals(
                  other.updatedAt,
                  updatedAt,
                )) &&
            (identical(other.lastLogin, lastLogin) ||
                const DeepCollectionEquality().equals(
                  other.lastLogin,
                  lastLogin,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(password) ^
      const DeepCollectionEquality().hash(role) ^
      const DeepCollectionEquality().hash(phone) ^
      const DeepCollectionEquality().hash(address) ^
      const DeepCollectionEquality().hash(isActive) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(lastLogin) ^
      runtimeType.hashCode;
}

extension $CreateUserDTOExtension on CreateUserDTO {
  CreateUserDTO copyWith({
    String? name,
    String? email,
    String? password,
    enums.CreateUserDTORole? role,
    double? phone,
    String? address,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastLogin,
  }) {
    return CreateUserDTO(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      role: role ?? this.role,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastLogin: lastLogin ?? this.lastLogin,
    );
  }

  CreateUserDTO copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? email,
    Wrapped<String>? password,
    Wrapped<enums.CreateUserDTORole>? role,
    Wrapped<double>? phone,
    Wrapped<String?>? address,
    Wrapped<bool?>? isActive,
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
    Wrapped<DateTime?>? lastLogin,
  }) {
    return CreateUserDTO(
      name: (name != null ? name.value : this.name),
      email: (email != null ? email.value : this.email),
      password: (password != null ? password.value : this.password),
      role: (role != null ? role.value : this.role),
      phone: (phone != null ? phone.value : this.phone),
      address: (address != null ? address.value : this.address),
      isActive: (isActive != null ? isActive.value : this.isActive),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      lastLogin: (lastLogin != null ? lastLogin.value : this.lastLogin),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserResponseDTO {
  const UserResponseDTO({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.phone,
    this.address,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.lastLogin,
    required this.id,
  });

  factory UserResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$UserResponseDTOFromJson(json);

  static const toJsonFactory = _$UserResponseDTOToJson;
  Map<String, dynamic> toJson() => _$UserResponseDTOToJson(this);

  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'password')
  final String password;
  @JsonKey(
    name: 'role',
    toJson: userResponseDTORoleToJson,
    fromJson: userResponseDTORoleFromJson,
  )
  final enums.UserResponseDTORole role;
  @JsonKey(name: 'phone')
  final double phone;
  @JsonKey(name: 'address')
  final String? address;
  @JsonKey(name: 'isActive')
  final bool? isActive;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;
  @JsonKey(name: 'lastLogin')
  final DateTime? lastLogin;
  @JsonKey(name: '_id')
  final String id;
  static const fromJsonFactory = _$UserResponseDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserResponseDTO &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality().equals(
                  other.password,
                  password,
                )) &&
            (identical(other.role, role) ||
                const DeepCollectionEquality().equals(other.role, role)) &&
            (identical(other.phone, phone) ||
                const DeepCollectionEquality().equals(other.phone, phone)) &&
            (identical(other.address, address) ||
                const DeepCollectionEquality().equals(
                  other.address,
                  address,
                )) &&
            (identical(other.isActive, isActive) ||
                const DeepCollectionEquality().equals(
                  other.isActive,
                  isActive,
                )) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(
                  other.createdAt,
                  createdAt,
                )) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality().equals(
                  other.updatedAt,
                  updatedAt,
                )) &&
            (identical(other.lastLogin, lastLogin) ||
                const DeepCollectionEquality().equals(
                  other.lastLogin,
                  lastLogin,
                )) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(password) ^
      const DeepCollectionEquality().hash(role) ^
      const DeepCollectionEquality().hash(phone) ^
      const DeepCollectionEquality().hash(address) ^
      const DeepCollectionEquality().hash(isActive) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(lastLogin) ^
      const DeepCollectionEquality().hash(id) ^
      runtimeType.hashCode;
}

extension $UserResponseDTOExtension on UserResponseDTO {
  UserResponseDTO copyWith({
    String? name,
    String? email,
    String? password,
    enums.UserResponseDTORole? role,
    double? phone,
    String? address,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastLogin,
    String? id,
  }) {
    return UserResponseDTO(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      role: role ?? this.role,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastLogin: lastLogin ?? this.lastLogin,
      id: id ?? this.id,
    );
  }

  UserResponseDTO copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? email,
    Wrapped<String>? password,
    Wrapped<enums.UserResponseDTORole>? role,
    Wrapped<double>? phone,
    Wrapped<String?>? address,
    Wrapped<bool?>? isActive,
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
    Wrapped<DateTime?>? lastLogin,
    Wrapped<String>? id,
  }) {
    return UserResponseDTO(
      name: (name != null ? name.value : this.name),
      email: (email != null ? email.value : this.email),
      password: (password != null ? password.value : this.password),
      role: (role != null ? role.value : this.role),
      phone: (phone != null ? phone.value : this.phone),
      address: (address != null ? address.value : this.address),
      isActive: (isActive != null ? isActive.value : this.isActive),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      lastLogin: (lastLogin != null ? lastLogin.value : this.lastLogin),
      id: (id != null ? id.value : this.id),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CreateProductDTO {
  const CreateProductDTO({
    required this.name,
    this.image,
    required this.categoryId,
    required this.price,
    required this.stock,
    this.discount,
    this.description,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.variantImages,
    this.colors,
    this.materials,
  });

  factory CreateProductDTO.fromJson(Map<String, dynamic> json) =>
      _$CreateProductDTOFromJson(json);

  static const toJsonFactory = _$CreateProductDTOToJson;
  Map<String, dynamic> toJson() => _$CreateProductDTOToJson(this);

  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'categoryId')
  final String categoryId;
  @JsonKey(name: 'price')
  final double price;
  @JsonKey(name: 'stock')
  final double stock;
  @JsonKey(name: 'discount')
  final double? discount;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'isActive')
  final bool? isActive;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;
  @JsonKey(name: 'variantImages')
  final List<CreateProductDTO$VariantImages$Item>? variantImages;
  @JsonKey(name: 'colors')
  final List<String>? colors;
  @JsonKey(name: 'materials')
  final List<String>? materials;
  static const fromJsonFactory = _$CreateProductDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CreateProductDTO &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.image, image) ||
                const DeepCollectionEquality().equals(other.image, image)) &&
            (identical(other.categoryId, categoryId) ||
                const DeepCollectionEquality().equals(
                  other.categoryId,
                  categoryId,
                )) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.stock, stock) ||
                const DeepCollectionEquality().equals(other.stock, stock)) &&
            (identical(other.discount, discount) ||
                const DeepCollectionEquality().equals(
                  other.discount,
                  discount,
                )) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.isActive, isActive) ||
                const DeepCollectionEquality().equals(
                  other.isActive,
                  isActive,
                )) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(
                  other.createdAt,
                  createdAt,
                )) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality().equals(
                  other.updatedAt,
                  updatedAt,
                )) &&
            (identical(other.variantImages, variantImages) ||
                const DeepCollectionEquality().equals(
                  other.variantImages,
                  variantImages,
                )) &&
            (identical(other.colors, colors) ||
                const DeepCollectionEquality().equals(other.colors, colors)) &&
            (identical(other.materials, materials) ||
                const DeepCollectionEquality().equals(
                  other.materials,
                  materials,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(image) ^
      const DeepCollectionEquality().hash(categoryId) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(stock) ^
      const DeepCollectionEquality().hash(discount) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(isActive) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(variantImages) ^
      const DeepCollectionEquality().hash(colors) ^
      const DeepCollectionEquality().hash(materials) ^
      runtimeType.hashCode;
}

extension $CreateProductDTOExtension on CreateProductDTO {
  CreateProductDTO copyWith({
    String? name,
    String? image,
    String? categoryId,
    double? price,
    double? stock,
    double? discount,
    String? description,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<CreateProductDTO$VariantImages$Item>? variantImages,
    List<String>? colors,
    List<String>? materials,
  }) {
    return CreateProductDTO(
      name: name ?? this.name,
      image: image ?? this.image,
      categoryId: categoryId ?? this.categoryId,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      discount: discount ?? this.discount,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      variantImages: variantImages ?? this.variantImages,
      colors: colors ?? this.colors,
      materials: materials ?? this.materials,
    );
  }

  CreateProductDTO copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String?>? image,
    Wrapped<String>? categoryId,
    Wrapped<double>? price,
    Wrapped<double>? stock,
    Wrapped<double?>? discount,
    Wrapped<String?>? description,
    Wrapped<bool?>? isActive,
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
    Wrapped<List<CreateProductDTO$VariantImages$Item>?>? variantImages,
    Wrapped<List<String>?>? colors,
    Wrapped<List<String>?>? materials,
  }) {
    return CreateProductDTO(
      name: (name != null ? name.value : this.name),
      image: (image != null ? image.value : this.image),
      categoryId: (categoryId != null ? categoryId.value : this.categoryId),
      price: (price != null ? price.value : this.price),
      stock: (stock != null ? stock.value : this.stock),
      discount: (discount != null ? discount.value : this.discount),
      description: (description != null ? description.value : this.description),
      isActive: (isActive != null ? isActive.value : this.isActive),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      variantImages:
          (variantImages != null ? variantImages.value : this.variantImages),
      colors: (colors != null ? colors.value : this.colors),
      materials: (materials != null ? materials.value : this.materials),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ProductCategoryInResponseDTO {
  const ProductCategoryInResponseDTO({
    required this.id,
    required this.name,
    this.description,
    this.isActive,
    required this.products,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductCategoryInResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$ProductCategoryInResponseDTOFromJson(json);

  static const toJsonFactory = _$ProductCategoryInResponseDTOToJson;
  Map<String, dynamic> toJson() => _$ProductCategoryInResponseDTOToJson(this);

  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'isActive')
  final bool? isActive;
  @JsonKey(name: 'products', defaultValue: <String>[])
  final List<String> products;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;
  static const fromJsonFactory = _$ProductCategoryInResponseDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ProductCategoryInResponseDTO &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.isActive, isActive) ||
                const DeepCollectionEquality().equals(
                  other.isActive,
                  isActive,
                )) &&
            (identical(other.products, products) ||
                const DeepCollectionEquality().equals(
                  other.products,
                  products,
                )) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(
                  other.createdAt,
                  createdAt,
                )) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality().equals(
                  other.updatedAt,
                  updatedAt,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(isActive) ^
      const DeepCollectionEquality().hash(products) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      runtimeType.hashCode;
}

extension $ProductCategoryInResponseDTOExtension
    on ProductCategoryInResponseDTO {
  ProductCategoryInResponseDTO copyWith({
    String? id,
    String? name,
    String? description,
    bool? isActive,
    List<String>? products,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductCategoryInResponseDTO(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      products: products ?? this.products,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  ProductCategoryInResponseDTO copyWithWrapped({
    Wrapped<String>? id,
    Wrapped<String>? name,
    Wrapped<String?>? description,
    Wrapped<bool?>? isActive,
    Wrapped<List<String>>? products,
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
  }) {
    return ProductCategoryInResponseDTO(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      description: (description != null ? description.value : this.description),
      isActive: (isActive != null ? isActive.value : this.isActive),
      products: (products != null ? products.value : this.products),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ProductResponseDTO {
  const ProductResponseDTO({
    required this.id,
    this.createdAt,
    this.updatedAt,
    required this.name,
    this.category,
    this.colors,
    this.materials,
    this.types,
    this.image,
    this.description,
    required this.price,
    this.discount,
    required this.stock,
    this.isActive,
    this.variantImages,
  });

  factory ProductResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseDTOFromJson(json);

  static const toJsonFactory = _$ProductResponseDTOToJson;
  Map<String, dynamic> toJson() => _$ProductResponseDTOToJson(this);

  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'category')
  final ProductCategoryInResponseDTO? category;
  @JsonKey(name: 'colors', defaultValue: <String>[])
  final List<String>? colors;
  @JsonKey(name: 'materials', defaultValue: <String>[])
  final List<String>? materials;
  @JsonKey(name: 'types', defaultValue: <String>[])
  final List<String>? types;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'price')
  final double price;
  @JsonKey(name: 'discount')
  final double? discount;
  @JsonKey(name: 'stock')
  final double stock;
  @JsonKey(name: 'isActive')
  final bool? isActive;
  @JsonKey(name: 'variantImages')
  final List<ProductResponseDTO$VariantImages$Item>? variantImages;
  static const fromJsonFactory = _$ProductResponseDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ProductResponseDTO &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(
                  other.createdAt,
                  createdAt,
                )) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality().equals(
                  other.updatedAt,
                  updatedAt,
                )) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.category, category) ||
                const DeepCollectionEquality().equals(
                  other.category,
                  category,
                )) &&
            (identical(other.colors, colors) ||
                const DeepCollectionEquality().equals(other.colors, colors)) &&
            (identical(other.materials, materials) ||
                const DeepCollectionEquality().equals(
                  other.materials,
                  materials,
                )) &&
            (identical(other.types, types) ||
                const DeepCollectionEquality().equals(other.types, types)) &&
            (identical(other.image, image) ||
                const DeepCollectionEquality().equals(other.image, image)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.discount, discount) ||
                const DeepCollectionEquality().equals(
                  other.discount,
                  discount,
                )) &&
            (identical(other.stock, stock) ||
                const DeepCollectionEquality().equals(other.stock, stock)) &&
            (identical(other.isActive, isActive) ||
                const DeepCollectionEquality().equals(
                  other.isActive,
                  isActive,
                )) &&
            (identical(other.variantImages, variantImages) ||
                const DeepCollectionEquality().equals(
                  other.variantImages,
                  variantImages,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(category) ^
      const DeepCollectionEquality().hash(colors) ^
      const DeepCollectionEquality().hash(materials) ^
      const DeepCollectionEquality().hash(types) ^
      const DeepCollectionEquality().hash(image) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(discount) ^
      const DeepCollectionEquality().hash(stock) ^
      const DeepCollectionEquality().hash(isActive) ^
      const DeepCollectionEquality().hash(variantImages) ^
      runtimeType.hashCode;
}

extension $ProductResponseDTOExtension on ProductResponseDTO {
  ProductResponseDTO copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? name,
    ProductCategoryInResponseDTO? category,
    List<String>? colors,
    List<String>? materials,
    List<String>? types,
    String? image,
    String? description,
    double? price,
    double? discount,
    double? stock,
    bool? isActive,
    List<ProductResponseDTO$VariantImages$Item>? variantImages,
  }) {
    return ProductResponseDTO(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
      category: category ?? this.category,
      colors: colors ?? this.colors,
      materials: materials ?? this.materials,
      types: types ?? this.types,
      image: image ?? this.image,
      description: description ?? this.description,
      price: price ?? this.price,
      discount: discount ?? this.discount,
      stock: stock ?? this.stock,
      isActive: isActive ?? this.isActive,
      variantImages: variantImages ?? this.variantImages,
    );
  }

  ProductResponseDTO copyWithWrapped({
    Wrapped<String>? id,
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
    Wrapped<String>? name,
    Wrapped<ProductCategoryInResponseDTO?>? category,
    Wrapped<List<String>?>? colors,
    Wrapped<List<String>?>? materials,
    Wrapped<List<String>?>? types,
    Wrapped<String?>? image,
    Wrapped<String?>? description,
    Wrapped<double>? price,
    Wrapped<double?>? discount,
    Wrapped<double>? stock,
    Wrapped<bool?>? isActive,
    Wrapped<List<ProductResponseDTO$VariantImages$Item>?>? variantImages,
  }) {
    return ProductResponseDTO(
      id: (id != null ? id.value : this.id),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      name: (name != null ? name.value : this.name),
      category: (category != null ? category.value : this.category),
      colors: (colors != null ? colors.value : this.colors),
      materials: (materials != null ? materials.value : this.materials),
      types: (types != null ? types.value : this.types),
      image: (image != null ? image.value : this.image),
      description: (description != null ? description.value : this.description),
      price: (price != null ? price.value : this.price),
      discount: (discount != null ? discount.value : this.discount),
      stock: (stock != null ? stock.value : this.stock),
      isActive: (isActive != null ? isActive.value : this.isActive),
      variantImages:
          (variantImages != null ? variantImages.value : this.variantImages),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SingleProductResponseDTO {
  const SingleProductResponseDTO({required this.data});

  factory SingleProductResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$SingleProductResponseDTOFromJson(json);

  static const toJsonFactory = _$SingleProductResponseDTOToJson;
  Map<String, dynamic> toJson() => _$SingleProductResponseDTOToJson(this);

  @JsonKey(name: 'data')
  final ProductResponseDTO data;
  static const fromJsonFactory = _$SingleProductResponseDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SingleProductResponseDTO &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(data) ^ runtimeType.hashCode;
}

extension $SingleProductResponseDTOExtension on SingleProductResponseDTO {
  SingleProductResponseDTO copyWith({ProductResponseDTO? data}) {
    return SingleProductResponseDTO(data: data ?? this.data);
  }

  SingleProductResponseDTO copyWithWrapped({
    Wrapped<ProductResponseDTO>? data,
  }) {
    return SingleProductResponseDTO(
      data: (data != null ? data.value : this.data),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class GetAllProductsResponseDTO {
  const GetAllProductsResponseDTO({required this.data});

  factory GetAllProductsResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllProductsResponseDTOFromJson(json);

  static const toJsonFactory = _$GetAllProductsResponseDTOToJson;
  Map<String, dynamic> toJson() => _$GetAllProductsResponseDTOToJson(this);

  @JsonKey(name: 'data', defaultValue: <ProductResponseDTO>[])
  final List<ProductResponseDTO> data;
  static const fromJsonFactory = _$GetAllProductsResponseDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is GetAllProductsResponseDTO &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(data) ^ runtimeType.hashCode;
}

extension $GetAllProductsResponseDTOExtension on GetAllProductsResponseDTO {
  GetAllProductsResponseDTO copyWith({List<ProductResponseDTO>? data}) {
    return GetAllProductsResponseDTO(data: data ?? this.data);
  }

  GetAllProductsResponseDTO copyWithWrapped({
    Wrapped<List<ProductResponseDTO>>? data,
  }) {
    return GetAllProductsResponseDTO(
      data: (data != null ? data.value : this.data),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class MessageResponseDTO {
  const MessageResponseDTO({required this.message});

  factory MessageResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$MessageResponseDTOFromJson(json);

  static const toJsonFactory = _$MessageResponseDTOToJson;
  Map<String, dynamic> toJson() => _$MessageResponseDTOToJson(this);

  @JsonKey(name: 'message')
  final String message;
  static const fromJsonFactory = _$MessageResponseDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MessageResponseDTO &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(message) ^ runtimeType.hashCode;
}

extension $MessageResponseDTOExtension on MessageResponseDTO {
  MessageResponseDTO copyWith({String? message}) {
    return MessageResponseDTO(message: message ?? this.message);
  }

  MessageResponseDTO copyWithWrapped({Wrapped<String>? message}) {
    return MessageResponseDTO(
      message: (message != null ? message.value : this.message),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CreateProductCategoryDTO {
  const CreateProductCategoryDTO({
    required this.name,
    this.description,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory CreateProductCategoryDTO.fromJson(Map<String, dynamic> json) =>
      _$CreateProductCategoryDTOFromJson(json);

  static const toJsonFactory = _$CreateProductCategoryDTOToJson;
  Map<String, dynamic> toJson() => _$CreateProductCategoryDTOToJson(this);

  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'isActive')
  final bool? isActive;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;
  static const fromJsonFactory = _$CreateProductCategoryDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CreateProductCategoryDTO &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.isActive, isActive) ||
                const DeepCollectionEquality().equals(
                  other.isActive,
                  isActive,
                )) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(
                  other.createdAt,
                  createdAt,
                )) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality().equals(
                  other.updatedAt,
                  updatedAt,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(isActive) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      runtimeType.hashCode;
}

extension $CreateProductCategoryDTOExtension on CreateProductCategoryDTO {
  CreateProductCategoryDTO copyWith({
    String? name,
    String? description,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CreateProductCategoryDTO(
      name: name ?? this.name,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  CreateProductCategoryDTO copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String?>? description,
    Wrapped<bool?>? isActive,
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
  }) {
    return CreateProductCategoryDTO(
      name: (name != null ? name.value : this.name),
      description: (description != null ? description.value : this.description),
      isActive: (isActive != null ? isActive.value : this.isActive),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ProductCategoryResponseDTO {
  const ProductCategoryResponseDTO({
    required this.name,
    this.description,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    required this.id,
  });

  factory ProductCategoryResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$ProductCategoryResponseDTOFromJson(json);

  static const toJsonFactory = _$ProductCategoryResponseDTOToJson;
  Map<String, dynamic> toJson() => _$ProductCategoryResponseDTOToJson(this);

  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'isActive')
  final bool? isActive;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;
  @JsonKey(name: '_id')
  final String id;
  static const fromJsonFactory = _$ProductCategoryResponseDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ProductCategoryResponseDTO &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.isActive, isActive) ||
                const DeepCollectionEquality().equals(
                  other.isActive,
                  isActive,
                )) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(
                  other.createdAt,
                  createdAt,
                )) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality().equals(
                  other.updatedAt,
                  updatedAt,
                )) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(isActive) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(id) ^
      runtimeType.hashCode;
}

extension $ProductCategoryResponseDTOExtension on ProductCategoryResponseDTO {
  ProductCategoryResponseDTO copyWith({
    String? name,
    String? description,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
  }) {
    return ProductCategoryResponseDTO(
      name: name ?? this.name,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
    );
  }

  ProductCategoryResponseDTO copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String?>? description,
    Wrapped<bool?>? isActive,
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
    Wrapped<String>? id,
  }) {
    return ProductCategoryResponseDTO(
      name: (name != null ? name.value : this.name),
      description: (description != null ? description.value : this.description),
      isActive: (isActive != null ? isActive.value : this.isActive),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      id: (id != null ? id.value : this.id),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class GetAllProductCategoriesResponseDTO {
  const GetAllProductCategoriesResponseDTO({required this.data});

  factory GetAllProductCategoriesResponseDTO.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$GetAllProductCategoriesResponseDTOFromJson(json);

  static const toJsonFactory = _$GetAllProductCategoriesResponseDTOToJson;
  Map<String, dynamic> toJson() =>
      _$GetAllProductCategoriesResponseDTOToJson(this);

  @JsonKey(name: 'data', defaultValue: <ProductCategoryResponseDTO>[])
  final List<ProductCategoryResponseDTO> data;
  static const fromJsonFactory = _$GetAllProductCategoriesResponseDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is GetAllProductCategoriesResponseDTO &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(data) ^ runtimeType.hashCode;
}

extension $GetAllProductCategoriesResponseDTOExtension
    on GetAllProductCategoriesResponseDTO {
  GetAllProductCategoriesResponseDTO copyWith({
    List<ProductCategoryResponseDTO>? data,
  }) {
    return GetAllProductCategoriesResponseDTO(data: data ?? this.data);
  }

  GetAllProductCategoriesResponseDTO copyWithWrapped({
    Wrapped<List<ProductCategoryResponseDTO>>? data,
  }) {
    return GetAllProductCategoriesResponseDTO(
      data: (data != null ? data.value : this.data),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class OrderItemDTO {
  const OrderItemDTO({
    this.orderId,
    required this.productId,
    required this.quantity,
  });

  factory OrderItemDTO.fromJson(Map<String, dynamic> json) =>
      _$OrderItemDTOFromJson(json);

  static const toJsonFactory = _$OrderItemDTOToJson;
  Map<String, dynamic> toJson() => _$OrderItemDTOToJson(this);

  @JsonKey(name: 'orderId')
  final String? orderId;
  @JsonKey(name: 'productId')
  final String productId;
  @JsonKey(name: 'quantity')
  final double quantity;
  static const fromJsonFactory = _$OrderItemDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is OrderItemDTO &&
            (identical(other.orderId, orderId) ||
                const DeepCollectionEquality().equals(
                  other.orderId,
                  orderId,
                )) &&
            (identical(other.productId, productId) ||
                const DeepCollectionEquality().equals(
                  other.productId,
                  productId,
                )) &&
            (identical(other.quantity, quantity) ||
                const DeepCollectionEquality().equals(
                  other.quantity,
                  quantity,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(orderId) ^
      const DeepCollectionEquality().hash(productId) ^
      const DeepCollectionEquality().hash(quantity) ^
      runtimeType.hashCode;
}

extension $OrderItemDTOExtension on OrderItemDTO {
  OrderItemDTO copyWith({
    String? orderId,
    String? productId,
    double? quantity,
  }) {
    return OrderItemDTO(
      orderId: orderId ?? this.orderId,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
    );
  }

  OrderItemDTO copyWithWrapped({
    Wrapped<String?>? orderId,
    Wrapped<String>? productId,
    Wrapped<double>? quantity,
  }) {
    return OrderItemDTO(
      orderId: (orderId != null ? orderId.value : this.orderId),
      productId: (productId != null ? productId.value : this.productId),
      quantity: (quantity != null ? quantity.value : this.quantity),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CreateOrderDTO {
  const CreateOrderDTO({required this.userId, required this.items});

  factory CreateOrderDTO.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderDTOFromJson(json);

  static const toJsonFactory = _$CreateOrderDTOToJson;
  Map<String, dynamic> toJson() => _$CreateOrderDTOToJson(this);

  @JsonKey(name: 'userId')
  final String userId;
  @JsonKey(name: 'items', defaultValue: <OrderItemDTO>[])
  final List<OrderItemDTO> items;
  static const fromJsonFactory = _$CreateOrderDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CreateOrderDTO &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.items, items) ||
                const DeepCollectionEquality().equals(other.items, items)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(items) ^
      runtimeType.hashCode;
}

extension $CreateOrderDTOExtension on CreateOrderDTO {
  CreateOrderDTO copyWith({String? userId, List<OrderItemDTO>? items}) {
    return CreateOrderDTO(
      userId: userId ?? this.userId,
      items: items ?? this.items,
    );
  }

  CreateOrderDTO copyWithWrapped({
    Wrapped<String>? userId,
    Wrapped<List<OrderItemDTO>>? items,
  }) {
    return CreateOrderDTO(
      userId: (userId != null ? userId.value : this.userId),
      items: (items != null ? items.value : this.items),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class OrderResponseDTO {
  const OrderResponseDTO({
    required this.userId,
    required this.items,
    required this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory OrderResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$OrderResponseDTOFromJson(json);

  static const toJsonFactory = _$OrderResponseDTOToJson;
  Map<String, dynamic> toJson() => _$OrderResponseDTOToJson(this);

  @JsonKey(name: 'userId')
  final String userId;
  @JsonKey(name: 'items', defaultValue: <OrderItemDTO>[])
  final List<OrderItemDTO> items;
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;
  static const fromJsonFactory = _$OrderResponseDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is OrderResponseDTO &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.items, items) ||
                const DeepCollectionEquality().equals(other.items, items)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(
                  other.createdAt,
                  createdAt,
                )) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality().equals(
                  other.updatedAt,
                  updatedAt,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(items) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      runtimeType.hashCode;
}

extension $OrderResponseDTOExtension on OrderResponseDTO {
  OrderResponseDTO copyWith({
    String? userId,
    List<OrderItemDTO>? items,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return OrderResponseDTO(
      userId: userId ?? this.userId,
      items: items ?? this.items,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  OrderResponseDTO copyWithWrapped({
    Wrapped<String>? userId,
    Wrapped<List<OrderItemDTO>>? items,
    Wrapped<String>? id,
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
  }) {
    return OrderResponseDTO(
      userId: (userId != null ? userId.value : this.userId),
      items: (items != null ? items.value : this.items),
      id: (id != null ? id.value : this.id),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CreateCareerDTO {
  const CreateCareerDTO({
    this.title,
    this.description,
    this.location,
    this.type,
    this.salary,
    this.isActive,
  });

  factory CreateCareerDTO.fromJson(Map<String, dynamic> json) =>
      _$CreateCareerDTOFromJson(json);

  static const toJsonFactory = _$CreateCareerDTOToJson;
  Map<String, dynamic> toJson() => _$CreateCareerDTOToJson(this);

  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'location')
  final String? location;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'salary')
  final String? salary;
  @JsonKey(name: 'isActive')
  final bool? isActive;
  static const fromJsonFactory = _$CreateCareerDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CreateCareerDTO &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.location, location) ||
                const DeepCollectionEquality().equals(
                  other.location,
                  location,
                )) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.salary, salary) ||
                const DeepCollectionEquality().equals(other.salary, salary)) &&
            (identical(other.isActive, isActive) ||
                const DeepCollectionEquality().equals(
                  other.isActive,
                  isActive,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(location) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(salary) ^
      const DeepCollectionEquality().hash(isActive) ^
      runtimeType.hashCode;
}

extension $CreateCareerDTOExtension on CreateCareerDTO {
  CreateCareerDTO copyWith({
    String? title,
    String? description,
    String? location,
    String? type,
    String? salary,
    bool? isActive,
  }) {
    return CreateCareerDTO(
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      type: type ?? this.type,
      salary: salary ?? this.salary,
      isActive: isActive ?? this.isActive,
    );
  }

  CreateCareerDTO copyWithWrapped({
    Wrapped<String?>? title,
    Wrapped<String?>? description,
    Wrapped<String?>? location,
    Wrapped<String?>? type,
    Wrapped<String?>? salary,
    Wrapped<bool?>? isActive,
  }) {
    return CreateCareerDTO(
      title: (title != null ? title.value : this.title),
      description: (description != null ? description.value : this.description),
      location: (location != null ? location.value : this.location),
      type: (type != null ? type.value : this.type),
      salary: (salary != null ? salary.value : this.salary),
      isActive: (isActive != null ? isActive.value : this.isActive),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CareerResponseDTO {
  const CareerResponseDTO({
    this.title,
    this.description,
    this.location,
    this.type,
    this.salary,
    this.isActive,
    required this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory CareerResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$CareerResponseDTOFromJson(json);

  static const toJsonFactory = _$CareerResponseDTOToJson;
  Map<String, dynamic> toJson() => _$CareerResponseDTOToJson(this);

  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'location')
  final String? location;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'salary')
  final String? salary;
  @JsonKey(name: 'isActive')
  final bool? isActive;
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;
  static const fromJsonFactory = _$CareerResponseDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CareerResponseDTO &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.location, location) ||
                const DeepCollectionEquality().equals(
                  other.location,
                  location,
                )) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.salary, salary) ||
                const DeepCollectionEquality().equals(other.salary, salary)) &&
            (identical(other.isActive, isActive) ||
                const DeepCollectionEquality().equals(
                  other.isActive,
                  isActive,
                )) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(
                  other.createdAt,
                  createdAt,
                )) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality().equals(
                  other.updatedAt,
                  updatedAt,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(location) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(salary) ^
      const DeepCollectionEquality().hash(isActive) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      runtimeType.hashCode;
}

extension $CareerResponseDTOExtension on CareerResponseDTO {
  CareerResponseDTO copyWith({
    String? title,
    String? description,
    String? location,
    String? type,
    String? salary,
    bool? isActive,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CareerResponseDTO(
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      type: type ?? this.type,
      salary: salary ?? this.salary,
      isActive: isActive ?? this.isActive,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  CareerResponseDTO copyWithWrapped({
    Wrapped<String?>? title,
    Wrapped<String?>? description,
    Wrapped<String?>? location,
    Wrapped<String?>? type,
    Wrapped<String?>? salary,
    Wrapped<bool?>? isActive,
    Wrapped<String>? id,
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
  }) {
    return CareerResponseDTO(
      title: (title != null ? title.value : this.title),
      description: (description != null ? description.value : this.description),
      location: (location != null ? location.value : this.location),
      type: (type != null ? type.value : this.type),
      salary: (salary != null ? salary.value : this.salary),
      isActive: (isActive != null ? isActive.value : this.isActive),
      id: (id != null ? id.value : this.id),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class GetAllCareersResponseDTO {
  const GetAllCareersResponseDTO({required this.data});

  factory GetAllCareersResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllCareersResponseDTOFromJson(json);

  static const toJsonFactory = _$GetAllCareersResponseDTOToJson;
  Map<String, dynamic> toJson() => _$GetAllCareersResponseDTOToJson(this);

  @JsonKey(name: 'data', defaultValue: <CareerResponseDTO>[])
  final List<CareerResponseDTO> data;
  static const fromJsonFactory = _$GetAllCareersResponseDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is GetAllCareersResponseDTO &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(data) ^ runtimeType.hashCode;
}

extension $GetAllCareersResponseDTOExtension on GetAllCareersResponseDTO {
  GetAllCareersResponseDTO copyWith({List<CareerResponseDTO>? data}) {
    return GetAllCareersResponseDTO(data: data ?? this.data);
  }

  GetAllCareersResponseDTO copyWithWrapped({
    Wrapped<List<CareerResponseDTO>>? data,
  }) {
    return GetAllCareersResponseDTO(
      data: (data != null ? data.value : this.data),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CreateProductColorDTO {
  const CreateProductColorDTO({
    required this.name,
    this.hexCode,
    this.isActive,
  });

  factory CreateProductColorDTO.fromJson(Map<String, dynamic> json) =>
      _$CreateProductColorDTOFromJson(json);

  static const toJsonFactory = _$CreateProductColorDTOToJson;
  Map<String, dynamic> toJson() => _$CreateProductColorDTOToJson(this);

  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'hexCode')
  final String? hexCode;
  @JsonKey(name: 'isActive')
  final bool? isActive;
  static const fromJsonFactory = _$CreateProductColorDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CreateProductColorDTO &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.hexCode, hexCode) ||
                const DeepCollectionEquality().equals(
                  other.hexCode,
                  hexCode,
                )) &&
            (identical(other.isActive, isActive) ||
                const DeepCollectionEquality().equals(
                  other.isActive,
                  isActive,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(hexCode) ^
      const DeepCollectionEquality().hash(isActive) ^
      runtimeType.hashCode;
}

extension $CreateProductColorDTOExtension on CreateProductColorDTO {
  CreateProductColorDTO copyWith({
    String? name,
    String? hexCode,
    bool? isActive,
  }) {
    return CreateProductColorDTO(
      name: name ?? this.name,
      hexCode: hexCode ?? this.hexCode,
      isActive: isActive ?? this.isActive,
    );
  }

  CreateProductColorDTO copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String?>? hexCode,
    Wrapped<bool?>? isActive,
  }) {
    return CreateProductColorDTO(
      name: (name != null ? name.value : this.name),
      hexCode: (hexCode != null ? hexCode.value : this.hexCode),
      isActive: (isActive != null ? isActive.value : this.isActive),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ProductColorResponseDTO {
  const ProductColorResponseDTO({
    required this.name,
    this.hexCode,
    this.isActive,
    required this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductColorResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$ProductColorResponseDTOFromJson(json);

  static const toJsonFactory = _$ProductColorResponseDTOToJson;
  Map<String, dynamic> toJson() => _$ProductColorResponseDTOToJson(this);

  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'hexCode')
  final String? hexCode;
  @JsonKey(name: 'isActive')
  final bool? isActive;
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;
  static const fromJsonFactory = _$ProductColorResponseDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ProductColorResponseDTO &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.hexCode, hexCode) ||
                const DeepCollectionEquality().equals(
                  other.hexCode,
                  hexCode,
                )) &&
            (identical(other.isActive, isActive) ||
                const DeepCollectionEquality().equals(
                  other.isActive,
                  isActive,
                )) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(
                  other.createdAt,
                  createdAt,
                )) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality().equals(
                  other.updatedAt,
                  updatedAt,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(hexCode) ^
      const DeepCollectionEquality().hash(isActive) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      runtimeType.hashCode;
}

extension $ProductColorResponseDTOExtension on ProductColorResponseDTO {
  ProductColorResponseDTO copyWith({
    String? name,
    String? hexCode,
    bool? isActive,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductColorResponseDTO(
      name: name ?? this.name,
      hexCode: hexCode ?? this.hexCode,
      isActive: isActive ?? this.isActive,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  ProductColorResponseDTO copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String?>? hexCode,
    Wrapped<bool?>? isActive,
    Wrapped<String>? id,
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
  }) {
    return ProductColorResponseDTO(
      name: (name != null ? name.value : this.name),
      hexCode: (hexCode != null ? hexCode.value : this.hexCode),
      isActive: (isActive != null ? isActive.value : this.isActive),
      id: (id != null ? id.value : this.id),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class GetAllProductColorsResponseDTO {
  const GetAllProductColorsResponseDTO({required this.data});

  factory GetAllProductColorsResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllProductColorsResponseDTOFromJson(json);

  static const toJsonFactory = _$GetAllProductColorsResponseDTOToJson;
  Map<String, dynamic> toJson() => _$GetAllProductColorsResponseDTOToJson(this);

  @JsonKey(name: 'data', defaultValue: <ProductColorResponseDTO>[])
  final List<ProductColorResponseDTO> data;
  static const fromJsonFactory = _$GetAllProductColorsResponseDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is GetAllProductColorsResponseDTO &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(data) ^ runtimeType.hashCode;
}

extension $GetAllProductColorsResponseDTOExtension
    on GetAllProductColorsResponseDTO {
  GetAllProductColorsResponseDTO copyWith({
    List<ProductColorResponseDTO>? data,
  }) {
    return GetAllProductColorsResponseDTO(data: data ?? this.data);
  }

  GetAllProductColorsResponseDTO copyWithWrapped({
    Wrapped<List<ProductColorResponseDTO>>? data,
  }) {
    return GetAllProductColorsResponseDTO(
      data: (data != null ? data.value : this.data),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CreateProductTypeDTO {
  const CreateProductTypeDTO({
    required this.name,
    this.description,
    this.isActive,
  });

  factory CreateProductTypeDTO.fromJson(Map<String, dynamic> json) =>
      _$CreateProductTypeDTOFromJson(json);

  static const toJsonFactory = _$CreateProductTypeDTOToJson;
  Map<String, dynamic> toJson() => _$CreateProductTypeDTOToJson(this);

  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'isActive')
  final bool? isActive;
  static const fromJsonFactory = _$CreateProductTypeDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CreateProductTypeDTO &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.isActive, isActive) ||
                const DeepCollectionEquality().equals(
                  other.isActive,
                  isActive,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(isActive) ^
      runtimeType.hashCode;
}

extension $CreateProductTypeDTOExtension on CreateProductTypeDTO {
  CreateProductTypeDTO copyWith({
    String? name,
    String? description,
    bool? isActive,
  }) {
    return CreateProductTypeDTO(
      name: name ?? this.name,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
    );
  }

  CreateProductTypeDTO copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String?>? description,
    Wrapped<bool?>? isActive,
  }) {
    return CreateProductTypeDTO(
      name: (name != null ? name.value : this.name),
      description: (description != null ? description.value : this.description),
      isActive: (isActive != null ? isActive.value : this.isActive),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ProductTypeResponseDTO {
  const ProductTypeResponseDTO({
    required this.name,
    this.description,
    this.isActive,
    required this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductTypeResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$ProductTypeResponseDTOFromJson(json);

  static const toJsonFactory = _$ProductTypeResponseDTOToJson;
  Map<String, dynamic> toJson() => _$ProductTypeResponseDTOToJson(this);

  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'isActive')
  final bool? isActive;
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;
  static const fromJsonFactory = _$ProductTypeResponseDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ProductTypeResponseDTO &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.isActive, isActive) ||
                const DeepCollectionEquality().equals(
                  other.isActive,
                  isActive,
                )) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(
                  other.createdAt,
                  createdAt,
                )) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality().equals(
                  other.updatedAt,
                  updatedAt,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(isActive) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      runtimeType.hashCode;
}

extension $ProductTypeResponseDTOExtension on ProductTypeResponseDTO {
  ProductTypeResponseDTO copyWith({
    String? name,
    String? description,
    bool? isActive,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductTypeResponseDTO(
      name: name ?? this.name,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  ProductTypeResponseDTO copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String?>? description,
    Wrapped<bool?>? isActive,
    Wrapped<String>? id,
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
  }) {
    return ProductTypeResponseDTO(
      name: (name != null ? name.value : this.name),
      description: (description != null ? description.value : this.description),
      isActive: (isActive != null ? isActive.value : this.isActive),
      id: (id != null ? id.value : this.id),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class GetAllProductTypesResponseDTO {
  const GetAllProductTypesResponseDTO({required this.data});

  factory GetAllProductTypesResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllProductTypesResponseDTOFromJson(json);

  static const toJsonFactory = _$GetAllProductTypesResponseDTOToJson;
  Map<String, dynamic> toJson() => _$GetAllProductTypesResponseDTOToJson(this);

  @JsonKey(name: 'data', defaultValue: <ProductTypeResponseDTO>[])
  final List<ProductTypeResponseDTO> data;
  static const fromJsonFactory = _$GetAllProductTypesResponseDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is GetAllProductTypesResponseDTO &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(data) ^ runtimeType.hashCode;
}

extension $GetAllProductTypesResponseDTOExtension
    on GetAllProductTypesResponseDTO {
  GetAllProductTypesResponseDTO copyWith({List<ProductTypeResponseDTO>? data}) {
    return GetAllProductTypesResponseDTO(data: data ?? this.data);
  }

  GetAllProductTypesResponseDTO copyWithWrapped({
    Wrapped<List<ProductTypeResponseDTO>>? data,
  }) {
    return GetAllProductTypesResponseDTO(
      data: (data != null ? data.value : this.data),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CreateProductMaterialDTO {
  const CreateProductMaterialDTO({
    required this.name,
    this.description,
    this.isActive,
  });

  factory CreateProductMaterialDTO.fromJson(Map<String, dynamic> json) =>
      _$CreateProductMaterialDTOFromJson(json);

  static const toJsonFactory = _$CreateProductMaterialDTOToJson;
  Map<String, dynamic> toJson() => _$CreateProductMaterialDTOToJson(this);

  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'isActive')
  final bool? isActive;
  static const fromJsonFactory = _$CreateProductMaterialDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CreateProductMaterialDTO &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.isActive, isActive) ||
                const DeepCollectionEquality().equals(
                  other.isActive,
                  isActive,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(isActive) ^
      runtimeType.hashCode;
}

extension $CreateProductMaterialDTOExtension on CreateProductMaterialDTO {
  CreateProductMaterialDTO copyWith({
    String? name,
    String? description,
    bool? isActive,
  }) {
    return CreateProductMaterialDTO(
      name: name ?? this.name,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
    );
  }

  CreateProductMaterialDTO copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String?>? description,
    Wrapped<bool?>? isActive,
  }) {
    return CreateProductMaterialDTO(
      name: (name != null ? name.value : this.name),
      description: (description != null ? description.value : this.description),
      isActive: (isActive != null ? isActive.value : this.isActive),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ProductMaterialResponseDTO {
  const ProductMaterialResponseDTO({
    required this.name,
    this.description,
    this.isActive,
    required this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductMaterialResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$ProductMaterialResponseDTOFromJson(json);

  static const toJsonFactory = _$ProductMaterialResponseDTOToJson;
  Map<String, dynamic> toJson() => _$ProductMaterialResponseDTOToJson(this);

  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'isActive')
  final bool? isActive;
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;
  static const fromJsonFactory = _$ProductMaterialResponseDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ProductMaterialResponseDTO &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.isActive, isActive) ||
                const DeepCollectionEquality().equals(
                  other.isActive,
                  isActive,
                )) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(
                  other.createdAt,
                  createdAt,
                )) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality().equals(
                  other.updatedAt,
                  updatedAt,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(isActive) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      runtimeType.hashCode;
}

extension $ProductMaterialResponseDTOExtension on ProductMaterialResponseDTO {
  ProductMaterialResponseDTO copyWith({
    String? name,
    String? description,
    bool? isActive,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductMaterialResponseDTO(
      name: name ?? this.name,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  ProductMaterialResponseDTO copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String?>? description,
    Wrapped<bool?>? isActive,
    Wrapped<String>? id,
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
  }) {
    return ProductMaterialResponseDTO(
      name: (name != null ? name.value : this.name),
      description: (description != null ? description.value : this.description),
      isActive: (isActive != null ? isActive.value : this.isActive),
      id: (id != null ? id.value : this.id),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class GetAllProductMaterialsResponseDTO {
  const GetAllProductMaterialsResponseDTO({required this.data});

  factory GetAllProductMaterialsResponseDTO.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$GetAllProductMaterialsResponseDTOFromJson(json);

  static const toJsonFactory = _$GetAllProductMaterialsResponseDTOToJson;
  Map<String, dynamic> toJson() =>
      _$GetAllProductMaterialsResponseDTOToJson(this);

  @JsonKey(name: 'data', defaultValue: <ProductMaterialResponseDTO>[])
  final List<ProductMaterialResponseDTO> data;
  static const fromJsonFactory = _$GetAllProductMaterialsResponseDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is GetAllProductMaterialsResponseDTO &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(data) ^ runtimeType.hashCode;
}

extension $GetAllProductMaterialsResponseDTOExtension
    on GetAllProductMaterialsResponseDTO {
  GetAllProductMaterialsResponseDTO copyWith({
    List<ProductMaterialResponseDTO>? data,
  }) {
    return GetAllProductMaterialsResponseDTO(data: data ?? this.data);
  }

  GetAllProductMaterialsResponseDTO copyWithWrapped({
    Wrapped<List<ProductMaterialResponseDTO>>? data,
  }) {
    return GetAllProductMaterialsResponseDTO(
      data: (data != null ? data.value : this.data),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CreatePortfolioDTO {
  const CreatePortfolioDTO({
    required this.title,
    required this.description,
    required this.category,
    required this.image,
    this.projectUrl,
    this.$client,
    this.startDate,
    this.endDate,
    this.jobScope,
    this.isActive,
  });

  factory CreatePortfolioDTO.fromJson(Map<String, dynamic> json) =>
      _$CreatePortfolioDTOFromJson(json);

  static const toJsonFactory = _$CreatePortfolioDTOToJson;
  Map<String, dynamic> toJson() => _$CreatePortfolioDTOToJson(this);

  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'category')
  final String category;
  @JsonKey(name: 'image', defaultValue: <String>[])
  final List<String> image;
  @JsonKey(name: 'projectUrl')
  final String? projectUrl;
  @JsonKey(name: 'client')
  final String? $client;
  @JsonKey(name: 'startDate')
  final String? startDate;
  @JsonKey(name: 'endDate')
  final String? endDate;
  @JsonKey(name: 'jobScope')
  final String? jobScope;
  @JsonKey(name: 'isActive')
  final bool? isActive;
  static const fromJsonFactory = _$CreatePortfolioDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CreatePortfolioDTO &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.category, category) ||
                const DeepCollectionEquality().equals(
                  other.category,
                  category,
                )) &&
            (identical(other.image, image) ||
                const DeepCollectionEquality().equals(other.image, image)) &&
            (identical(other.projectUrl, projectUrl) ||
                const DeepCollectionEquality().equals(
                  other.projectUrl,
                  projectUrl,
                )) &&
            (identical(other.$client, $client) ||
                const DeepCollectionEquality().equals(
                  other.$client,
                  $client,
                )) &&
            (identical(other.startDate, startDate) ||
                const DeepCollectionEquality().equals(
                  other.startDate,
                  startDate,
                )) &&
            (identical(other.endDate, endDate) ||
                const DeepCollectionEquality().equals(
                  other.endDate,
                  endDate,
                )) &&
            (identical(other.jobScope, jobScope) ||
                const DeepCollectionEquality().equals(
                  other.jobScope,
                  jobScope,
                )) &&
            (identical(other.isActive, isActive) ||
                const DeepCollectionEquality().equals(
                  other.isActive,
                  isActive,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(category) ^
      const DeepCollectionEquality().hash(image) ^
      const DeepCollectionEquality().hash(projectUrl) ^
      const DeepCollectionEquality().hash($client) ^
      const DeepCollectionEquality().hash(startDate) ^
      const DeepCollectionEquality().hash(endDate) ^
      const DeepCollectionEquality().hash(jobScope) ^
      const DeepCollectionEquality().hash(isActive) ^
      runtimeType.hashCode;
}

extension $CreatePortfolioDTOExtension on CreatePortfolioDTO {
  CreatePortfolioDTO copyWith({
    String? title,
    String? description,
    String? category,
    List<String>? image,
    String? projectUrl,
    String? $client,
    String? startDate,
    String? endDate,
    String? jobScope,
    bool? isActive,
  }) {
    return CreatePortfolioDTO(
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      image: image ?? this.image,
      projectUrl: projectUrl ?? this.projectUrl,
      $client: $client ?? this.$client,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      jobScope: jobScope ?? this.jobScope,
      isActive: isActive ?? this.isActive,
    );
  }

  CreatePortfolioDTO copyWithWrapped({
    Wrapped<String>? title,
    Wrapped<String>? description,
    Wrapped<String>? category,
    Wrapped<List<String>>? image,
    Wrapped<String?>? projectUrl,
    Wrapped<String?>? $client,
    Wrapped<String?>? startDate,
    Wrapped<String?>? endDate,
    Wrapped<String?>? jobScope,
    Wrapped<bool?>? isActive,
  }) {
    return CreatePortfolioDTO(
      title: (title != null ? title.value : this.title),
      description: (description != null ? description.value : this.description),
      category: (category != null ? category.value : this.category),
      image: (image != null ? image.value : this.image),
      projectUrl: (projectUrl != null ? projectUrl.value : this.projectUrl),
      $client: ($client != null ? $client.value : this.$client),
      startDate: (startDate != null ? startDate.value : this.startDate),
      endDate: (endDate != null ? endDate.value : this.endDate),
      jobScope: (jobScope != null ? jobScope.value : this.jobScope),
      isActive: (isActive != null ? isActive.value : this.isActive),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PortfolioCategoryResponseDTO {
  const PortfolioCategoryResponseDTO({
    required this.name,
    this.description,
    this.isActive,
    required this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory PortfolioCategoryResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$PortfolioCategoryResponseDTOFromJson(json);

  static const toJsonFactory = _$PortfolioCategoryResponseDTOToJson;
  Map<String, dynamic> toJson() => _$PortfolioCategoryResponseDTOToJson(this);

  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'isActive')
  final bool? isActive;
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;
  static const fromJsonFactory = _$PortfolioCategoryResponseDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PortfolioCategoryResponseDTO &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.isActive, isActive) ||
                const DeepCollectionEquality().equals(
                  other.isActive,
                  isActive,
                )) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(
                  other.createdAt,
                  createdAt,
                )) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality().equals(
                  other.updatedAt,
                  updatedAt,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(isActive) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      runtimeType.hashCode;
}

extension $PortfolioCategoryResponseDTOExtension
    on PortfolioCategoryResponseDTO {
  PortfolioCategoryResponseDTO copyWith({
    String? name,
    String? description,
    bool? isActive,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PortfolioCategoryResponseDTO(
      name: name ?? this.name,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  PortfolioCategoryResponseDTO copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String?>? description,
    Wrapped<bool?>? isActive,
    Wrapped<String>? id,
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
  }) {
    return PortfolioCategoryResponseDTO(
      name: (name != null ? name.value : this.name),
      description: (description != null ? description.value : this.description),
      isActive: (isActive != null ? isActive.value : this.isActive),
      id: (id != null ? id.value : this.id),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PortfolioResponseDTO {
  const PortfolioResponseDTO({
    required this.title,
    required this.description,
    required this.image,
    this.projectUrl,
    this.$client,
    this.startDate,
    this.endDate,
    this.jobScope,
    this.isActive,
    required this.id,
    this.createdAt,
    this.updatedAt,
    this.category,
  });

  factory PortfolioResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$PortfolioResponseDTOFromJson(json);

  static const toJsonFactory = _$PortfolioResponseDTOToJson;
  Map<String, dynamic> toJson() => _$PortfolioResponseDTOToJson(this);

  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'image', defaultValue: <String>[])
  final List<String> image;
  @JsonKey(name: 'projectUrl')
  final String? projectUrl;
  @JsonKey(name: 'client')
  final String? $client;
  @JsonKey(name: 'startDate')
  final String? startDate;
  @JsonKey(name: 'endDate')
  final String? endDate;
  @JsonKey(name: 'jobScope')
  final String? jobScope;
  @JsonKey(name: 'isActive')
  final bool? isActive;
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;
  @JsonKey(name: 'category')
  final PortfolioCategoryResponseDTO? category;
  static const fromJsonFactory = _$PortfolioResponseDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PortfolioResponseDTO &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.image, image) ||
                const DeepCollectionEquality().equals(other.image, image)) &&
            (identical(other.projectUrl, projectUrl) ||
                const DeepCollectionEquality().equals(
                  other.projectUrl,
                  projectUrl,
                )) &&
            (identical(other.$client, $client) ||
                const DeepCollectionEquality().equals(
                  other.$client,
                  $client,
                )) &&
            (identical(other.startDate, startDate) ||
                const DeepCollectionEquality().equals(
                  other.startDate,
                  startDate,
                )) &&
            (identical(other.endDate, endDate) ||
                const DeepCollectionEquality().equals(
                  other.endDate,
                  endDate,
                )) &&
            (identical(other.jobScope, jobScope) ||
                const DeepCollectionEquality().equals(
                  other.jobScope,
                  jobScope,
                )) &&
            (identical(other.isActive, isActive) ||
                const DeepCollectionEquality().equals(
                  other.isActive,
                  isActive,
                )) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(
                  other.createdAt,
                  createdAt,
                )) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality().equals(
                  other.updatedAt,
                  updatedAt,
                )) &&
            (identical(other.category, category) ||
                const DeepCollectionEquality().equals(
                  other.category,
                  category,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(image) ^
      const DeepCollectionEquality().hash(projectUrl) ^
      const DeepCollectionEquality().hash($client) ^
      const DeepCollectionEquality().hash(startDate) ^
      const DeepCollectionEquality().hash(endDate) ^
      const DeepCollectionEquality().hash(jobScope) ^
      const DeepCollectionEquality().hash(isActive) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(category) ^
      runtimeType.hashCode;
}

extension $PortfolioResponseDTOExtension on PortfolioResponseDTO {
  PortfolioResponseDTO copyWith({
    String? title,
    String? description,
    List<String>? image,
    String? projectUrl,
    String? $client,
    String? startDate,
    String? endDate,
    String? jobScope,
    bool? isActive,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    PortfolioCategoryResponseDTO? category,
  }) {
    return PortfolioResponseDTO(
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      projectUrl: projectUrl ?? this.projectUrl,
      $client: $client ?? this.$client,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      jobScope: jobScope ?? this.jobScope,
      isActive: isActive ?? this.isActive,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      category: category ?? this.category,
    );
  }

  PortfolioResponseDTO copyWithWrapped({
    Wrapped<String>? title,
    Wrapped<String>? description,
    Wrapped<List<String>>? image,
    Wrapped<String?>? projectUrl,
    Wrapped<String?>? $client,
    Wrapped<String?>? startDate,
    Wrapped<String?>? endDate,
    Wrapped<String?>? jobScope,
    Wrapped<bool?>? isActive,
    Wrapped<String>? id,
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
    Wrapped<PortfolioCategoryResponseDTO?>? category,
  }) {
    return PortfolioResponseDTO(
      title: (title != null ? title.value : this.title),
      description: (description != null ? description.value : this.description),
      image: (image != null ? image.value : this.image),
      projectUrl: (projectUrl != null ? projectUrl.value : this.projectUrl),
      $client: ($client != null ? $client.value : this.$client),
      startDate: (startDate != null ? startDate.value : this.startDate),
      endDate: (endDate != null ? endDate.value : this.endDate),
      jobScope: (jobScope != null ? jobScope.value : this.jobScope),
      isActive: (isActive != null ? isActive.value : this.isActive),
      id: (id != null ? id.value : this.id),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      category: (category != null ? category.value : this.category),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CreatePortfolioResponseDTO {
  const CreatePortfolioResponseDTO({required this.message, required this.data});

  factory CreatePortfolioResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$CreatePortfolioResponseDTOFromJson(json);

  static const toJsonFactory = _$CreatePortfolioResponseDTOToJson;
  Map<String, dynamic> toJson() => _$CreatePortfolioResponseDTOToJson(this);

  @JsonKey(name: 'message')
  final String message;
  @JsonKey(name: 'data')
  final PortfolioResponseDTO data;
  static const fromJsonFactory = _$CreatePortfolioResponseDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CreatePortfolioResponseDTO &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(
                  other.message,
                  message,
                )) &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(message) ^
      const DeepCollectionEquality().hash(data) ^
      runtimeType.hashCode;
}

extension $CreatePortfolioResponseDTOExtension on CreatePortfolioResponseDTO {
  CreatePortfolioResponseDTO copyWith({
    String? message,
    PortfolioResponseDTO? data,
  }) {
    return CreatePortfolioResponseDTO(
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  CreatePortfolioResponseDTO copyWithWrapped({
    Wrapped<String>? message,
    Wrapped<PortfolioResponseDTO>? data,
  }) {
    return CreatePortfolioResponseDTO(
      message: (message != null ? message.value : this.message),
      data: (data != null ? data.value : this.data),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class GetAllPortfoliosResponseDTO {
  const GetAllPortfoliosResponseDTO({required this.data});

  factory GetAllPortfoliosResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllPortfoliosResponseDTOFromJson(json);

  static const toJsonFactory = _$GetAllPortfoliosResponseDTOToJson;
  Map<String, dynamic> toJson() => _$GetAllPortfoliosResponseDTOToJson(this);

  @JsonKey(name: 'data', defaultValue: <PortfolioResponseDTO>[])
  final List<PortfolioResponseDTO> data;
  static const fromJsonFactory = _$GetAllPortfoliosResponseDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is GetAllPortfoliosResponseDTO &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(data) ^ runtimeType.hashCode;
}

extension $GetAllPortfoliosResponseDTOExtension on GetAllPortfoliosResponseDTO {
  GetAllPortfoliosResponseDTO copyWith({List<PortfolioResponseDTO>? data}) {
    return GetAllPortfoliosResponseDTO(data: data ?? this.data);
  }

  GetAllPortfoliosResponseDTO copyWithWrapped({
    Wrapped<List<PortfolioResponseDTO>>? data,
  }) {
    return GetAllPortfoliosResponseDTO(
      data: (data != null ? data.value : this.data),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class GetPortfolioDetailResponseDTO {
  const GetPortfolioDetailResponseDTO({required this.data});

  factory GetPortfolioDetailResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$GetPortfolioDetailResponseDTOFromJson(json);

  static const toJsonFactory = _$GetPortfolioDetailResponseDTOToJson;
  Map<String, dynamic> toJson() => _$GetPortfolioDetailResponseDTOToJson(this);

  @JsonKey(name: 'data')
  final PortfolioResponseDTO data;
  static const fromJsonFactory = _$GetPortfolioDetailResponseDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is GetPortfolioDetailResponseDTO &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(data) ^ runtimeType.hashCode;
}

extension $GetPortfolioDetailResponseDTOExtension
    on GetPortfolioDetailResponseDTO {
  GetPortfolioDetailResponseDTO copyWith({PortfolioResponseDTO? data}) {
    return GetPortfolioDetailResponseDTO(data: data ?? this.data);
  }

  GetPortfolioDetailResponseDTO copyWithWrapped({
    Wrapped<PortfolioResponseDTO>? data,
  }) {
    return GetPortfolioDetailResponseDTO(
      data: (data != null ? data.value : this.data),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UpdatePortfolioResponseDTO {
  const UpdatePortfolioResponseDTO({required this.message, required this.data});

  factory UpdatePortfolioResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$UpdatePortfolioResponseDTOFromJson(json);

  static const toJsonFactory = _$UpdatePortfolioResponseDTOToJson;
  Map<String, dynamic> toJson() => _$UpdatePortfolioResponseDTOToJson(this);

  @JsonKey(name: 'message')
  final String message;
  @JsonKey(name: 'data')
  final PortfolioResponseDTO data;
  static const fromJsonFactory = _$UpdatePortfolioResponseDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UpdatePortfolioResponseDTO &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(
                  other.message,
                  message,
                )) &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(message) ^
      const DeepCollectionEquality().hash(data) ^
      runtimeType.hashCode;
}

extension $UpdatePortfolioResponseDTOExtension on UpdatePortfolioResponseDTO {
  UpdatePortfolioResponseDTO copyWith({
    String? message,
    PortfolioResponseDTO? data,
  }) {
    return UpdatePortfolioResponseDTO(
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  UpdatePortfolioResponseDTO copyWithWrapped({
    Wrapped<String>? message,
    Wrapped<PortfolioResponseDTO>? data,
  }) {
    return UpdatePortfolioResponseDTO(
      message: (message != null ? message.value : this.message),
      data: (data != null ? data.value : this.data),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CreatePortfolioCategoryDTO {
  const CreatePortfolioCategoryDTO({
    required this.name,
    this.description,
    this.isActive,
  });

  factory CreatePortfolioCategoryDTO.fromJson(Map<String, dynamic> json) =>
      _$CreatePortfolioCategoryDTOFromJson(json);

  static const toJsonFactory = _$CreatePortfolioCategoryDTOToJson;
  Map<String, dynamic> toJson() => _$CreatePortfolioCategoryDTOToJson(this);

  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'isActive')
  final bool? isActive;
  static const fromJsonFactory = _$CreatePortfolioCategoryDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CreatePortfolioCategoryDTO &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.isActive, isActive) ||
                const DeepCollectionEquality().equals(
                  other.isActive,
                  isActive,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(isActive) ^
      runtimeType.hashCode;
}

extension $CreatePortfolioCategoryDTOExtension on CreatePortfolioCategoryDTO {
  CreatePortfolioCategoryDTO copyWith({
    String? name,
    String? description,
    bool? isActive,
  }) {
    return CreatePortfolioCategoryDTO(
      name: name ?? this.name,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
    );
  }

  CreatePortfolioCategoryDTO copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String?>? description,
    Wrapped<bool?>? isActive,
  }) {
    return CreatePortfolioCategoryDTO(
      name: (name != null ? name.value : this.name),
      description: (description != null ? description.value : this.description),
      isActive: (isActive != null ? isActive.value : this.isActive),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class GetAllPortfolioCategoriesResponseDTO {
  const GetAllPortfolioCategoriesResponseDTO({required this.data});

  factory GetAllPortfolioCategoriesResponseDTO.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$GetAllPortfolioCategoriesResponseDTOFromJson(json);

  static const toJsonFactory = _$GetAllPortfolioCategoriesResponseDTOToJson;
  Map<String, dynamic> toJson() =>
      _$GetAllPortfolioCategoriesResponseDTOToJson(this);

  @JsonKey(name: 'data', defaultValue: <PortfolioCategoryResponseDTO>[])
  final List<PortfolioCategoryResponseDTO> data;
  static const fromJsonFactory = _$GetAllPortfolioCategoriesResponseDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is GetAllPortfolioCategoriesResponseDTO &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(data) ^ runtimeType.hashCode;
}

extension $GetAllPortfolioCategoriesResponseDTOExtension
    on GetAllPortfolioCategoriesResponseDTO {
  GetAllPortfolioCategoriesResponseDTO copyWith({
    List<PortfolioCategoryResponseDTO>? data,
  }) {
    return GetAllPortfolioCategoriesResponseDTO(data: data ?? this.data);
  }

  GetAllPortfolioCategoriesResponseDTO copyWithWrapped({
    Wrapped<List<PortfolioCategoryResponseDTO>>? data,
  }) {
    return GetAllPortfolioCategoriesResponseDTO(
      data: (data != null ? data.value : this.data),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CreateCustomerFeedbackDTO {
  const CreateCustomerFeedbackDTO({
    required this.customerName,
    required this.email,
    this.phone,
    required this.message,
    this.rating,
    this.subject,
  });

  factory CreateCustomerFeedbackDTO.fromJson(Map<String, dynamic> json) =>
      _$CreateCustomerFeedbackDTOFromJson(json);

  static const toJsonFactory = _$CreateCustomerFeedbackDTOToJson;
  Map<String, dynamic> toJson() => _$CreateCustomerFeedbackDTOToJson(this);

  @JsonKey(name: 'customerName')
  final String customerName;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'message')
  final String message;
  @JsonKey(name: 'rating')
  final double? rating;
  @JsonKey(name: 'subject')
  final String? subject;
  static const fromJsonFactory = _$CreateCustomerFeedbackDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CreateCustomerFeedbackDTO &&
            (identical(other.customerName, customerName) ||
                const DeepCollectionEquality().equals(
                  other.customerName,
                  customerName,
                )) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.phone, phone) ||
                const DeepCollectionEquality().equals(other.phone, phone)) &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(
                  other.message,
                  message,
                )) &&
            (identical(other.rating, rating) ||
                const DeepCollectionEquality().equals(other.rating, rating)) &&
            (identical(other.subject, subject) ||
                const DeepCollectionEquality().equals(other.subject, subject)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(customerName) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(phone) ^
      const DeepCollectionEquality().hash(message) ^
      const DeepCollectionEquality().hash(rating) ^
      const DeepCollectionEquality().hash(subject) ^
      runtimeType.hashCode;
}

extension $CreateCustomerFeedbackDTOExtension on CreateCustomerFeedbackDTO {
  CreateCustomerFeedbackDTO copyWith({
    String? customerName,
    String? email,
    String? phone,
    String? message,
    double? rating,
    String? subject,
  }) {
    return CreateCustomerFeedbackDTO(
      customerName: customerName ?? this.customerName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      message: message ?? this.message,
      rating: rating ?? this.rating,
      subject: subject ?? this.subject,
    );
  }

  CreateCustomerFeedbackDTO copyWithWrapped({
    Wrapped<String>? customerName,
    Wrapped<String>? email,
    Wrapped<String?>? phone,
    Wrapped<String>? message,
    Wrapped<double?>? rating,
    Wrapped<String?>? subject,
  }) {
    return CreateCustomerFeedbackDTO(
      customerName:
          (customerName != null ? customerName.value : this.customerName),
      email: (email != null ? email.value : this.email),
      phone: (phone != null ? phone.value : this.phone),
      message: (message != null ? message.value : this.message),
      rating: (rating != null ? rating.value : this.rating),
      subject: (subject != null ? subject.value : this.subject),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CustomerFeedbackResponseDTO {
  const CustomerFeedbackResponseDTO({
    required this.customerName,
    required this.email,
    this.phone,
    required this.message,
    this.rating,
    this.subject,
    required this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory CustomerFeedbackResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$CustomerFeedbackResponseDTOFromJson(json);

  static const toJsonFactory = _$CustomerFeedbackResponseDTOToJson;
  Map<String, dynamic> toJson() => _$CustomerFeedbackResponseDTOToJson(this);

  @JsonKey(name: 'customerName')
  final String customerName;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'message')
  final String message;
  @JsonKey(name: 'rating')
  final double? rating;
  @JsonKey(name: 'subject')
  final String? subject;
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;
  static const fromJsonFactory = _$CustomerFeedbackResponseDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CustomerFeedbackResponseDTO &&
            (identical(other.customerName, customerName) ||
                const DeepCollectionEquality().equals(
                  other.customerName,
                  customerName,
                )) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.phone, phone) ||
                const DeepCollectionEquality().equals(other.phone, phone)) &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(
                  other.message,
                  message,
                )) &&
            (identical(other.rating, rating) ||
                const DeepCollectionEquality().equals(other.rating, rating)) &&
            (identical(other.subject, subject) ||
                const DeepCollectionEquality().equals(
                  other.subject,
                  subject,
                )) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(
                  other.createdAt,
                  createdAt,
                )) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality().equals(
                  other.updatedAt,
                  updatedAt,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(customerName) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(phone) ^
      const DeepCollectionEquality().hash(message) ^
      const DeepCollectionEquality().hash(rating) ^
      const DeepCollectionEquality().hash(subject) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      runtimeType.hashCode;
}

extension $CustomerFeedbackResponseDTOExtension on CustomerFeedbackResponseDTO {
  CustomerFeedbackResponseDTO copyWith({
    String? customerName,
    String? email,
    String? phone,
    String? message,
    double? rating,
    String? subject,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CustomerFeedbackResponseDTO(
      customerName: customerName ?? this.customerName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      message: message ?? this.message,
      rating: rating ?? this.rating,
      subject: subject ?? this.subject,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  CustomerFeedbackResponseDTO copyWithWrapped({
    Wrapped<String>? customerName,
    Wrapped<String>? email,
    Wrapped<String?>? phone,
    Wrapped<String>? message,
    Wrapped<double?>? rating,
    Wrapped<String?>? subject,
    Wrapped<String>? id,
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
  }) {
    return CustomerFeedbackResponseDTO(
      customerName:
          (customerName != null ? customerName.value : this.customerName),
      email: (email != null ? email.value : this.email),
      phone: (phone != null ? phone.value : this.phone),
      message: (message != null ? message.value : this.message),
      rating: (rating != null ? rating.value : this.rating),
      subject: (subject != null ? subject.value : this.subject),
      id: (id != null ? id.value : this.id),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class GetAllCustomerFeedbackResponseDTO {
  const GetAllCustomerFeedbackResponseDTO({required this.data});

  factory GetAllCustomerFeedbackResponseDTO.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$GetAllCustomerFeedbackResponseDTOFromJson(json);

  static const toJsonFactory = _$GetAllCustomerFeedbackResponseDTOToJson;
  Map<String, dynamic> toJson() =>
      _$GetAllCustomerFeedbackResponseDTOToJson(this);

  @JsonKey(name: 'data', defaultValue: <CustomerFeedbackResponseDTO>[])
  final List<CustomerFeedbackResponseDTO> data;
  static const fromJsonFactory = _$GetAllCustomerFeedbackResponseDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is GetAllCustomerFeedbackResponseDTO &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(data) ^ runtimeType.hashCode;
}

extension $GetAllCustomerFeedbackResponseDTOExtension
    on GetAllCustomerFeedbackResponseDTO {
  GetAllCustomerFeedbackResponseDTO copyWith({
    List<CustomerFeedbackResponseDTO>? data,
  }) {
    return GetAllCustomerFeedbackResponseDTO(data: data ?? this.data);
  }

  GetAllCustomerFeedbackResponseDTO copyWithWrapped({
    Wrapped<List<CustomerFeedbackResponseDTO>>? data,
  }) {
    return GetAllCustomerFeedbackResponseDTO(
      data: (data != null ? data.value : this.data),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UpdateFeedbackStatusDTO {
  const UpdateFeedbackStatusDTO({this.status});

  factory UpdateFeedbackStatusDTO.fromJson(Map<String, dynamic> json) =>
      _$UpdateFeedbackStatusDTOFromJson(json);

  static const toJsonFactory = _$UpdateFeedbackStatusDTOToJson;
  Map<String, dynamic> toJson() => _$UpdateFeedbackStatusDTOToJson(this);

  @JsonKey(
    name: 'status',
    toJson: updateFeedbackStatusDTOStatusNullableToJson,
    fromJson: updateFeedbackStatusDTOStatusNullableFromJson,
  )
  final enums.UpdateFeedbackStatusDTOStatus? status;
  static const fromJsonFactory = _$UpdateFeedbackStatusDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UpdateFeedbackStatusDTO &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(status) ^ runtimeType.hashCode;
}

extension $UpdateFeedbackStatusDTOExtension on UpdateFeedbackStatusDTO {
  UpdateFeedbackStatusDTO copyWith({
    enums.UpdateFeedbackStatusDTOStatus? status,
  }) {
    return UpdateFeedbackStatusDTO(status: status ?? this.status);
  }

  UpdateFeedbackStatusDTO copyWithWrapped({
    Wrapped<enums.UpdateFeedbackStatusDTOStatus?>? status,
  }) {
    return UpdateFeedbackStatusDTO(
      status: (status != null ? status.value : this.status),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TelegramIntentDTO {
  const TelegramIntentDTO({
    required this.productId,
    required this.productName,
    required this.price,
    required this.currency,
    required this.sourceUrl,
    this.userId,
  });

  factory TelegramIntentDTO.fromJson(Map<String, dynamic> json) =>
      _$TelegramIntentDTOFromJson(json);

  static const toJsonFactory = _$TelegramIntentDTOToJson;
  Map<String, dynamic> toJson() => _$TelegramIntentDTOToJson(this);

  @JsonKey(name: 'product_id')
  final String productId;
  @JsonKey(name: 'product_name')
  final String productName;
  @JsonKey(name: 'price')
  final String price;
  @JsonKey(name: 'currency')
  final String currency;
  @JsonKey(name: 'source_url')
  final String sourceUrl;
  @JsonKey(name: 'user_id')
  final String? userId;
  static const fromJsonFactory = _$TelegramIntentDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TelegramIntentDTO &&
            (identical(other.productId, productId) ||
                const DeepCollectionEquality().equals(
                  other.productId,
                  productId,
                )) &&
            (identical(other.productName, productName) ||
                const DeepCollectionEquality().equals(
                  other.productName,
                  productName,
                )) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.currency, currency) ||
                const DeepCollectionEquality().equals(
                  other.currency,
                  currency,
                )) &&
            (identical(other.sourceUrl, sourceUrl) ||
                const DeepCollectionEquality().equals(
                  other.sourceUrl,
                  sourceUrl,
                )) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(productId) ^
      const DeepCollectionEquality().hash(productName) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(currency) ^
      const DeepCollectionEquality().hash(sourceUrl) ^
      const DeepCollectionEquality().hash(userId) ^
      runtimeType.hashCode;
}

extension $TelegramIntentDTOExtension on TelegramIntentDTO {
  TelegramIntentDTO copyWith({
    String? productId,
    String? productName,
    String? price,
    String? currency,
    String? sourceUrl,
    String? userId,
  }) {
    return TelegramIntentDTO(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      userId: userId ?? this.userId,
    );
  }

  TelegramIntentDTO copyWithWrapped({
    Wrapped<String>? productId,
    Wrapped<String>? productName,
    Wrapped<String>? price,
    Wrapped<String>? currency,
    Wrapped<String>? sourceUrl,
    Wrapped<String?>? userId,
  }) {
    return TelegramIntentDTO(
      productId: (productId != null ? productId.value : this.productId),
      productName: (productName != null ? productName.value : this.productName),
      price: (price != null ? price.value : this.price),
      currency: (currency != null ? currency.value : this.currency),
      sourceUrl: (sourceUrl != null ? sourceUrl.value : this.sourceUrl),
      userId: (userId != null ? userId.value : this.userId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TelegramIntentResponseDTO {
  const TelegramIntentResponseDTO({
    required this.status,
    required this.leadId,
    required this.config,
  });

  factory TelegramIntentResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$TelegramIntentResponseDTOFromJson(json);

  static const toJsonFactory = _$TelegramIntentResponseDTOToJson;
  Map<String, dynamic> toJson() => _$TelegramIntentResponseDTOToJson(this);

  @JsonKey(name: 'status')
  final String status;
  @JsonKey(name: 'lead_id')
  final String leadId;
  @JsonKey(name: 'config')
  final Object config;
  static const fromJsonFactory = _$TelegramIntentResponseDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TelegramIntentResponseDTO &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.leadId, leadId) ||
                const DeepCollectionEquality().equals(other.leadId, leadId)) &&
            (identical(other.config, config) ||
                const DeepCollectionEquality().equals(other.config, config)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(leadId) ^
      const DeepCollectionEquality().hash(config) ^
      runtimeType.hashCode;
}

extension $TelegramIntentResponseDTOExtension on TelegramIntentResponseDTO {
  TelegramIntentResponseDTO copyWith({
    String? status,
    String? leadId,
    Object? config,
  }) {
    return TelegramIntentResponseDTO(
      status: status ?? this.status,
      leadId: leadId ?? this.leadId,
      config: config ?? this.config,
    );
  }

  TelegramIntentResponseDTO copyWithWrapped({
    Wrapped<String>? status,
    Wrapped<String>? leadId,
    Wrapped<Object>? config,
  }) {
    return TelegramIntentResponseDTO(
      status: (status != null ? status.value : this.status),
      leadId: (leadId != null ? leadId.value : this.leadId),
      config: (config != null ? config.value : this.config),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ContactUsDTO {
  const ContactUsDTO({
    required this.name,
    required this.phoneNumber,
    required this.email,
    this.serviceInterest,
    this.message,
  });

  factory ContactUsDTO.fromJson(Map<String, dynamic> json) =>
      _$ContactUsDTOFromJson(json);

  static const toJsonFactory = _$ContactUsDTOToJson;
  Map<String, dynamic> toJson() => _$ContactUsDTOToJson(this);

  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'phoneNumber')
  final String phoneNumber;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'serviceInterest')
  final String? serviceInterest;
  @JsonKey(name: 'message')
  final String? message;
  static const fromJsonFactory = _$ContactUsDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ContactUsDTO &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality().equals(
                  other.phoneNumber,
                  phoneNumber,
                )) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.serviceInterest, serviceInterest) ||
                const DeepCollectionEquality().equals(
                  other.serviceInterest,
                  serviceInterest,
                )) &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(phoneNumber) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(serviceInterest) ^
      const DeepCollectionEquality().hash(message) ^
      runtimeType.hashCode;
}

extension $ContactUsDTOExtension on ContactUsDTO {
  ContactUsDTO copyWith({
    String? name,
    String? phoneNumber,
    String? email,
    String? serviceInterest,
    String? message,
  }) {
    return ContactUsDTO(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      serviceInterest: serviceInterest ?? this.serviceInterest,
      message: message ?? this.message,
    );
  }

  ContactUsDTO copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? phoneNumber,
    Wrapped<String>? email,
    Wrapped<String?>? serviceInterest,
    Wrapped<String?>? message,
  }) {
    return ContactUsDTO(
      name: (name != null ? name.value : this.name),
      phoneNumber: (phoneNumber != null ? phoneNumber.value : this.phoneNumber),
      email: (email != null ? email.value : this.email),
      serviceInterest: (serviceInterest != null
          ? serviceInterest.value
          : this.serviceInterest),
      message: (message != null ? message.value : this.message),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class LeadResponseDTO {
  const LeadResponseDTO({
    required this.productId,
    required this.productName,
    required this.price,
    required this.currency,
    required this.sourceUrl,
    this.userId,
    required this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory LeadResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$LeadResponseDTOFromJson(json);

  static const toJsonFactory = _$LeadResponseDTOToJson;
  Map<String, dynamic> toJson() => _$LeadResponseDTOToJson(this);

  @JsonKey(name: 'product_id')
  final String productId;
  @JsonKey(name: 'product_name')
  final String productName;
  @JsonKey(name: 'price')
  final String price;
  @JsonKey(name: 'currency')
  final String currency;
  @JsonKey(name: 'source_url')
  final String sourceUrl;
  @JsonKey(name: 'user_id')
  final String? userId;
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;
  static const fromJsonFactory = _$LeadResponseDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is LeadResponseDTO &&
            (identical(other.productId, productId) ||
                const DeepCollectionEquality().equals(
                  other.productId,
                  productId,
                )) &&
            (identical(other.productName, productName) ||
                const DeepCollectionEquality().equals(
                  other.productName,
                  productName,
                )) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.currency, currency) ||
                const DeepCollectionEquality().equals(
                  other.currency,
                  currency,
                )) &&
            (identical(other.sourceUrl, sourceUrl) ||
                const DeepCollectionEquality().equals(
                  other.sourceUrl,
                  sourceUrl,
                )) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(
                  other.createdAt,
                  createdAt,
                )) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality().equals(
                  other.updatedAt,
                  updatedAt,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(productId) ^
      const DeepCollectionEquality().hash(productName) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(currency) ^
      const DeepCollectionEquality().hash(sourceUrl) ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      runtimeType.hashCode;
}

extension $LeadResponseDTOExtension on LeadResponseDTO {
  LeadResponseDTO copyWith({
    String? productId,
    String? productName,
    String? price,
    String? currency,
    String? sourceUrl,
    String? userId,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return LeadResponseDTO(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      userId: userId ?? this.userId,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  LeadResponseDTO copyWithWrapped({
    Wrapped<String>? productId,
    Wrapped<String>? productName,
    Wrapped<String>? price,
    Wrapped<String>? currency,
    Wrapped<String>? sourceUrl,
    Wrapped<String?>? userId,
    Wrapped<String>? id,
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
  }) {
    return LeadResponseDTO(
      productId: (productId != null ? productId.value : this.productId),
      productName: (productName != null ? productName.value : this.productName),
      price: (price != null ? price.value : this.price),
      currency: (currency != null ? currency.value : this.currency),
      sourceUrl: (sourceUrl != null ? sourceUrl.value : this.sourceUrl),
      userId: (userId != null ? userId.value : this.userId),
      id: (id != null ? id.value : this.id),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class GetAllLeadsResponseDTO {
  const GetAllLeadsResponseDTO({required this.data});

  factory GetAllLeadsResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllLeadsResponseDTOFromJson(json);

  static const toJsonFactory = _$GetAllLeadsResponseDTOToJson;
  Map<String, dynamic> toJson() => _$GetAllLeadsResponseDTOToJson(this);

  @JsonKey(name: 'data', defaultValue: <LeadResponseDTO>[])
  final List<LeadResponseDTO> data;
  static const fromJsonFactory = _$GetAllLeadsResponseDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is GetAllLeadsResponseDTO &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(data) ^ runtimeType.hashCode;
}

extension $GetAllLeadsResponseDTOExtension on GetAllLeadsResponseDTO {
  GetAllLeadsResponseDTO copyWith({List<LeadResponseDTO>? data}) {
    return GetAllLeadsResponseDTO(data: data ?? this.data);
  }

  GetAllLeadsResponseDTO copyWithWrapped({
    Wrapped<List<LeadResponseDTO>>? data,
  }) {
    return GetAllLeadsResponseDTO(
      data: (data != null ? data.value : this.data),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CreateClientDTO {
  const CreateClientDTO({
    required this.name,
    required this.company,
    required this.email,
    this.phone,
    this.totalProjects,
    this.status,
  });

  factory CreateClientDTO.fromJson(Map<String, dynamic> json) =>
      _$CreateClientDTOFromJson(json);

  static const toJsonFactory = _$CreateClientDTOToJson;
  Map<String, dynamic> toJson() => _$CreateClientDTOToJson(this);

  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'company')
  final String company;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'totalProjects')
  final double? totalProjects;
  @JsonKey(
    name: 'status',
    toJson: createClientDTOStatusNullableToJson,
    fromJson: createClientDTOStatusStatusNullableFromJson,
  )
  final enums.CreateClientDTOStatus? status;
  static enums.CreateClientDTOStatus?
      createClientDTOStatusStatusNullableFromJson(Object? value) =>
          createClientDTOStatusNullableFromJson(
            value,
            enums.CreateClientDTOStatus.prospect,
          );

  static const fromJsonFactory = _$CreateClientDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CreateClientDTO &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.company, company) ||
                const DeepCollectionEquality().equals(
                  other.company,
                  company,
                )) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.phone, phone) ||
                const DeepCollectionEquality().equals(other.phone, phone)) &&
            (identical(other.totalProjects, totalProjects) ||
                const DeepCollectionEquality().equals(
                  other.totalProjects,
                  totalProjects,
                )) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(company) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(phone) ^
      const DeepCollectionEquality().hash(totalProjects) ^
      const DeepCollectionEquality().hash(status) ^
      runtimeType.hashCode;
}

extension $CreateClientDTOExtension on CreateClientDTO {
  CreateClientDTO copyWith({
    String? name,
    String? company,
    String? email,
    String? phone,
    double? totalProjects,
    enums.CreateClientDTOStatus? status,
  }) {
    return CreateClientDTO(
      name: name ?? this.name,
      company: company ?? this.company,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      totalProjects: totalProjects ?? this.totalProjects,
      status: status ?? this.status,
    );
  }

  CreateClientDTO copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? company,
    Wrapped<String>? email,
    Wrapped<String?>? phone,
    Wrapped<double?>? totalProjects,
    Wrapped<enums.CreateClientDTOStatus?>? status,
  }) {
    return CreateClientDTO(
      name: (name != null ? name.value : this.name),
      company: (company != null ? company.value : this.company),
      email: (email != null ? email.value : this.email),
      phone: (phone != null ? phone.value : this.phone),
      totalProjects:
          (totalProjects != null ? totalProjects.value : this.totalProjects),
      status: (status != null ? status.value : this.status),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UpdateClientDTO {
  const UpdateClientDTO({
    this.name,
    this.company,
    this.email,
    this.phone,
    this.totalProjects,
    this.status,
  });

  factory UpdateClientDTO.fromJson(Map<String, dynamic> json) =>
      _$UpdateClientDTOFromJson(json);

  static const toJsonFactory = _$UpdateClientDTOToJson;
  Map<String, dynamic> toJson() => _$UpdateClientDTOToJson(this);

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'company')
  final String? company;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'totalProjects')
  final double? totalProjects;
  @JsonKey(
    name: 'status',
    toJson: updateClientDTOStatusNullableToJson,
    fromJson: updateClientDTOStatusStatusNullableFromJson,
  )
  final enums.UpdateClientDTOStatus? status;
  static enums.UpdateClientDTOStatus?
      updateClientDTOStatusStatusNullableFromJson(Object? value) =>
          updateClientDTOStatusNullableFromJson(
            value,
            enums.UpdateClientDTOStatus.prospect,
          );

  static const fromJsonFactory = _$UpdateClientDTOFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UpdateClientDTO &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.company, company) ||
                const DeepCollectionEquality().equals(
                  other.company,
                  company,
                )) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.phone, phone) ||
                const DeepCollectionEquality().equals(other.phone, phone)) &&
            (identical(other.totalProjects, totalProjects) ||
                const DeepCollectionEquality().equals(
                  other.totalProjects,
                  totalProjects,
                )) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(company) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(phone) ^
      const DeepCollectionEquality().hash(totalProjects) ^
      const DeepCollectionEquality().hash(status) ^
      runtimeType.hashCode;
}

extension $UpdateClientDTOExtension on UpdateClientDTO {
  UpdateClientDTO copyWith({
    String? name,
    String? company,
    String? email,
    String? phone,
    double? totalProjects,
    enums.UpdateClientDTOStatus? status,
  }) {
    return UpdateClientDTO(
      name: name ?? this.name,
      company: company ?? this.company,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      totalProjects: totalProjects ?? this.totalProjects,
      status: status ?? this.status,
    );
  }

  UpdateClientDTO copyWithWrapped({
    Wrapped<String?>? name,
    Wrapped<String?>? company,
    Wrapped<String?>? email,
    Wrapped<String?>? phone,
    Wrapped<double?>? totalProjects,
    Wrapped<enums.UpdateClientDTOStatus?>? status,
  }) {
    return UpdateClientDTO(
      name: (name != null ? name.value : this.name),
      company: (company != null ? company.value : this.company),
      email: (email != null ? email.value : this.email),
      phone: (phone != null ? phone.value : this.phone),
      totalProjects:
          (totalProjects != null ? totalProjects.value : this.totalProjects),
      status: (status != null ? status.value : this.status),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ImagesUploadPost$RequestBody {
  const ImagesUploadPost$RequestBody({required this.file});

  factory ImagesUploadPost$RequestBody.fromJson(Map<String, dynamic> json) =>
      _$ImagesUploadPost$RequestBodyFromJson(json);

  static const toJsonFactory = _$ImagesUploadPost$RequestBodyToJson;
  Map<String, dynamic> toJson() => _$ImagesUploadPost$RequestBodyToJson(this);

  @JsonKey(name: 'file')
  final String file;
  static const fromJsonFactory = _$ImagesUploadPost$RequestBodyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ImagesUploadPost$RequestBody &&
            (identical(other.file, file) ||
                const DeepCollectionEquality().equals(other.file, file)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(file) ^ runtimeType.hashCode;
}

extension $ImagesUploadPost$RequestBodyExtension
    on ImagesUploadPost$RequestBody {
  ImagesUploadPost$RequestBody copyWith({String? file}) {
    return ImagesUploadPost$RequestBody(file: file ?? this.file);
  }

  ImagesUploadPost$RequestBody copyWithWrapped({Wrapped<String>? file}) {
    return ImagesUploadPost$RequestBody(
      file: (file != null ? file.value : this.file),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CreateProductDTO$VariantImages$Item {
  const CreateProductDTO$VariantImages$Item({
    this.image,
    this.color,
    this.material,
  });

  factory CreateProductDTO$VariantImages$Item.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$CreateProductDTO$VariantImages$ItemFromJson(json);

  static const toJsonFactory = _$CreateProductDTO$VariantImages$ItemToJson;
  Map<String, dynamic> toJson() =>
      _$CreateProductDTO$VariantImages$ItemToJson(this);

  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'color')
  final String? color;
  @JsonKey(name: 'material')
  final String? material;
  static const fromJsonFactory = _$CreateProductDTO$VariantImages$ItemFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CreateProductDTO$VariantImages$Item &&
            (identical(other.image, image) ||
                const DeepCollectionEquality().equals(other.image, image)) &&
            (identical(other.color, color) ||
                const DeepCollectionEquality().equals(other.color, color)) &&
            (identical(other.material, material) ||
                const DeepCollectionEquality().equals(
                  other.material,
                  material,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(image) ^
      const DeepCollectionEquality().hash(color) ^
      const DeepCollectionEquality().hash(material) ^
      runtimeType.hashCode;
}

extension $CreateProductDTO$VariantImages$ItemExtension
    on CreateProductDTO$VariantImages$Item {
  CreateProductDTO$VariantImages$Item copyWith({
    String? image,
    String? color,
    String? material,
  }) {
    return CreateProductDTO$VariantImages$Item(
      image: image ?? this.image,
      color: color ?? this.color,
      material: material ?? this.material,
    );
  }

  CreateProductDTO$VariantImages$Item copyWithWrapped({
    Wrapped<String?>? image,
    Wrapped<String?>? color,
    Wrapped<String?>? material,
  }) {
    return CreateProductDTO$VariantImages$Item(
      image: (image != null ? image.value : this.image),
      color: (color != null ? color.value : this.color),
      material: (material != null ? material.value : this.material),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ProductResponseDTO$VariantImages$Item {
  const ProductResponseDTO$VariantImages$Item({
    this.image,
    this.color,
    this.material,
  });

  factory ProductResponseDTO$VariantImages$Item.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ProductResponseDTO$VariantImages$ItemFromJson(json);

  static const toJsonFactory = _$ProductResponseDTO$VariantImages$ItemToJson;
  Map<String, dynamic> toJson() =>
      _$ProductResponseDTO$VariantImages$ItemToJson(this);

  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'color')
  final String? color;
  @JsonKey(name: 'material')
  final String? material;
  static const fromJsonFactory =
      _$ProductResponseDTO$VariantImages$ItemFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ProductResponseDTO$VariantImages$Item &&
            (identical(other.image, image) ||
                const DeepCollectionEquality().equals(other.image, image)) &&
            (identical(other.color, color) ||
                const DeepCollectionEquality().equals(other.color, color)) &&
            (identical(other.material, material) ||
                const DeepCollectionEquality().equals(
                  other.material,
                  material,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(image) ^
      const DeepCollectionEquality().hash(color) ^
      const DeepCollectionEquality().hash(material) ^
      runtimeType.hashCode;
}

extension $ProductResponseDTO$VariantImages$ItemExtension
    on ProductResponseDTO$VariantImages$Item {
  ProductResponseDTO$VariantImages$Item copyWith({
    String? image,
    String? color,
    String? material,
  }) {
    return ProductResponseDTO$VariantImages$Item(
      image: image ?? this.image,
      color: color ?? this.color,
      material: material ?? this.material,
    );
  }

  ProductResponseDTO$VariantImages$Item copyWithWrapped({
    Wrapped<String?>? image,
    Wrapped<String?>? color,
    Wrapped<String?>? material,
  }) {
    return ProductResponseDTO$VariantImages$Item(
      image: (image != null ? image.value : this.image),
      color: (color != null ? color.value : this.color),
      material: (material != null ? material.value : this.material),
    );
  }
}

String? createUserDTORoleNullableToJson(
  enums.CreateUserDTORole? createUserDTORole,
) {
  return createUserDTORole?.value;
}

String? createUserDTORoleToJson(enums.CreateUserDTORole createUserDTORole) {
  return createUserDTORole.value;
}

enums.CreateUserDTORole createUserDTORoleFromJson(
  Object? createUserDTORole, [
  enums.CreateUserDTORole? defaultValue,
]) {
  return enums.CreateUserDTORole.values.firstWhereOrNull(
        (e) => e.value == createUserDTORole,
      ) ??
      defaultValue ??
      enums.CreateUserDTORole.swaggerGeneratedUnknown;
}

enums.CreateUserDTORole? createUserDTORoleNullableFromJson(
  Object? createUserDTORole, [
  enums.CreateUserDTORole? defaultValue,
]) {
  if (createUserDTORole == null) {
    return null;
  }
  return enums.CreateUserDTORole.values.firstWhereOrNull(
        (e) => e.value == createUserDTORole,
      ) ??
      defaultValue;
}

String createUserDTORoleExplodedListToJson(
  List<enums.CreateUserDTORole>? createUserDTORole,
) {
  return createUserDTORole?.map((e) => e.value!).join(',') ?? '';
}

List<String> createUserDTORoleListToJson(
  List<enums.CreateUserDTORole>? createUserDTORole,
) {
  if (createUserDTORole == null) {
    return [];
  }

  return createUserDTORole.map((e) => e.value!).toList();
}

List<enums.CreateUserDTORole> createUserDTORoleListFromJson(
  List? createUserDTORole, [
  List<enums.CreateUserDTORole>? defaultValue,
]) {
  if (createUserDTORole == null) {
    return defaultValue ?? [];
  }

  return createUserDTORole
      .map((e) => createUserDTORoleFromJson(e.toString()))
      .toList();
}

List<enums.CreateUserDTORole>? createUserDTORoleNullableListFromJson(
  List? createUserDTORole, [
  List<enums.CreateUserDTORole>? defaultValue,
]) {
  if (createUserDTORole == null) {
    return defaultValue;
  }

  return createUserDTORole
      .map((e) => createUserDTORoleFromJson(e.toString()))
      .toList();
}

String? userResponseDTORoleNullableToJson(
  enums.UserResponseDTORole? userResponseDTORole,
) {
  return userResponseDTORole?.value;
}

String? userResponseDTORoleToJson(
  enums.UserResponseDTORole userResponseDTORole,
) {
  return userResponseDTORole.value;
}

enums.UserResponseDTORole userResponseDTORoleFromJson(
  Object? userResponseDTORole, [
  enums.UserResponseDTORole? defaultValue,
]) {
  return enums.UserResponseDTORole.values.firstWhereOrNull(
        (e) => e.value == userResponseDTORole,
      ) ??
      defaultValue ??
      enums.UserResponseDTORole.swaggerGeneratedUnknown;
}

enums.UserResponseDTORole? userResponseDTORoleNullableFromJson(
  Object? userResponseDTORole, [
  enums.UserResponseDTORole? defaultValue,
]) {
  if (userResponseDTORole == null) {
    return null;
  }
  return enums.UserResponseDTORole.values.firstWhereOrNull(
        (e) => e.value == userResponseDTORole,
      ) ??
      defaultValue;
}

String userResponseDTORoleExplodedListToJson(
  List<enums.UserResponseDTORole>? userResponseDTORole,
) {
  return userResponseDTORole?.map((e) => e.value!).join(',') ?? '';
}

List<String> userResponseDTORoleListToJson(
  List<enums.UserResponseDTORole>? userResponseDTORole,
) {
  if (userResponseDTORole == null) {
    return [];
  }

  return userResponseDTORole.map((e) => e.value!).toList();
}

List<enums.UserResponseDTORole> userResponseDTORoleListFromJson(
  List? userResponseDTORole, [
  List<enums.UserResponseDTORole>? defaultValue,
]) {
  if (userResponseDTORole == null) {
    return defaultValue ?? [];
  }

  return userResponseDTORole
      .map((e) => userResponseDTORoleFromJson(e.toString()))
      .toList();
}

List<enums.UserResponseDTORole>? userResponseDTORoleNullableListFromJson(
  List? userResponseDTORole, [
  List<enums.UserResponseDTORole>? defaultValue,
]) {
  if (userResponseDTORole == null) {
    return defaultValue;
  }

  return userResponseDTORole
      .map((e) => userResponseDTORoleFromJson(e.toString()))
      .toList();
}

String? updateFeedbackStatusDTOStatusNullableToJson(
  enums.UpdateFeedbackStatusDTOStatus? updateFeedbackStatusDTOStatus,
) {
  return updateFeedbackStatusDTOStatus?.value;
}

String? updateFeedbackStatusDTOStatusToJson(
  enums.UpdateFeedbackStatusDTOStatus updateFeedbackStatusDTOStatus,
) {
  return updateFeedbackStatusDTOStatus.value;
}

enums.UpdateFeedbackStatusDTOStatus updateFeedbackStatusDTOStatusFromJson(
  Object? updateFeedbackStatusDTOStatus, [
  enums.UpdateFeedbackStatusDTOStatus? defaultValue,
]) {
  return enums.UpdateFeedbackStatusDTOStatus.values.firstWhereOrNull(
        (e) => e.value == updateFeedbackStatusDTOStatus,
      ) ??
      defaultValue ??
      enums.UpdateFeedbackStatusDTOStatus.swaggerGeneratedUnknown;
}

enums.UpdateFeedbackStatusDTOStatus?
    updateFeedbackStatusDTOStatusNullableFromJson(
  Object? updateFeedbackStatusDTOStatus, [
  enums.UpdateFeedbackStatusDTOStatus? defaultValue,
]) {
  if (updateFeedbackStatusDTOStatus == null) {
    return null;
  }
  return enums.UpdateFeedbackStatusDTOStatus.values.firstWhereOrNull(
        (e) => e.value == updateFeedbackStatusDTOStatus,
      ) ??
      defaultValue;
}

String updateFeedbackStatusDTOStatusExplodedListToJson(
  List<enums.UpdateFeedbackStatusDTOStatus>? updateFeedbackStatusDTOStatus,
) {
  return updateFeedbackStatusDTOStatus?.map((e) => e.value!).join(',') ?? '';
}

List<String> updateFeedbackStatusDTOStatusListToJson(
  List<enums.UpdateFeedbackStatusDTOStatus>? updateFeedbackStatusDTOStatus,
) {
  if (updateFeedbackStatusDTOStatus == null) {
    return [];
  }

  return updateFeedbackStatusDTOStatus.map((e) => e.value!).toList();
}

List<enums.UpdateFeedbackStatusDTOStatus>
    updateFeedbackStatusDTOStatusListFromJson(
  List? updateFeedbackStatusDTOStatus, [
  List<enums.UpdateFeedbackStatusDTOStatus>? defaultValue,
]) {
  if (updateFeedbackStatusDTOStatus == null) {
    return defaultValue ?? [];
  }

  return updateFeedbackStatusDTOStatus
      .map((e) => updateFeedbackStatusDTOStatusFromJson(e.toString()))
      .toList();
}

List<enums.UpdateFeedbackStatusDTOStatus>?
    updateFeedbackStatusDTOStatusNullableListFromJson(
  List? updateFeedbackStatusDTOStatus, [
  List<enums.UpdateFeedbackStatusDTOStatus>? defaultValue,
]) {
  if (updateFeedbackStatusDTOStatus == null) {
    return defaultValue;
  }

  return updateFeedbackStatusDTOStatus
      .map((e) => updateFeedbackStatusDTOStatusFromJson(e.toString()))
      .toList();
}

String? createClientDTOStatusNullableToJson(
  enums.CreateClientDTOStatus? createClientDTOStatus,
) {
  return createClientDTOStatus?.value;
}

String? createClientDTOStatusToJson(
  enums.CreateClientDTOStatus createClientDTOStatus,
) {
  return createClientDTOStatus.value;
}

enums.CreateClientDTOStatus createClientDTOStatusFromJson(
  Object? createClientDTOStatus, [
  enums.CreateClientDTOStatus? defaultValue,
]) {
  return enums.CreateClientDTOStatus.values.firstWhereOrNull(
        (e) => e.value == createClientDTOStatus,
      ) ??
      defaultValue ??
      enums.CreateClientDTOStatus.swaggerGeneratedUnknown;
}

enums.CreateClientDTOStatus? createClientDTOStatusNullableFromJson(
  Object? createClientDTOStatus, [
  enums.CreateClientDTOStatus? defaultValue,
]) {
  if (createClientDTOStatus == null) {
    return null;
  }
  return enums.CreateClientDTOStatus.values.firstWhereOrNull(
        (e) => e.value == createClientDTOStatus,
      ) ??
      defaultValue;
}

String createClientDTOStatusExplodedListToJson(
  List<enums.CreateClientDTOStatus>? createClientDTOStatus,
) {
  return createClientDTOStatus?.map((e) => e.value!).join(',') ?? '';
}

List<String> createClientDTOStatusListToJson(
  List<enums.CreateClientDTOStatus>? createClientDTOStatus,
) {
  if (createClientDTOStatus == null) {
    return [];
  }

  return createClientDTOStatus.map((e) => e.value!).toList();
}

List<enums.CreateClientDTOStatus> createClientDTOStatusListFromJson(
  List? createClientDTOStatus, [
  List<enums.CreateClientDTOStatus>? defaultValue,
]) {
  if (createClientDTOStatus == null) {
    return defaultValue ?? [];
  }

  return createClientDTOStatus
      .map((e) => createClientDTOStatusFromJson(e.toString()))
      .toList();
}

List<enums.CreateClientDTOStatus>? createClientDTOStatusNullableListFromJson(
  List? createClientDTOStatus, [
  List<enums.CreateClientDTOStatus>? defaultValue,
]) {
  if (createClientDTOStatus == null) {
    return defaultValue;
  }

  return createClientDTOStatus
      .map((e) => createClientDTOStatusFromJson(e.toString()))
      .toList();
}

String? updateClientDTOStatusNullableToJson(
  enums.UpdateClientDTOStatus? updateClientDTOStatus,
) {
  return updateClientDTOStatus?.value;
}

String? updateClientDTOStatusToJson(
  enums.UpdateClientDTOStatus updateClientDTOStatus,
) {
  return updateClientDTOStatus.value;
}

enums.UpdateClientDTOStatus updateClientDTOStatusFromJson(
  Object? updateClientDTOStatus, [
  enums.UpdateClientDTOStatus? defaultValue,
]) {
  return enums.UpdateClientDTOStatus.values.firstWhereOrNull(
        (e) => e.value == updateClientDTOStatus,
      ) ??
      defaultValue ??
      enums.UpdateClientDTOStatus.swaggerGeneratedUnknown;
}

enums.UpdateClientDTOStatus? updateClientDTOStatusNullableFromJson(
  Object? updateClientDTOStatus, [
  enums.UpdateClientDTOStatus? defaultValue,
]) {
  if (updateClientDTOStatus == null) {
    return null;
  }
  return enums.UpdateClientDTOStatus.values.firstWhereOrNull(
        (e) => e.value == updateClientDTOStatus,
      ) ??
      defaultValue;
}

String updateClientDTOStatusExplodedListToJson(
  List<enums.UpdateClientDTOStatus>? updateClientDTOStatus,
) {
  return updateClientDTOStatus?.map((e) => e.value!).join(',') ?? '';
}

List<String> updateClientDTOStatusListToJson(
  List<enums.UpdateClientDTOStatus>? updateClientDTOStatus,
) {
  if (updateClientDTOStatus == null) {
    return [];
  }

  return updateClientDTOStatus.map((e) => e.value!).toList();
}

List<enums.UpdateClientDTOStatus> updateClientDTOStatusListFromJson(
  List? updateClientDTOStatus, [
  List<enums.UpdateClientDTOStatus>? defaultValue,
]) {
  if (updateClientDTOStatus == null) {
    return defaultValue ?? [];
  }

  return updateClientDTOStatus
      .map((e) => updateClientDTOStatusFromJson(e.toString()))
      .toList();
}

List<enums.UpdateClientDTOStatus>? updateClientDTOStatusNullableListFromJson(
  List? updateClientDTOStatus, [
  List<enums.UpdateClientDTOStatus>? defaultValue,
]) {
  if (updateClientDTOStatus == null) {
    return defaultValue;
  }

  return updateClientDTOStatus
      .map((e) => updateClientDTOStatusFromJson(e.toString()))
      .toList();
}

String? customerFeedbackByStatusGetStatusNullableToJson(
  enums.CustomerFeedbackByStatusGetStatus? customerFeedbackByStatusGetStatus,
) {
  return customerFeedbackByStatusGetStatus?.value;
}

String? customerFeedbackByStatusGetStatusToJson(
  enums.CustomerFeedbackByStatusGetStatus customerFeedbackByStatusGetStatus,
) {
  return customerFeedbackByStatusGetStatus.value;
}

enums.CustomerFeedbackByStatusGetStatus
    customerFeedbackByStatusGetStatusFromJson(
  Object? customerFeedbackByStatusGetStatus, [
  enums.CustomerFeedbackByStatusGetStatus? defaultValue,
]) {
  return enums.CustomerFeedbackByStatusGetStatus.values.firstWhereOrNull(
        (e) => e.value == customerFeedbackByStatusGetStatus,
      ) ??
      defaultValue ??
      enums.CustomerFeedbackByStatusGetStatus.swaggerGeneratedUnknown;
}

enums.CustomerFeedbackByStatusGetStatus?
    customerFeedbackByStatusGetStatusNullableFromJson(
  Object? customerFeedbackByStatusGetStatus, [
  enums.CustomerFeedbackByStatusGetStatus? defaultValue,
]) {
  if (customerFeedbackByStatusGetStatus == null) {
    return null;
  }
  return enums.CustomerFeedbackByStatusGetStatus.values.firstWhereOrNull(
        (e) => e.value == customerFeedbackByStatusGetStatus,
      ) ??
      defaultValue;
}

String customerFeedbackByStatusGetStatusExplodedListToJson(
  List<enums.CustomerFeedbackByStatusGetStatus>?
      customerFeedbackByStatusGetStatus,
) {
  return customerFeedbackByStatusGetStatus?.map((e) => e.value!).join(',') ??
      '';
}

List<String> customerFeedbackByStatusGetStatusListToJson(
  List<enums.CustomerFeedbackByStatusGetStatus>?
      customerFeedbackByStatusGetStatus,
) {
  if (customerFeedbackByStatusGetStatus == null) {
    return [];
  }

  return customerFeedbackByStatusGetStatus.map((e) => e.value!).toList();
}

List<enums.CustomerFeedbackByStatusGetStatus>
    customerFeedbackByStatusGetStatusListFromJson(
  List? customerFeedbackByStatusGetStatus, [
  List<enums.CustomerFeedbackByStatusGetStatus>? defaultValue,
]) {
  if (customerFeedbackByStatusGetStatus == null) {
    return defaultValue ?? [];
  }

  return customerFeedbackByStatusGetStatus
      .map((e) => customerFeedbackByStatusGetStatusFromJson(e.toString()))
      .toList();
}

List<enums.CustomerFeedbackByStatusGetStatus>?
    customerFeedbackByStatusGetStatusNullableListFromJson(
  List? customerFeedbackByStatusGetStatus, [
  List<enums.CustomerFeedbackByStatusGetStatus>? defaultValue,
]) {
  if (customerFeedbackByStatusGetStatus == null) {
    return defaultValue;
  }

  return customerFeedbackByStatusGetStatus
      .map((e) => customerFeedbackByStatusGetStatusFromJson(e.toString()))
      .toList();
}

String? apiClientsGetStatusNullableToJson(
  enums.ApiClientsGetStatus? apiClientsGetStatus,
) {
  return apiClientsGetStatus?.value;
}

String? apiClientsGetStatusToJson(
  enums.ApiClientsGetStatus apiClientsGetStatus,
) {
  return apiClientsGetStatus.value;
}

enums.ApiClientsGetStatus apiClientsGetStatusFromJson(
  Object? apiClientsGetStatus, [
  enums.ApiClientsGetStatus? defaultValue,
]) {
  return enums.ApiClientsGetStatus.values.firstWhereOrNull(
        (e) => e.value == apiClientsGetStatus,
      ) ??
      defaultValue ??
      enums.ApiClientsGetStatus.swaggerGeneratedUnknown;
}

enums.ApiClientsGetStatus? apiClientsGetStatusNullableFromJson(
  Object? apiClientsGetStatus, [
  enums.ApiClientsGetStatus? defaultValue,
]) {
  if (apiClientsGetStatus == null) {
    return null;
  }
  return enums.ApiClientsGetStatus.values.firstWhereOrNull(
        (e) => e.value == apiClientsGetStatus,
      ) ??
      defaultValue;
}

String apiClientsGetStatusExplodedListToJson(
  List<enums.ApiClientsGetStatus>? apiClientsGetStatus,
) {
  return apiClientsGetStatus?.map((e) => e.value!).join(',') ?? '';
}

List<String> apiClientsGetStatusListToJson(
  List<enums.ApiClientsGetStatus>? apiClientsGetStatus,
) {
  if (apiClientsGetStatus == null) {
    return [];
  }

  return apiClientsGetStatus.map((e) => e.value!).toList();
}

List<enums.ApiClientsGetStatus> apiClientsGetStatusListFromJson(
  List? apiClientsGetStatus, [
  List<enums.ApiClientsGetStatus>? defaultValue,
]) {
  if (apiClientsGetStatus == null) {
    return defaultValue ?? [];
  }

  return apiClientsGetStatus
      .map((e) => apiClientsGetStatusFromJson(e.toString()))
      .toList();
}

List<enums.ApiClientsGetStatus>? apiClientsGetStatusNullableListFromJson(
  List? apiClientsGetStatus, [
  List<enums.ApiClientsGetStatus>? defaultValue,
]) {
  if (apiClientsGetStatus == null) {
    return defaultValue;
  }

  return apiClientsGetStatus
      .map((e) => apiClientsGetStatusFromJson(e.toString()))
      .toList();
}

String? apiClientsGetSortOrderNullableToJson(
  enums.ApiClientsGetSortOrder? apiClientsGetSortOrder,
) {
  return apiClientsGetSortOrder?.value;
}

String? apiClientsGetSortOrderToJson(
  enums.ApiClientsGetSortOrder apiClientsGetSortOrder,
) {
  return apiClientsGetSortOrder.value;
}

enums.ApiClientsGetSortOrder apiClientsGetSortOrderFromJson(
  Object? apiClientsGetSortOrder, [
  enums.ApiClientsGetSortOrder? defaultValue,
]) {
  return enums.ApiClientsGetSortOrder.values.firstWhereOrNull(
        (e) => e.value == apiClientsGetSortOrder,
      ) ??
      defaultValue ??
      enums.ApiClientsGetSortOrder.swaggerGeneratedUnknown;
}

enums.ApiClientsGetSortOrder? apiClientsGetSortOrderNullableFromJson(
  Object? apiClientsGetSortOrder, [
  enums.ApiClientsGetSortOrder? defaultValue,
]) {
  if (apiClientsGetSortOrder == null) {
    return null;
  }
  return enums.ApiClientsGetSortOrder.values.firstWhereOrNull(
        (e) => e.value == apiClientsGetSortOrder,
      ) ??
      defaultValue;
}

String apiClientsGetSortOrderExplodedListToJson(
  List<enums.ApiClientsGetSortOrder>? apiClientsGetSortOrder,
) {
  return apiClientsGetSortOrder?.map((e) => e.value!).join(',') ?? '';
}

List<String> apiClientsGetSortOrderListToJson(
  List<enums.ApiClientsGetSortOrder>? apiClientsGetSortOrder,
) {
  if (apiClientsGetSortOrder == null) {
    return [];
  }

  return apiClientsGetSortOrder.map((e) => e.value!).toList();
}

List<enums.ApiClientsGetSortOrder> apiClientsGetSortOrderListFromJson(
  List? apiClientsGetSortOrder, [
  List<enums.ApiClientsGetSortOrder>? defaultValue,
]) {
  if (apiClientsGetSortOrder == null) {
    return defaultValue ?? [];
  }

  return apiClientsGetSortOrder
      .map((e) => apiClientsGetSortOrderFromJson(e.toString()))
      .toList();
}

List<enums.ApiClientsGetSortOrder>? apiClientsGetSortOrderNullableListFromJson(
  List? apiClientsGetSortOrder, [
  List<enums.ApiClientsGetSortOrder>? defaultValue,
]) {
  if (apiClientsGetSortOrder == null) {
    return defaultValue;
  }

  return apiClientsGetSortOrder
      .map((e) => apiClientsGetSortOrderFromJson(e.toString()))
      .toList();
}

String? apiClientsSearchGetStatusNullableToJson(
  enums.ApiClientsSearchGetStatus? apiClientsSearchGetStatus,
) {
  return apiClientsSearchGetStatus?.value;
}

String? apiClientsSearchGetStatusToJson(
  enums.ApiClientsSearchGetStatus apiClientsSearchGetStatus,
) {
  return apiClientsSearchGetStatus.value;
}

enums.ApiClientsSearchGetStatus apiClientsSearchGetStatusFromJson(
  Object? apiClientsSearchGetStatus, [
  enums.ApiClientsSearchGetStatus? defaultValue,
]) {
  return enums.ApiClientsSearchGetStatus.values.firstWhereOrNull(
        (e) => e.value == apiClientsSearchGetStatus,
      ) ??
      defaultValue ??
      enums.ApiClientsSearchGetStatus.swaggerGeneratedUnknown;
}

enums.ApiClientsSearchGetStatus? apiClientsSearchGetStatusNullableFromJson(
  Object? apiClientsSearchGetStatus, [
  enums.ApiClientsSearchGetStatus? defaultValue,
]) {
  if (apiClientsSearchGetStatus == null) {
    return null;
  }
  return enums.ApiClientsSearchGetStatus.values.firstWhereOrNull(
        (e) => e.value == apiClientsSearchGetStatus,
      ) ??
      defaultValue;
}

String apiClientsSearchGetStatusExplodedListToJson(
  List<enums.ApiClientsSearchGetStatus>? apiClientsSearchGetStatus,
) {
  return apiClientsSearchGetStatus?.map((e) => e.value!).join(',') ?? '';
}

List<String> apiClientsSearchGetStatusListToJson(
  List<enums.ApiClientsSearchGetStatus>? apiClientsSearchGetStatus,
) {
  if (apiClientsSearchGetStatus == null) {
    return [];
  }

  return apiClientsSearchGetStatus.map((e) => e.value!).toList();
}

List<enums.ApiClientsSearchGetStatus> apiClientsSearchGetStatusListFromJson(
  List? apiClientsSearchGetStatus, [
  List<enums.ApiClientsSearchGetStatus>? defaultValue,
]) {
  if (apiClientsSearchGetStatus == null) {
    return defaultValue ?? [];
  }

  return apiClientsSearchGetStatus
      .map((e) => apiClientsSearchGetStatusFromJson(e.toString()))
      .toList();
}

List<enums.ApiClientsSearchGetStatus>?
    apiClientsSearchGetStatusNullableListFromJson(
  List? apiClientsSearchGetStatus, [
  List<enums.ApiClientsSearchGetStatus>? defaultValue,
]) {
  if (apiClientsSearchGetStatus == null) {
    return defaultValue;
  }

  return apiClientsSearchGetStatus
      .map((e) => apiClientsSearchGetStatusFromJson(e.toString()))
      .toList();
}

String? apiClientsSearchGetSortOrderNullableToJson(
  enums.ApiClientsSearchGetSortOrder? apiClientsSearchGetSortOrder,
) {
  return apiClientsSearchGetSortOrder?.value;
}

String? apiClientsSearchGetSortOrderToJson(
  enums.ApiClientsSearchGetSortOrder apiClientsSearchGetSortOrder,
) {
  return apiClientsSearchGetSortOrder.value;
}

enums.ApiClientsSearchGetSortOrder apiClientsSearchGetSortOrderFromJson(
  Object? apiClientsSearchGetSortOrder, [
  enums.ApiClientsSearchGetSortOrder? defaultValue,
]) {
  return enums.ApiClientsSearchGetSortOrder.values.firstWhereOrNull(
        (e) => e.value == apiClientsSearchGetSortOrder,
      ) ??
      defaultValue ??
      enums.ApiClientsSearchGetSortOrder.swaggerGeneratedUnknown;
}

enums.ApiClientsSearchGetSortOrder?
    apiClientsSearchGetSortOrderNullableFromJson(
  Object? apiClientsSearchGetSortOrder, [
  enums.ApiClientsSearchGetSortOrder? defaultValue,
]) {
  if (apiClientsSearchGetSortOrder == null) {
    return null;
  }
  return enums.ApiClientsSearchGetSortOrder.values.firstWhereOrNull(
        (e) => e.value == apiClientsSearchGetSortOrder,
      ) ??
      defaultValue;
}

String apiClientsSearchGetSortOrderExplodedListToJson(
  List<enums.ApiClientsSearchGetSortOrder>? apiClientsSearchGetSortOrder,
) {
  return apiClientsSearchGetSortOrder?.map((e) => e.value!).join(',') ?? '';
}

List<String> apiClientsSearchGetSortOrderListToJson(
  List<enums.ApiClientsSearchGetSortOrder>? apiClientsSearchGetSortOrder,
) {
  if (apiClientsSearchGetSortOrder == null) {
    return [];
  }

  return apiClientsSearchGetSortOrder.map((e) => e.value!).toList();
}

List<enums.ApiClientsSearchGetSortOrder>
    apiClientsSearchGetSortOrderListFromJson(
  List? apiClientsSearchGetSortOrder, [
  List<enums.ApiClientsSearchGetSortOrder>? defaultValue,
]) {
  if (apiClientsSearchGetSortOrder == null) {
    return defaultValue ?? [];
  }

  return apiClientsSearchGetSortOrder
      .map((e) => apiClientsSearchGetSortOrderFromJson(e.toString()))
      .toList();
}

List<enums.ApiClientsSearchGetSortOrder>?
    apiClientsSearchGetSortOrderNullableListFromJson(
  List? apiClientsSearchGetSortOrder, [
  List<enums.ApiClientsSearchGetSortOrder>? defaultValue,
]) {
  if (apiClientsSearchGetSortOrder == null) {
    return defaultValue;
  }

  return apiClientsSearchGetSortOrder
      .map((e) => apiClientsSearchGetSortOrderFromJson(e.toString()))
      .toList();
}

typedef $JsonFactory<T> = T Function(Map<String, dynamic> json);

class $CustomJsonDecoder {
  $CustomJsonDecoder(this.factories);

  final Map<Type, $JsonFactory> factories;

  dynamic decode<T>(dynamic entity) {
    if (entity is Iterable) {
      return _decodeList<T>(entity);
    }

    if (entity is T) {
      return entity;
    }

    if (isTypeOf<T, Map>()) {
      return entity;
    }

    if (isTypeOf<T, Iterable>()) {
      return entity;
    }

    if (entity is Map<String, dynamic>) {
      return _decodeMap<T>(entity);
    }

    return entity;
  }

  T _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! $JsonFactory<T>) {
      return throw "Could not find factory for type $T. Is '$T: $T.fromJsonFactory' included in the CustomJsonDecoder instance creation in bootstrapper.dart?";
    }

    return jsonFactory(values);
  }

  List<T> _decodeList<T>(Iterable values) =>
      values.where((v) => v != null).map<T>((v) => decode<T>(v) as T).toList();
}

class $JsonSerializableConverter extends chopper.JsonConverter {
  @override
  FutureOr<chopper.Response<ResultType>> convertResponse<ResultType, Item>(
    chopper.Response response,
  ) async {
    if (response.bodyString.isEmpty) {
      // In rare cases, when let's say 204 (no content) is returned -
      // we cannot decode the missing json with the result type specified
      return chopper.Response(response.base, null, error: response.error);
    }

    if (ResultType == String) {
      return response.copyWith();
    }

    if (ResultType == DateTime) {
      return response.copyWith(
        body: DateTime.parse((response.body as String).replaceAll('"', ''))
            as ResultType,
      );
    }

    final jsonRes = await super.convertResponse(response);
    return jsonRes.copyWith<ResultType>(
      body: $jsonDecoder.decode<Item>(jsonRes.body) as ResultType,
    );
  }
}

final $jsonDecoder = $CustomJsonDecoder(generatedMapping);

// ignore: unused_element
String? _dateToJson(DateTime? date) {
  if (date == null) {
    return null;
  }

  final year = date.year.toString();
  final month = date.month < 10 ? '0${date.month}' : date.month.toString();
  final day = date.day < 10 ? '0${date.day}' : date.day.toString();

  return '$year-$month-$day';
}

class Wrapped<T> {
  final T value;
  const Wrapped.value(this.value);
}
