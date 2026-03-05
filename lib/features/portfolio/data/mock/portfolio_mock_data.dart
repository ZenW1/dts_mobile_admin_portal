import '../../domain/entities/portfolio.dart';
import '../../domain/entities/portfolio_category.dart';

/// Mock data for portfolio
class PortfolioMockData {
  PortfolioMockData._();

  /// Mock categories
  static final List<PortfolioCategory> categories = [
    PortfolioCategory(
      id: 'pcat-1',
      name: 'Residential',
      description: 'Home and residential design projects',
      createdAt: DateTime.now().subtract(const Duration(days: 60)),
    ),
    PortfolioCategory(
      id: 'pcat-2',
      name: 'Commercial',
      description: 'Office, retail, and business spaces',
      createdAt: DateTime.now().subtract(const Duration(days: 55)),
    ),
    PortfolioCategory(
      id: 'pcat-3',
      name: 'Hospitality',
      description: 'Hotels, restaurants, and entertainment venues',
      createdAt: DateTime.now().subtract(const Duration(days: 50)),
    ),
    PortfolioCategory(
      id: 'pcat-4',
      name: 'Exterior',
      description: 'Landscape and outdoor design',
      createdAt: DateTime.now().subtract(const Duration(days: 45)),
    ),
  ];

  /// Mock portfolio items
  static final List<Portfolio> portfolios = [
    Portfolio(
      id: 'port-1',
      title: 'Modern Minimalist Villa',
      description:
          'A stunning contemporary villa featuring clean lines, open spaces, and a seamless blend of indoor-outdoor living. The design emphasizes natural light and sustainable materials.',
      categoryId: 'pcat-1',
      clientName: 'The Johnson Family',
      projectDate: DateTime(2024, 3, 15),
      isFeatured: true,
      createdAt: DateTime.now().subtract(const Duration(days: 45)),
    ),
    Portfolio(
      id: 'port-2',
      title: 'Urban Loft Apartment',
      description:
          'Industrial-chic loft conversion with exposed brick, polished concrete floors, and custom steel fixtures. Perfect blend of raw industrial elements with modern comfort.',
      categoryId: 'pcat-1',
      clientName: 'Mark & Sarah Chen',
      projectDate: DateTime(2024, 2, 20),
      isFeatured: true,
      createdAt: DateTime.now().subtract(const Duration(days: 40)),
    ),
    Portfolio(
      id: 'port-3',
      title: 'Tech Startup Headquarters',
      description:
          'Dynamic workspace designed to foster creativity and collaboration. Features hot-desking areas, private pods, and a stunning central atrium.',
      categoryId: 'pcat-2',
      clientName: 'InnovateTech Inc.',
      projectDate: DateTime(2024, 1, 10),
      isFeatured: true,
      createdAt: DateTime.now().subtract(const Duration(days: 35)),
    ),
    Portfolio(
      id: 'port-4',
      title: 'Boutique Retail Store',
      description:
          'Luxury retail space with custom display solutions, ambient lighting design, and a VIP lounge area. Focus on creating an immersive shopping experience.',
      categoryId: 'pcat-2',
      clientName: 'Luxe Fashion House',
      projectDate: DateTime(2023, 12, 5),
      isFeatured: false,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
    ),
    Portfolio(
      id: 'port-5',
      title: 'Five-Star Hotel Lobby',
      description:
          'Grand hotel lobby redesign featuring a custom chandelier installation, marble flooring, and bespoke furniture pieces. Exudes elegance and sophistication.',
      categoryId: 'pcat-3',
      clientName: 'Grand Palace Hotels',
      projectDate: DateTime(2023, 11, 20),
      isFeatured: true,
      createdAt: DateTime.now().subtract(const Duration(days: 25)),
    ),
    Portfolio(
      id: 'port-6',
      title: 'Farm-to-Table Restaurant',
      description:
          'Rustic yet refined restaurant interior that celebrates local craftsmanship. Features reclaimed wood, custom pottery displays, and an open kitchen concept.',
      categoryId: 'pcat-3',
      clientName: 'Harvest Kitchen Co.',
      projectDate: DateTime(2023, 10, 15),
      isFeatured: false,
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
    ),
    Portfolio(
      id: 'port-7',
      title: 'Rooftop Garden Terrace',
      description:
          'Urban oasis featuring native plants, a water feature, and multiple seating zones. Sustainable irrigation system and low-maintenance landscaping.',
      categoryId: 'pcat-4',
      clientName: 'Greenview Towers',
      projectDate: DateTime(2023, 9, 1),
      isFeatured: false,
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
    ),
    Portfolio(
      id: 'port-8',
      title: 'Coastal Beach House',
      description:
          'Breezy coastal retreat with whitewashed walls, natural textures, and panoramic ocean views. Designed to maximize the connection with the surrounding landscape.',
      categoryId: 'pcat-1',
      clientName: 'The Williams Family',
      projectDate: DateTime(2023, 8, 10),
      isFeatured: true,
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
    ),
  ];
}
