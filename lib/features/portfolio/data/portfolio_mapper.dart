import '../../../../generated_code/swagger.swagger.dart';
import '../domain/entities/portfolio.dart';
import '../domain/entities/portfolio_category.dart';

extension PortfolioResponseDTOMapper on PortfolioResponseDTO {
  Portfolio toDomain() {
    return Portfolio(
      id: id,
      title: title,
      description: description,
      imageUrl: image.isNotEmpty ? image.first : '',
      galleryImages: image,
      categoryId: category?.id ?? '',
      clientName: $client,
      projectDate: startDate != null ? DateTime.tryParse(startDate!) : null,
      isFeatured: isActive ??
          false, // Assuming active implies featured for now or simply keeping the flag
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }
}

extension PortfolioMapper on Portfolio {
  CreatePortfolioDTO toDto() {
    return CreatePortfolioDTO(
      title: title,
      description: description ?? '',
      category: categoryId,
      projectUrl: '',
      $client: clientName,
      startDate: projectDate?.toIso8601String(),
      endDate: null,
      jobScope: null,
      isActive: isFeatured,
      image: [],
    );
  }
}

extension PortfolioCategoryResponseDTOMapper on PortfolioCategoryResponseDTO {
  PortfolioCategory toDomain() {
    return PortfolioCategory(
      id: id,
      name: name,
      description: description,
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }
}

extension PortfolioCategoryMapper on PortfolioCategory {
  CreatePortfolioCategoryDTO toDto() {
    return CreatePortfolioCategoryDTO(
      name: name,
      description: description,
      isActive: true,
    );
  }
}
