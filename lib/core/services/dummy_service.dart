import '../../features/feedback/domain/entities/customer_feedback.dart';
import '../../features/portfolio/domain/entities/portfolio.dart';
import '../../features/portfolio/domain/entities/portfolio_category.dart';
import '../../features/products/domain/entities/product_category.dart';
import '../../generated_code/swagger.swagger.dart';

/// Centralized service for all mock/dummy data used in the application.
class DummyService {
  DummyService._();

  // --- Products ---

  /// Mock product for skeleton loading
  static const mockProductForSkeleton = ProductResponseDTO(
    id: '1',
    name: 'Premium Luxury Product Name',
    image: ['https://via.placeholder.com/400x400.png?text=Product+Image'],
    description:
        'This is a long description placeholder for the skeleton loading effect. It should look like real content.',
    price: 999.99,
    stock: 100,
    isActive: true,
    createdAt: null,
    updatedAt: null,
  );

  /// Mock category for skeleton loading
  static final mockCategoryForSkeleton = ProductCategory(
    id: '1',
    name: 'Category Name',
  );

  /// Mock product categories
  static final List<ProductCategory> productCategories = [
    ProductCategory(
      id: 'cat-1',
      name: 'Furniture',
      description: 'Home and office furniture products',
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
    ),
    ProductCategory(
      id: 'cat-2',
      name: 'Lighting',
      description: 'Indoor and outdoor lighting solutions',
      createdAt: DateTime.now().subtract(const Duration(days: 25)),
    ),
    ProductCategory(
      id: 'cat-3',
      name: 'Decor',
      description: 'Decorative items and accessories',
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
    ),
    ProductCategory(
      id: 'cat-4',
      name: 'Textiles',
      description: 'Fabrics, curtains, and upholstery',
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
    ),
    ProductCategory(
      id: 'cat-5',
      name: 'Art & Prints',
      description: 'Wall art, paintings, and prints',
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
    ),
  ];

  // --- Portfolio ---

  /// Mock portfolio categories
  static final List<PortfolioCategory> portfolioCategories = [
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

  // --- Feedback ---

  /// Mock customer feedbacks
  static final List<CustomerFeedback> feedbacks = [
    CustomerFeedback(
      id: 'fb-001',
      customerName: 'John Doe',
      email: 'john.doe@example.com',
      phone: '+1234567890',
      message:
          'Great product quality and excellent customer service! The team was very responsive and helpful throughout the process.',
      rating: 5,
      subject: 'Product Quality Feedback',
      status: FeedbackStatus.pending,
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    CustomerFeedback(
      id: 'fb-002',
      customerName: 'Jane Smith',
      email: 'jane.smith@example.com',
      phone: '+0987654321',
      message:
          'The delivery was faster than expected. Very impressed with the packaging quality.',
      rating: 4,
      subject: 'Delivery Experience',
      status: FeedbackStatus.reviewed,
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      updatedAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    CustomerFeedback(
      id: 'fb-003',
      customerName: 'Robert Johnson',
      email: 'robert.j@example.com',
      phone: '+1122334455',
      message:
          'Had an issue with my order initially, but the support team resolved it quickly. Appreciate the prompt response.',
      rating: 4,
      subject: 'Customer Support',
      status: FeedbackStatus.resolved,
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      updatedAt: DateTime.now().subtract(const Duration(days: 4)),
    ),
    CustomerFeedback(
      id: 'fb-004',
      customerName: 'Emily Davis',
      email: 'emily.d@example.com',
      message:
          'Love the new designs! Will definitely recommend to friends and family.',
      rating: 5,
      subject: 'Design Appreciation',
      status: FeedbackStatus.pending,
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      updatedAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    CustomerFeedback(
      id: 'fb-005',
      customerName: 'Michael Brown',
      email: 'michael.b@example.com',
      phone: '+5544332211',
      message:
          'Good products but could improve on the customization options available.',
      rating: 3,
      subject: 'Product Suggestions',
      status: FeedbackStatus.reviewed,
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      updatedAt: DateTime.now().subtract(const Duration(days: 6)),
    ),
    CustomerFeedback(
      id: 'fb-006',
      customerName: 'Sarah Wilson',
      email: 'sarah.w@example.com',
      phone: '+6677889900',
      message:
          'The installation service was professional and efficient. Very happy with the results!',
      rating: 5,
      subject: 'Installation Service',
      status: FeedbackStatus.resolved,
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      updatedAt: DateTime.now().subtract(const Duration(days: 8)),
    ),
    CustomerFeedback(
      id: 'fb-007',
      customerName: 'David Lee',
      email: 'david.lee@example.com',
      message:
          'Pricing is competitive. Would like to see more discount options for bulk orders.',
      rating: 4,
      subject: 'Pricing Feedback',
      status: FeedbackStatus.pending,
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(hours: 12)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 12)),
    ),
    CustomerFeedback(
      id: 'fb-008',
      customerName: 'Lisa Anderson',
      email: 'lisa.a@example.com',
      phone: '+1234509876',
      message:
          'Website is easy to navigate. Would appreciate a mobile app for easier ordering.',
      rating: 4,
      subject: 'Website Experience',
      status: FeedbackStatus.reviewed,
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 4)),
      updatedAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
  ];
}
