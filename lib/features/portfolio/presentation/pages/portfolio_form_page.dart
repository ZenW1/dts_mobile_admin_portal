import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../core/utils/validators.dart';
import 'package:dts_admin_portal/generated_code/swagger.swagger.dart';
import '../../../../core/network/upload_service.dart';
import '../../../../core/services/toast_service.dart';

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
  final _jobScopeController = TextEditingController();
  List<String> _projectImages = [];

  String? _selectedCategoryId;
  DateTimeRange? _projectDateRange;
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
        _imageUrlController.text =
            portfolio.image.isNotEmpty ? portfolio.image.first : '';
        _selectedCategoryId = portfolio.category?.id;
        _jobScopeController.text = portfolio.jobScope ?? '';
        _projectImages = List.from(
            portfolio.image.length > 1 ? portfolio.image.sublist(1) : []);

        DateTime? parsedStart = portfolio.startDate != null
            ? DateTime.tryParse(portfolio.startDate!)
            : null;
        DateTime? parsedEnd = portfolio.endDate != null
            ? DateTime.tryParse(portfolio.endDate!)
            : null;

        if (parsedStart != null && parsedEnd != null) {
          _projectDateRange = DateTimeRange(start: parsedStart, end: parsedEnd);
        } else if (parsedStart != null) {
          _projectDateRange =
              DateTimeRange(start: parsedStart, end: parsedStart);
        } else {
          _projectDateRange = null;
        }

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
    _jobScopeController.dispose();
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

                    // Main Project Image
                    CustomImagePicker(
                      label: 'Project Image',
                      hint: 'Select the main image for the project',
                      isMultiple: false,
                      uploadImmediately: false,
                      initialImages: _imageUrlController.text.isNotEmpty
                          ? [_imageUrlController.text]
                          : [],
                      onImagesChanged: (images) {
                        setState(() {
                          _imageUrlController.text =
                              images.isNotEmpty ? images.first : '';
                        });
                      },
                    ),
                    // if (_imageUrlController.text.isEmpty)
                    //   const Padding(
                    //     padding: EdgeInsets.only(top: 8.0),
                    //     child: Text(
                    //       'Project image is required',
                    //       style:
                    //           TextStyle(color: AppColors.error, fontSize: 12),
                    //     ),
                    //   ),
                    const SizedBox(height: AppSpacing.lg),

                    // Project Image Gallery
                    CustomImagePicker(
                      label: 'Project Gallery',
                      hint: 'Select additional images for this project',
                      isMultiple: true,
                      uploadImmediately: false,
                      initialImages: _projectImages,
                      onImagesChanged: (images) {
                        setState(() {
                          _projectImages = images;
                        });
                      },
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Client Name
                    CustomTextField(
                      controller: _clientNameController,
                      label: 'Client Name',
                      hint: 'Enter client name (optional)',
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Job Scope
                    CustomTextField(
                      controller: _jobScopeController,
                      label: 'Job Scope',
                      hint: 'Enter job scope (e.g. Mobile App Development)',
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
                        final dateRange = await showDateRangePicker(
                          context: context,
                          initialDateRange: _projectDateRange,
                          firstDate: DateTime(2000),
                          lastDate:
                              DateTime.now().add(const Duration(days: 365 * 5)),
                        );
                        if (dateRange != null) {
                          setState(() => _projectDateRange = dateRange);
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
                              _projectDateRange != null
                                  ? '${_projectDateRange!.start.day}/${_projectDateRange!.start.month}/${_projectDateRange!.start.year} - ${_projectDateRange!.end.day}/${_projectDateRange!.end.month}/${_projectDateRange!.end.year}'
                                  : 'Select date range (optional)',
                              style: TextStyle(
                                color: _projectDateRange != null
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

    if (_imageUrlController.text.trim().isEmpty) {
      if (mounted) {
        ToastService.error(message: 'Please select a project image');
      }
      return;
    }

    setState(() => _isLoading = true);

    try {
      final uploadService = UploadService();
      String mainImageUrl = _imageUrlController.text.trim();
      List<String> galleryUrls = [];

      // Upload main image if it's a local path
      if (!mainImageUrl.startsWith('http://') &&
          !mainImageUrl.startsWith('https://')) {
        final url = await uploadService.uploadImageBytes(mainImageUrl);
        if (url == null) {
          throw Exception('Failed to upload main project image.');
        }
        mainImageUrl = url;
      }

      // Upload gallery images if they are local paths
      for (String path in _projectImages) {
        if (!path.startsWith('http://') && !path.startsWith('https://')) {
          final url = await uploadService.uploadImageBytes(path);
          if (url == null) throw Exception('Failed to upload a gallery image.');
          galleryUrls.add(url);
        } else {
          galleryUrls.add(path);
        }
      }

      final dto = CreatePortfolioDTO(
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        category: _selectedCategoryId!,
        $client: _clientNameController.text.trim().isEmpty
            ? ''
            : _clientNameController.text.trim(),
        startDate: _projectDateRange?.start.toIso8601String(),
        projectUrl: mainImageUrl,
        endDate: _projectDateRange?.end.toIso8601String(),
        jobScope: _jobScopeController.text.trim().isEmpty
            ? ''
            : _jobScopeController.text.trim(),
        image: [
          mainImageUrl,
          ...galleryUrls,
        ],
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
        ToastService.success(
          message: _isEditing
              ? 'Portfolio updated successfully'
              : 'Portfolio created successfully',
        );
        context.go('/portfolio');
      }
    } catch (e) {
      if (mounted) {
        ToastService.error(message: 'Error: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}
