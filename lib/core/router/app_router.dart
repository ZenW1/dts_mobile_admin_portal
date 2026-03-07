import 'package:go_router/go_router.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/products/presentation/pages/products_page.dart';
import '../../features/products/presentation/pages/product_detail_page.dart';
import '../../features/products/presentation/pages/product_form_page.dart';
import '../../features/products/presentation/pages/product_categories_page.dart';
import '../../features/portfolio/presentation/pages/portfolio_page.dart';
import '../../features/portfolio/presentation/pages/portfolio_detail_page.dart';
import '../../features/portfolio/presentation/pages/portfolio_form_page.dart';
import '../../features/portfolio/presentation/pages/portfolio_categories_page.dart';
import '../../features/jobs/presentation/pages/jobs_page.dart';
import '../../features/jobs/presentation/pages/job_detail_page.dart';
import '../../features/jobs/presentation/pages/job_form_page.dart';
import '../../features/feedback/presentation/pages/feedbacks_page.dart';
import '../../features/feedback/presentation/pages/feedback_detail_page.dart';
import '../../features/feedback/presentation/pages/feedback_form_page.dart';
import '../../features/feedback/domain/entities/customer_feedback.dart';
import '../../features/clients/presentation/pages/client_list_page.dart';
import '../../features/clients/presentation/pages/client_detail_page.dart';
import '../../features/clients/presentation/pages/client_form_page.dart';
import '../../features/clients/domain/entities/client.dart';
import '../../shared/layouts/admin_layout.dart';

/// Application router configuration
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => AdminLayout(child: child),
      routes: [
        // Dashboard
        GoRoute(
          path: '/',
          name: 'dashboard',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: DashboardPage(),
          ),
        ),

        // Products
        GoRoute(
          path: '/products',
          name: 'products',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ProductsPage(),
          ),
        ),
        GoRoute(
          path: '/products/new',
          name: 'product-new',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ProductFormPage(),
          ),
        ),
        GoRoute(
          path: '/products/:id',
          name: 'product-detail',
          pageBuilder: (context, state) => NoTransitionPage(
            child: ProductDetailPage(id: state.pathParameters['id']!),
          ),
        ),
        GoRoute(
          path: '/products/:id/edit',
          name: 'product-edit',
          pageBuilder: (context, state) => NoTransitionPage(
            child: ProductFormPage(id: state.pathParameters['id']),
          ),
        ),
        GoRoute(
          path: '/product-categories',
          name: 'product-categories',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ProductCategoriesPage(),
          ),
        ),

        // Portfolio
        GoRoute(
          path: '/portfolio',
          name: 'portfolio',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: PortfolioPage(),
          ),
        ),
        GoRoute(
          path: '/portfolio/new',
          name: 'portfolio-new',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: PortfolioFormPage(),
          ),
        ),
        GoRoute(
          path: '/portfolio/:id',
          name: 'portfolio-detail',
          pageBuilder: (context, state) => NoTransitionPage(
            child: PortfolioDetailPage(id: state.pathParameters['id']!),
          ),
        ),
        GoRoute(
          path: '/portfolio/:id/edit',
          name: 'portfolio-edit',
          pageBuilder: (context, state) => NoTransitionPage(
            child: PortfolioFormPage(id: state.pathParameters['id']),
          ),
        ),
        GoRoute(
          path: '/portfolio-categories',
          name: 'portfolio-categories',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: PortfolioCategoriesPage(),
          ),
        ),

        // Jobs
        GoRoute(
          path: '/jobs',
          name: 'jobs',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: JobsPage(),
          ),
        ),
        GoRoute(
          path: '/jobs/new',
          name: 'job-new',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: JobFormPage(),
          ),
        ),
        GoRoute(
          path: '/jobs/:id',
          name: 'job-detail',
          pageBuilder: (context, state) => NoTransitionPage(
            child: JobDetailPage(id: state.pathParameters['id']!),
          ),
        ),
        GoRoute(
          path: '/jobs/:id/edit',
          name: 'job-edit',
          pageBuilder: (context, state) => NoTransitionPage(
            child: JobFormPage(id: state.pathParameters['id']),
          ),
        ),

        // Customer Feedback
        GoRoute(
          path: '/feedbacks',
          name: 'feedbacks',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: FeedbacksPage(),
          ),
        ),
        GoRoute(
          path: '/feedbacks/new',
          name: 'feedback-new',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: FeedbackFormPage(),
          ),
        ),
        GoRoute(
          path: '/feedbacks/:id',
          name: 'feedback-detail',
          pageBuilder: (context, state) => NoTransitionPage(
            child: FeedbackDetailPage(id: state.pathParameters['id']!),
          ),
        ),
        GoRoute(
          path: '/feedbacks/:id/edit',
          name: 'feedback-edit',
          pageBuilder: (context, state) => NoTransitionPage(
            child: FeedbackFormPage(
              id: state.pathParameters['id'],
              feedback: state.extra as CustomerFeedback?,
            ),
          ),
        ),

        // Clients
        GoRoute(
          path: '/clients',
          name: 'clients',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ClientListPage(),
          ),
        ),
        GoRoute(
          path: '/clients/create',
          name: 'client-new',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ClientFormPage(),
          ),
        ),
        GoRoute(
          path: '/clients/:id',
          name: 'client-detail',
          pageBuilder: (context, state) => NoTransitionPage(
            child: ClientDetailPage(clientId: state.pathParameters['id']!),
          ),
        ),
        GoRoute(
          path: '/clients/edit/:id',
          name: 'client-edit',
          pageBuilder: (context, state) => NoTransitionPage(
            child: ClientFormPage(
              client: state.extra as Client?,
            ),
          ),
        ),
      ],
    ),
  ],
);
