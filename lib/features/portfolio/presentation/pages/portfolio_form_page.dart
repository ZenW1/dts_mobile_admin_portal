import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/utils/validators.dart';
import 'package:dts_admin_portal/generated_code/swagger.swagger.dart';
import '../providers/portfolio_provider.dart';

/// Portfolio create/edit form page
class PortfolioFormPage extends ConsumerStatefulWidget {
  final String? id;

  const PortfolioFormPage({super.key, this.id});

  @override
  ConsumerState<PortfolioFormPage> createState() => _PortfolioFormPageState();
}

class _PortfolioFormPageState extends ConsumerState<PortfolioFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _clientNameController = TextEditingController();
  final _imageUrlController = TextEditingController();

  String? _selectedCategoryId;
  DateTime? _projectDate;
  bool _isActive = false;
  bool _isLoading = false;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.id != null;
    if (_isEditing) {
      _loadPortfolio();
    }
  }

  Future<void> _loadPortfolio() async {
    final portfolios = await ref.read(portfolioByIdProvider(widget.id!).future);
    final portfolio = portfolios?.data;
    if (portfolio != null && mounted) {
      setState(() {
        _titleController.text = portfolio.title;
        _descriptionController.text = portfolio.description;
        _clientNameController.text = portfolio.$client ?? '';
        _imageUrlController.text = portfolio.imageUrl;
        _selectedCategoryId = portfolio.category?.id;
        _projectDate = portfolio.startDate != null
            ? DateTime.tryParse(portfolio.startDate!)
            : null;
        _isActive = portfolio.isActive ?? false;
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _clientNameController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final categoriesAsync = ref.watch(portfolioCategoriesNotifierProvider);

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                IconButton(
                  onPressed: () => context.go('/portfolio'),
                  icon: const Icon(Iconsax.arrow_left),
                  tooltip: 'Back',
                ),
                const SizedBox(width: AppSpacing.md),
                Text(
                  _isEditing ? 'Edit Portfolio' : 'Add Portfolio',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),

            // Form
            Container(
              constraints: const BoxConstraints(maxWidth: 700),
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : AppColors.lightCard,
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                border: Border.all(
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                ),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    CustomTextField(
                      controller: _titleController,
                      label: 'Project Title',
                      hint: 'Enter project title',
                      validator: (value) =>
                          Validators.required(value, fieldName: 'Title'),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Description
                    CustomTextField(
                      controller: _descriptionController,
                      label: 'Description',
                      hint: 'Describe the project...',
                      maxLines: 5,
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Image URL
                    CustomTextField(
                      controller: _imageUrlController,
                      label: 'Image URL',
                      hint: 'Enter image URL',
                      validator: (value) =>
                          Validators.required(value, fieldName: 'Image URL'),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Client Name
                    CustomTextField(
                      controller: _clientNameController,
                      label: 'Client Name',
                      hint: 'Enter client name (optional)',
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Category
                    Text(
                      'Category',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color:
                            isDark ? AppColors.darkText : AppColors.lightText,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    categoriesAsync.when(
                      data: (categories) => DropdownButtonFormField<String>(
                        initialValue: _selectedCategoryId,
                        decoration: InputDecoration(
                          hintText: 'Select a category',
                          filled: true,
                          fillColor: isDark
                              ? AppColors.darkSurface
                              : AppColors.lightSurface,
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(AppSpacing.radiusSm),
                          ),
                        ),
                        items: categories.map((cat) {
                          return DropdownMenuItem(
                            value: cat.id,
                            child: Text(cat.name),
                          );
                        }).toList(),
                        onChanged: (value) =>
                            setState(() => _selectedCategoryId = value),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a category';
                          }
                          return null;
                        },
                      ),
                      loading: () => const LinearProgressIndicator(),
                      error: (_, __) => const Text('Error loading categories'),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Project Date
                    Text(
                      'Project Date',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color:
                            isDark ? AppColors.darkText : AppColors.lightText,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    InkWell(
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: _projectDate ?? DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate:
                              DateTime.now().add(const Duration(days: 365)),
                        );
                        if (date != null) {
                          setState(() => _projectDate = date);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppColors.darkSurface
                              : AppColors.lightSurface,
                          borderRadius:
                              BorderRadius.circular(AppSpacing.radiusSm),
                          border: Border.all(
                            color: isDark
                                ? AppColors.darkBorder
                                : AppColors.lightBorder,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Iconsax.calendar,
                              size: 20,
                              color: isDark
                                  ? AppColors.darkTextSecondary
                                  : AppColors.lightTextSecondary,
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Text(
                              _projectDate != null
                                  ? '${_projectDate!.day}/${_projectDate!.month}/${_projectDate!.year}'
                                  : 'Select date (optional)',
                              style: TextStyle(
                                color: _projectDate != null
                                    ? (isDark
                                        ? AppColors.darkText
                                        : AppColors.lightText)
                                    : (isDark
                                        ? AppColors.darkTextSecondary
                                        : AppColors.lightTextSecondary),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Active toggle
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: _isActive
                            ? AppColors.primary.withValues(alpha: 0.05)
                            : (isDark
                                ? AppColors.darkSurface
                                : AppColors.lightSurface),
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusSm),
                        border: Border.all(
                          color: _isActive
                              ? AppColors.primary.withValues(alpha: 0.3)
                              : (isDark
                                  ? AppColors.darkBorder
                                  : AppColors.lightBorder),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _isActive ? Iconsax.star5 : Iconsax.star,
                            color: _isActive
                                ? Colors.amber
                                : (isDark
                                    ? AppColors.darkTextSecondary
                                    : AppColors.lightTextSecondary),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Active / Featured',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: isDark
                                        ? AppColors.darkText
                                        : AppColors.lightText,
                                  ),
                                ),
                                Text(
                                  'Display this project as active/featured',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDark
                                        ? AppColors.darkTextSecondary
                                        : AppColors.lightTextSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: _isActive,
                            onChanged: (value) =>
                                setState(() => _isActive = value),
                            activeThumbColor: AppColors.primary,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // Actions
                    Row(
                      children: [
                        OutlinedButton(
                          onPressed: () => context.go('/portfolio'),
                          child: const Text('Cancel'),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: GradientButton(
                            text: _isEditing
                                ? 'Update Portfolio'
                                : 'Create Portfolio',
                            isLoading: _isLoading,
                            onPressed: _submitForm,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final dto = CreatePortfolioDTO(
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        category: _selectedCategoryId!,
        imageUrl: _imageUrlController.text.trim(),
        $client: _clientNameController.text.trim().isEmpty
            ? null
            : _clientNameController.text.trim(),
        startDate: _projectDate?.toIso8601String(),
        endDate: null,
        jobScope: null,
        images: [],
        isActive: _isActive,
      );

      if (_isEditing) {
        await ref
            .read(portfoliosNotifierProvider.notifier)
            .updatePortfolio(widget.id!, dto);
      } else {
        await ref.read(portfoliosNotifierProvider.notifier).addPortfolio(dto);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isEditing
                ? 'Portfolio updated successfully'
                : 'Portfolio created successfully'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        context.go('/portfolio');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}
