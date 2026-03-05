import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/utils/validators.dart';
import '../../domain/entities/product.dart';
import '../providers/product_provider.dart';

/// Product create/edit form page
class ProductFormPage extends ConsumerStatefulWidget {
  final String? id;

  const ProductFormPage({super.key, this.id});

  @override
  ConsumerState<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends ConsumerState<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  String? _selectedCategoryId;
  bool _isActive = true;
  bool _isLoading = false;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.id != null;
    if (_isEditing) {
      _loadProduct();
    }
  }

  Future<void> _loadProduct() async {
    final product = await ref.read(productByIdProvider(widget.id!).future);
    if (product != null && mounted) {
      setState(() {
        _nameController.text = product.name;
        _descriptionController.text = product.description ?? '';
        _priceController.text = product.price.toString();
        _selectedCategoryId = product.categoryId;
        _isActive = product.isActive;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final categoriesAsync = ref.watch(productCategoriesNotifierProvider);

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
                  onPressed: () => context.go('/products'),
                  icon: const Icon(Iconsax.arrow_left),
                  tooltip: 'Back',
                ),
                const SizedBox(width: AppSpacing.md),
                Text(
                  _isEditing ? 'Edit Product' : 'Add Product',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),

            // Form
            Container(
              constraints: const BoxConstraints(maxWidth: 600),
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
                    // Name
                    CustomTextField(
                      controller: _nameController,
                      label: 'Product Name',
                      hint: 'Enter the product name',
                      validator: (value) =>
                          Validators.required(value, fieldName: 'Product name'),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Description
                    CustomTextField(
                      controller: _descriptionController,
                      label: 'Description',
                      hint: 'Enter product description',
                      maxLines: 4,
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Price
                    CustomTextField(
                      controller: _priceController,
                      label: 'Price',
                      hint: 'Enter price',
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Text(
                          '\$',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      validator: (value) => Validators.combine([
                        (v) => Validators.required(v, fieldName: 'Price'),
                        (v) => Validators.positiveNumber(v, fieldName: 'Price'),
                      ])(value),
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
                        value: _selectedCategoryId,
                        decoration: InputDecoration(
                          hintText: 'Select a category',
                          filled: true,
                          fillColor: isDark
                              ? AppColors.darkSurface
                              : AppColors.lightSurface,
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(AppSpacing.radiusSm),
                            borderSide: BorderSide(
                              color: isDark
                                  ? AppColors.darkBorder
                                  : AppColors.lightBorder,
                            ),
                          ),
                        ),
                        items: categories.map((cat) {
                          return DropdownMenuItem(
                            value: cat.id,
                            child: Text(cat.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() => _selectedCategoryId = value);
                        },
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

                    // Active toggle
                    Row(
                      children: [
                        Text(
                          'Status',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: isDark
                                ? AppColors.darkText
                                : AppColors.lightText,
                          ),
                        ),
                        const Spacer(),
                        Switch(
                          value: _isActive,
                          onChanged: (value) {
                            setState(() => _isActive = value);
                          },
                          activeColor: AppColors.success,
                        ),
                        Text(
                          _isActive ? 'Active' : 'Inactive',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color:
                                _isActive ? AppColors.success : AppColors.error,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // Actions
                    Row(
                      children: [
                        OutlinedButton(
                          onPressed: () => context.go('/products'),
                          child: const Text('Cancel'),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: GradientButton(
                            text: _isEditing
                                ? 'Update Product'
                                : 'Create Product',
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
      final product = Product(
        id: widget.id,
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        price: double.parse(_priceController.text.trim()),
        categoryId: _selectedCategoryId!,
        isActive: _isActive,
      );

      if (_isEditing) {
        await ref
            .read(productsNotifierProvider.notifier)
            .updateProduct(product);
      } else {
        await ref.read(productsNotifierProvider.notifier).addProduct(product);
      }

      if (mounted) {
        context.showSnackBar(
          _isEditing
              ? 'Product updated successfully'
              : 'Product created successfully',
        );
        context.go('/products');
      }
    } catch (e) {
      if (mounted) {
        context.showSnackBar('Error: $e', isError: true);
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}

extension on BuildContext {
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? AppColors.error : null,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
