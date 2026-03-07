// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'swagger.swagger.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$Swagger extends Swagger {
  _$Swagger([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = Swagger;

  @override
  Future<Response<LoginUserDTO>> _Login({required LoginUserDTO? body}) {
    final Uri $url = Uri.parse('/auth/login');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<LoginUserDTO, LoginUserDTO>($request);
  }

  @override
  Future<Response<String>> _GetAuthStatus() {
    final Uri $url = Uri.parse('/auth/status');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<UserResponseDTO>> _CreateUser(
      {required CreateUserDTO? body}) {
    final Uri $url = Uri.parse('/users/create');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<UserResponseDTO, UserResponseDTO>($request);
  }

  @override
  Future<Response<List<UserResponseDTO>>> _GetAllUsers() {
    final Uri $url = Uri.parse('/users/get-user');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<UserResponseDTO>, UserResponseDTO>($request);
  }

  @override
  Future<Response<UserResponseDTO>> _GetUserById({required String? userId}) {
    final Uri $url = Uri.parse('/users/get-user/${userId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<UserResponseDTO, UserResponseDTO>($request);
  }

  @override
  Future<Response<UserResponseDTO>> _UpdateUser({
    required String? userId,
    required CreateUserDTO? body,
  }) {
    final Uri $url = Uri.parse('/users/update-user/${userId}');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<UserResponseDTO, UserResponseDTO>($request);
  }

  @override
  Future<Response<UserResponseDTO>> _DeleteUser({required String? userId}) {
    final Uri $url = Uri.parse('/users/delete-user/${userId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<UserResponseDTO, UserResponseDTO>($request);
  }

  @override
  Future<Response<ProductResponseDTO>> _CreateProduct(
      {required CreateProductDTO? body}) {
    final Uri $url = Uri.parse('/products/create');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<ProductResponseDTO, ProductResponseDTO>($request);
  }

  @override
  Future<Response<List<ProductResponseDTO>>> _GetAllProducts() {
    final Uri $url = Uri.parse('/products/get-all-products');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<ProductResponseDTO>, ProductResponseDTO>($request);
  }

  @override
  Future<Response<ProductResponseDTO>> _GetProductById(
      {required String? productId}) {
    final Uri $url = Uri.parse('/products/${productId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<ProductResponseDTO, ProductResponseDTO>($request);
  }

  @override
  Future<Response<ProductResponseDTO>> _UpdateProduct({
    required String? productId,
    required CreateProductDTO? body,
  }) {
    final Uri $url = Uri.parse('/products/update/${productId}');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<ProductResponseDTO, ProductResponseDTO>($request);
  }

  @override
  Future<Response<MessageResponseDTO>> _DeleteProduct(
      {required String? productId}) {
    final Uri $url = Uri.parse('/products/delete/${productId}');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<MessageResponseDTO, MessageResponseDTO>($request);
  }

  @override
  Future<Response<ProductCategoryResponseDTO>> _CreateProductCategory(
      {required CreateProductCategoryDTO? body}) {
    final Uri $url = Uri.parse('/product-categories/create');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client
        .send<ProductCategoryResponseDTO, ProductCategoryResponseDTO>($request);
  }

  @override
  Future<Response<GetAllProductCategoriesResponseDTO>>
      _GetAllProductCategories() {
    final Uri $url = Uri.parse('/product-categories/get-all');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<GetAllProductCategoriesResponseDTO,
        GetAllProductCategoriesResponseDTO>($request);
  }

  @override
  Future<Response<ProductCategoryResponseDTO>> _GetProductCategoryById(
      {required String? categoryId}) {
    final Uri $url = Uri.parse('/product-categories/${categoryId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<ProductCategoryResponseDTO, ProductCategoryResponseDTO>($request);
  }

  @override
  Future<Response<ProductCategoryResponseDTO>> _UpdateProductCategory({
    required String? categoryId,
    required CreateProductCategoryDTO? body,
  }) {
    final Uri $url = Uri.parse('/product-categories/update/${categoryId}');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client
        .send<ProductCategoryResponseDTO, ProductCategoryResponseDTO>($request);
  }

  @override
  Future<Response<MessageResponseDTO>> _DeleteProductCategory(
      {required String? categoryId}) {
    final Uri $url = Uri.parse('/product-categories/delete/${categoryId}');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<MessageResponseDTO, MessageResponseDTO>($request);
  }

  @override
  Future<Response<OrderResponseDTO>> _CreateOrder(
      {required CreateOrderDTO? body}) {
    final Uri $url = Uri.parse('/orders/create');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<OrderResponseDTO, OrderResponseDTO>($request);
  }

  @override
  Future<Response<List<OrderResponseDTO>>> _GetAllOrders() {
    final Uri $url = Uri.parse('/orders/get-all');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<OrderResponseDTO>, OrderResponseDTO>($request);
  }

  @override
  Future<Response<OrderResponseDTO>> _GetOrderById({required String? orderId}) {
    final Uri $url = Uri.parse('/orders/${orderId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<OrderResponseDTO, OrderResponseDTO>($request);
  }

  @override
  Future<Response<MessageResponseDTO>> _DeleteOrder(
      {required String? orderId}) {
    final Uri $url = Uri.parse('/orders/delete/${orderId}');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<MessageResponseDTO, MessageResponseDTO>($request);
  }

  @override
  Future<Response<CareerResponseDTO>> _CreateCareer(
      {required CreateCareerDTO? body}) {
    final Uri $url = Uri.parse('/careers/create');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<CareerResponseDTO, CareerResponseDTO>($request);
  }

  @override
  Future<Response<GetAllCareersResponseDTO>> _GetAllCareers() {
    final Uri $url = Uri.parse('/careers/get-all');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<GetAllCareersResponseDTO, GetAllCareersResponseDTO>($request);
  }

  @override
  Future<Response<CareerResponseDTO>> _GetCareerById(
      {required String? careerId}) {
    final Uri $url = Uri.parse('/careers/${careerId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<CareerResponseDTO, CareerResponseDTO>($request);
  }

  @override
  Future<Response<CareerResponseDTO>> _UpdateCareer({
    required String? careerId,
    required CreateCareerDTO? body,
  }) {
    final Uri $url = Uri.parse('/careers/update/${careerId}');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<CareerResponseDTO, CareerResponseDTO>($request);
  }

  @override
  Future<Response<MessageResponseDTO>> _DeleteCareer(
      {required String? careerId}) {
    final Uri $url = Uri.parse('/careers/delete/${careerId}');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<MessageResponseDTO, MessageResponseDTO>($request);
  }

  @override
  Future<Response<ProductColorResponseDTO>> _CreateProductColor(
      {required CreateProductColorDTO? body}) {
    final Uri $url = Uri.parse('/product-colors/create');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client
        .send<ProductColorResponseDTO, ProductColorResponseDTO>($request);
  }

  @override
  Future<Response<GetAllProductColorsResponseDTO>> _GetAllProductColors() {
    final Uri $url = Uri.parse('/product-colors/get-all');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<GetAllProductColorsResponseDTO,
        GetAllProductColorsResponseDTO>($request);
  }

  @override
  Future<Response<ProductColorResponseDTO>> _GetProductColorById(
      {required String? colorId}) {
    final Uri $url = Uri.parse('/product-colors/${colorId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<ProductColorResponseDTO, ProductColorResponseDTO>($request);
  }

  @override
  Future<Response<ProductColorResponseDTO>> _UpdateProductColor({
    required String? colorId,
    required CreateProductColorDTO? body,
  }) {
    final Uri $url = Uri.parse('/product-colors/update/${colorId}');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client
        .send<ProductColorResponseDTO, ProductColorResponseDTO>($request);
  }

  @override
  Future<Response<MessageResponseDTO>> _DeleteProductColor(
      {required String? colorId}) {
    final Uri $url = Uri.parse('/product-colors/delete/${colorId}');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<MessageResponseDTO, MessageResponseDTO>($request);
  }

  @override
  Future<Response<ProductTypeResponseDTO>> _CreateProductType(
      {required CreateProductTypeDTO? body}) {
    final Uri $url = Uri.parse('/product-types/create');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client
        .send<ProductTypeResponseDTO, ProductTypeResponseDTO>($request);
  }

  @override
  Future<Response<GetAllProductTypesResponseDTO>> _GetAllProductTypes() {
    final Uri $url = Uri.parse('/product-types/get-all');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<GetAllProductTypesResponseDTO,
        GetAllProductTypesResponseDTO>($request);
  }

  @override
  Future<Response<ProductTypeResponseDTO>> _GetProductTypeById(
      {required String? typeId}) {
    final Uri $url = Uri.parse('/product-types/${typeId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<ProductTypeResponseDTO, ProductTypeResponseDTO>($request);
  }

  @override
  Future<Response<ProductTypeResponseDTO>> _UpdateProductType({
    required String? typeId,
    required CreateProductTypeDTO? body,
  }) {
    final Uri $url = Uri.parse('/product-types/update/${typeId}');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client
        .send<ProductTypeResponseDTO, ProductTypeResponseDTO>($request);
  }

  @override
  Future<Response<MessageResponseDTO>> _DeleteProductType(
      {required String? typeId}) {
    final Uri $url = Uri.parse('/product-types/delete/${typeId}');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<MessageResponseDTO, MessageResponseDTO>($request);
  }

  @override
  Future<Response<ProductMaterialResponseDTO>> _CreateProductMaterial(
      {required CreateProductMaterialDTO? body}) {
    final Uri $url = Uri.parse('/product-materials/create');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client
        .send<ProductMaterialResponseDTO, ProductMaterialResponseDTO>($request);
  }

  @override
  Future<Response<GetAllProductMaterialsResponseDTO>>
      _GetAllProductMaterials() {
    final Uri $url = Uri.parse('/product-materials/get-all');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<GetAllProductMaterialsResponseDTO,
        GetAllProductMaterialsResponseDTO>($request);
  }

  @override
  Future<Response<ProductMaterialResponseDTO>> _GetProductMaterialById(
      {required String? materialId}) {
    final Uri $url = Uri.parse('/product-materials/${materialId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<ProductMaterialResponseDTO, ProductMaterialResponseDTO>($request);
  }

  @override
  Future<Response<ProductMaterialResponseDTO>> _UpdateProductMaterial({
    required String? materialId,
    required CreateProductMaterialDTO? body,
  }) {
    final Uri $url = Uri.parse('/product-materials/update/${materialId}');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client
        .send<ProductMaterialResponseDTO, ProductMaterialResponseDTO>($request);
  }

  @override
  Future<Response<MessageResponseDTO>> _DeleteProductMaterial(
      {required String? materialId}) {
    final Uri $url = Uri.parse('/product-materials/delete/${materialId}');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<MessageResponseDTO, MessageResponseDTO>($request);
  }

  @override
  Future<Response<CreatePortfolioResponseDTO>> _CreatePortfolio(
      {required CreatePortfolioDTO? body}) {
    final Uri $url = Uri.parse('/portfolio/create');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client
        .send<CreatePortfolioResponseDTO, CreatePortfolioResponseDTO>($request);
  }

  @override
  Future<Response<GetAllPortfoliosResponseDTO>> _GetAllPortfolios() {
    final Uri $url = Uri.parse('/portfolio/get-all');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<GetAllPortfoliosResponseDTO,
        GetAllPortfoliosResponseDTO>($request);
  }

  @override
  Future<Response<GetPortfolioDetailResponseDTO>> _GetPortfolioById(
      {required String? portfolioId}) {
    final Uri $url = Uri.parse('/portfolio/${portfolioId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<GetPortfolioDetailResponseDTO,
        GetPortfolioDetailResponseDTO>($request);
  }

  @override
  Future<Response<UpdatePortfolioResponseDTO>> _UpdatePortfolio({
    required String? portfolioId,
    required CreatePortfolioDTO? body,
  }) {
    final Uri $url = Uri.parse('/portfolio/update/${portfolioId}');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client
        .send<UpdatePortfolioResponseDTO, UpdatePortfolioResponseDTO>($request);
  }

  @override
  Future<Response<MessageResponseDTO>> _DeletePortfolio(
      {required String? portfolioId}) {
    final Uri $url = Uri.parse('/portfolio/delete/${portfolioId}');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<MessageResponseDTO, MessageResponseDTO>($request);
  }

  @override
  Future<Response<PortfolioCategoryResponseDTO>> _CreatePortfolioCategory(
      {required CreatePortfolioCategoryDTO? body}) {
    final Uri $url = Uri.parse('/portfolio-categories/create');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<PortfolioCategoryResponseDTO,
        PortfolioCategoryResponseDTO>($request);
  }

  @override
  Future<Response<GetAllPortfolioCategoriesResponseDTO>>
      _GetAllPortfolioCategories() {
    final Uri $url = Uri.parse('/portfolio-categories/get-all');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<GetAllPortfolioCategoriesResponseDTO,
        GetAllPortfolioCategoriesResponseDTO>($request);
  }

  @override
  Future<Response<PortfolioCategoryResponseDTO>> _GetPortfolioCategoryById(
      {required String? id}) {
    final Uri $url = Uri.parse('/portfolio-categories/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<PortfolioCategoryResponseDTO,
        PortfolioCategoryResponseDTO>($request);
  }

  @override
  Future<Response<PortfolioCategoryResponseDTO>> _UpdatePortfolioCategory({
    required String? id,
    required CreatePortfolioCategoryDTO? body,
  }) {
    final Uri $url = Uri.parse('/portfolio-categories/update/${id}');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<PortfolioCategoryResponseDTO,
        PortfolioCategoryResponseDTO>($request);
  }

  @override
  Future<Response<MessageResponseDTO>> _DeletePortfolioCategory(
      {required String? id}) {
    final Uri $url = Uri.parse('/portfolio-categories/delete/${id}');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<MessageResponseDTO, MessageResponseDTO>($request);
  }

  @override
  Future<Response<CustomerFeedbackResponseDTO>> _CreateCustomerFeedback(
      {required CreateCustomerFeedbackDTO? body}) {
    final Uri $url = Uri.parse('/customer-feedback/create');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<CustomerFeedbackResponseDTO,
        CustomerFeedbackResponseDTO>($request);
  }

  @override
  Future<Response<GetAllCustomerFeedbackResponseDTO>>
      _GetAllCustomerFeedback() {
    final Uri $url = Uri.parse('/customer-feedback/get-all');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<GetAllCustomerFeedbackResponseDTO,
        GetAllCustomerFeedbackResponseDTO>($request);
  }

  @override
  Future<Response<GetAllCustomerFeedbackResponseDTO>>
      _GetActiveCustomerFeedback() {
    final Uri $url = Uri.parse('/customer-feedback/active');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<GetAllCustomerFeedbackResponseDTO,
        GetAllCustomerFeedbackResponseDTO>($request);
  }

  @override
  Future<Response<dynamic>> _GetFeedbackStats() {
    final Uri $url = Uri.parse('/customer-feedback/stats');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<GetAllCustomerFeedbackResponseDTO>> _GetFeedbackByStatus(
      {required String? status}) {
    final Uri $url = Uri.parse('/customer-feedback/by-status');
    final Map<String, dynamic> $params = <String, dynamic>{'status': status};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<GetAllCustomerFeedbackResponseDTO,
        GetAllCustomerFeedbackResponseDTO>($request);
  }

  @override
  Future<Response<CustomerFeedbackResponseDTO>> _GetCustomerFeedbackById(
      {required String? feedbackId}) {
    final Uri $url = Uri.parse('/customer-feedback/${feedbackId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<CustomerFeedbackResponseDTO,
        CustomerFeedbackResponseDTO>($request);
  }

  @override
  Future<Response<CustomerFeedbackResponseDTO>> _UpdateCustomerFeedback({
    required String? feedbackId,
    required CreateCustomerFeedbackDTO? body,
  }) {
    final Uri $url = Uri.parse('/customer-feedback/update/${feedbackId}');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<CustomerFeedbackResponseDTO,
        CustomerFeedbackResponseDTO>($request);
  }

  @override
  Future<Response<CustomerFeedbackResponseDTO>> _UpdateCustomerFeedbackStatus({
    required String? feedbackId,
    required UpdateFeedbackStatusDTO? body,
  }) {
    final Uri $url =
        Uri.parse('/customer-feedback/update-status/${feedbackId}');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<CustomerFeedbackResponseDTO,
        CustomerFeedbackResponseDTO>($request);
  }

  @override
  Future<Response<MessageResponseDTO>> _DeleteCustomerFeedback(
      {required String? feedbackId}) {
    final Uri $url = Uri.parse('/customer-feedback/delete/${feedbackId}');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<MessageResponseDTO, MessageResponseDTO>($request);
  }

  @override
  Future<Response<TelegramIntentResponseDTO>> _CreateTelegramIntent({
    String? contentType,
    required TelegramIntentDTO? body,
  }) {
    final Uri $url = Uri.parse('/api/leads/telegram-intent');
    final Map<String, String> $headers = {
      if (contentType != null) 'Content-Type': contentType,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client
        .send<TelegramIntentResponseDTO, TelegramIntentResponseDTO>($request);
  }

  @override
  Future<Response<MessageResponseDTO>> _SubmitContactUs({
    String? contentType,
    required ContactUsDTO? body,
  }) {
    final Uri $url = Uri.parse('/api/leads/contact-us');
    final Map<String, String> $headers = {
      if (contentType != null) 'Content-Type': contentType,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<MessageResponseDTO, MessageResponseDTO>($request);
  }

  @override
  Future<Response<GetAllLeadsResponseDTO>> _GetAllLeads() {
    final Uri $url = Uri.parse('/api/leads/get-all');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<GetAllLeadsResponseDTO, GetAllLeadsResponseDTO>($request);
  }

  @override
  Future<Response<dynamic>> _GetLeadsStats() {
    final Uri $url = Uri.parse('/api/leads/stats');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<LeadResponseDTO>> _GetLeadById({required String? leadId}) {
    final Uri $url = Uri.parse('/api/leads/${leadId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<LeadResponseDTO, LeadResponseDTO>($request);
  }

  @override
  Future<Response<MessageResponseDTO>> _UpdateLeadStatus(
      {required String? leadId}) {
    final Uri $url = Uri.parse('/api/leads/update-status/${leadId}');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<MessageResponseDTO, MessageResponseDTO>($request);
  }

  @override
  Future<Response<dynamic>> _uploadImage({required List<int> file}) {
    final Uri $url = Uri.parse('/images/upload');
    final List<PartValue> $parts = <PartValue>[
      PartValueFile<List<int>>(
        'file',
        file,
      )
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _createClient({required CreateClientDTO? body}) {
    final Uri $url = Uri.parse('/api/clients');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _getAllClients({
    String? q,
    String? status,
    String? sortBy,
    String? sortOrder,
    num? page,
    num? limit,
  }) {
    final Uri $url = Uri.parse('/api/clients');
    final Map<String, dynamic> $params = <String, dynamic>{
      'q': q,
      'status': status,
      'sortBy': sortBy,
      'sortOrder': sortOrder,
      'page': page,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _searchClients({
    String? q,
    String? status,
    String? sortBy,
    String? sortOrder,
    num? page,
    num? limit,
  }) {
    final Uri $url = Uri.parse('/api/clients/search');
    final Map<String, dynamic> $params = <String, dynamic>{
      'q': q,
      'status': status,
      'sortBy': sortBy,
      'sortOrder': sortOrder,
      'page': page,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _getClientById({required String? id}) {
    final Uri $url = Uri.parse('/api/clients/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _updateClient({
    required String? id,
    required UpdateClientDTO? body,
  }) {
    final Uri $url = Uri.parse('/api/clients/${id}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _deleteClient({required String? id}) {
    final Uri $url = Uri.parse('/api/clients/${id}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _uploadClientImage({required String? id}) {
    final Uri $url = Uri.parse('/api/clients/${id}/image');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _removeClientImage({required String? id}) {
    final Uri $url = Uri.parse('/api/clients/${id}/image');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
