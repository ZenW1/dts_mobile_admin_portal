import 'package:dts_admin_portal/core/services/toast_service.dart';
import 'package:dts_admin_portal/generated_code/swagger.swagger.dart';
import 'package:dts_admin_portal/shared/widgets/keyboard_dissmisable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/custom_image_picker.dart';
import '../../../../core/utils/validators.dart';

import '../../../../core/network/upload_service.dart';
import '../../../../core/utils/extensions.dart';

import '../providers/product_provider.dart';
import '../providers/product_color_provider.dart';
import '../providers/product_material_provider.dart';
import '../providers/ai_description_provider.dart';

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
  final _stockController = TextEditingController();
  final _discountController = TextEditingController();
  final _imageController = TextEditingController();

  String? _selectedCategoryId;
  List<String> _selectedColorIds = [];
  List<String> _selectedMaterialIds = [];
  List<String> _productImages = [];
  bool _isActive = true;
  bool _isLoading = false;
  bool _isEditing = false;
  final _uploadService = UploadService();

  @override
  void initState() {
    super.initState();
    _isEditing = widget.id != null;
    if (_isEditing) {
      _loadProduct();
    }
  }

  Future<void> _loadProduct() async {
    final productData = await ref.read(productByIdProvider(widget.id!).future);
    final product = productData?.data;
    if (product != null && mounted) {
      setState(() {
        _nameController.text = product.name;
        _descriptionController.text = product.description ?? '';
        _priceController.text = product.price.toString();
        _stockController.text = product.stock.toString();
        _discountController.text = product.discount?.toString() ?? '';
        // _imageController.text = product.image ?? '';
        _productImages = [];
        if (product.image != null && product.image!.isNotEmpty) {
          for (final item in product.image ?? []) {
            _productImages.add(item.image!);
          }
        }
        _selectedCategoryId = product.category?.id;
        _isActive = product.isActive ?? false;
        _selectedColorIds = product.colors ?? [];
        _selectedMaterialIds = product.materials ?? [];
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _discountController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final categoriesAsync = ref.watch(productCategoriesNotifierProvider);

    return KeyboardDissmisable(
      child: Scaffold(
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
                    color:
                        isDark ? AppColors.darkBorder : AppColors.lightBorder,
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- Basic Information Section ---
                      const Text('Basic Information',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600)),
                      const SizedBox(height: AppSpacing.md),

                      // Name
                      CustomTextField(
                        controller: _nameController,
                        label: 'Product Name',
                        hint: 'Enter the product name',
                        validator: (value) => Validators.required(value,
                            fieldName: 'Product name'),
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      // Description
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          _buildAiGenerateButton(isDark),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      CustomTextField(
                        controller: _descriptionController,
                        // label: 'Description', // Removed label since we use a custom row above
                        hint: 'Enter product description',
                        maxLines: 5,
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      const Divider(),

                      // --- Pricing & Inventory Section ---
                      const Text('Pricing & Inventory',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600)),
                      const SizedBox(height: AppSpacing.md),

                      LayoutBuilder(builder: (context, constraints) {
                        final isMobile = constraints.maxWidth < 400;
                        final priceField = CustomTextField(
                          controller: _priceController,
                          label: 'Price',
                          hint: 'Enter price',
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          prefixIcon: const Padding(
                            padding: EdgeInsets.only(left: 12, top: 12),
                            child: Text('\$',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                          ),
                          validator: (value) => Validators.combine([
                            (v) => Validators.required(v, fieldName: 'Price'),
                            (v) => Validators.positiveNumber(v,
                                fieldName: 'Price'),
                          ])(value),
                        );

                        final discountField = CustomTextField(
                          controller: _discountController,
                          label: 'Discount (%)',
                          hint: '0',
                          allowDecimal: false,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          validator: (value) {
                            if (value != null && value.isNotEmpty) {
                              final numValue = double.tryParse(value);
                              if (numValue == null ||
                                  numValue < 0 ||
                                  numValue > 100) {
                                return 'Enter a valid percentage (0-100)';
                              }
                            }
                            return null;
                          },
                        );

                        final stockField = CustomTextField(
                          controller: _stockController,
                          label: 'Stock Quantity',
                          allowDecimal: false,
                          hint: '0',
                          keyboardType: TextInputType.number,
                          validator: (value) => Validators.combine([
                            (v) => Validators.required(v, fieldName: 'Stock'),
                            (v) {
                              final numValue = int.tryParse(v ?? '');
                              if(numValue == null || numValue < 0) {
                                return 'Enter a valid stock quantity';
                              }
                              return null;
                            }
                          ])(value),
                        );

                        if (isMobile) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              priceField,
                              const SizedBox(height: AppSpacing.lg),
                              discountField,
                              const SizedBox(height: AppSpacing.lg),
                              stockField,
                            ],
                          );
                        }
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: priceField),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(child: discountField),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(child: stockField),
                          ],
                        );
                      }),
                      const SizedBox(height: AppSpacing.xl),
                      const Divider(),
                      const SizedBox(height: AppSpacing.xl),

                      // --- Categorization & Media Section ---
                      const Text('Categorization & Media',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600)),
                      const SizedBox(height: AppSpacing.md),

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
                        error: (_, __) =>
                            const Text('Error loading categories'),
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      // Image Picker
                      CustomImagePicker(
                        label: 'Product Images',
                        hint:
                            'Select or take photos of the product (multiple allowed)',
                        isMultiple: true,
                        initialImages: _productImages,
                        onImagesChanged: (images) {
                          setState(() {
                            _productImages = images;
                            _imageController.text =
                                images.isNotEmpty ? images.first : '';
                          });
                        },
                        uploadImmediately: false,
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      // Colors & Materials
                      _buildOptionsSection(isDark),

                      const SizedBox(height: AppSpacing.xl),
                      const Divider(),
                      const SizedBox(height: AppSpacing.xl),

                      // --- Status Section ---
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
                            activeThumbColor: AppColors.success,
                          ),
                          Text(
                            _isActive ? 'Active' : 'Inactive',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: _isActive
                                  ? AppColors.success
                                  : AppColors.error,
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
      ),
    );
  }

  Widget _buildOptionsSection(bool isDark) {
    final colorsAsync = ref.watch(productColorsNotifierProvider);
    final materialsAsync = ref.watch(productMaterialsNotifierProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Colors',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isDark ? AppColors.darkText : AppColors.lightText,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        colorsAsync.when(
          data: (colors) => Wrap(
            spacing: 8,
            runSpacing: 8,
            children: colors.map((color) {
              final isSelected = _selectedColorIds.contains(color.id);
              return FilterChip(
                showCheckmark: false,
                label: Text(color.name,
                    style: isDark
                        ? TextStyle(color: AppColors.darkText)
                        : TextStyle(color: AppColors.lightText)),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedColorIds.add(color.id);
                    } else {
                      _selectedColorIds.remove(color.id);
                    }
                  });
                },
                avatar: color.hexCode != null && color.hexCode!.startsWith('#')
                    ? Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Color(int.parse(
                              color.hexCode!.replaceAll('#', '0xFF'))),
                          shape: BoxShape.circle,
                        ),
                      )
                    : null,
              );
            }).toList(),
          ),
          loading: () => const LinearProgressIndicator(),
          error: (_, __) => const Text('Error loading colors'),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'Materials',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isDark ? AppColors.darkText : AppColors.lightText,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        materialsAsync.when(
          data: (materials) => Wrap(
            spacing: 8,
            runSpacing: 8,
            children: materials.map((material) {
              final isSelected = _selectedMaterialIds.contains(material.id);
              return FilterChip(
                label: Text(material.name,
                    style: isDark
                        ? TextStyle(color: AppColors.darkText)
                        : TextStyle(color: AppColors.lightText)),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedMaterialIds.add(material.id);
                    } else {
                      _selectedMaterialIds.remove(material.id);
                    }
                  });
                },
              );
            }).toList(),
          ),
          loading: () => const LinearProgressIndicator(),
          error: (_, __) => const Text('Error loading materials'),
        ),
      ],
    );
  }

  Widget _buildAiGenerateButton(bool isDark) {
    final aiState = ref.watch(aiDescriptionNotifierProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    ref.listen(aiDescriptionNotifierProvider, (previous, next) {
      next.when(
        data: (description) {
          if (description != null) {
            _descriptionController.text = description;
            ref.read(aiDescriptionNotifierProvider.notifier).reset();
          }
        },
        error: (error, _) {
          context.showSnackBar('AI Error: $error', isError: true);
        },
        loading: () {},
      );
    });

    return TextButton.icon(
      onPressed: aiState.isLoading
          ? null
          : () {
              final productName = _nameController.text.trim();
              if (productName.isEmpty) {
                context.showSnackBar('Please enter a product name first',
                    isError: true);
                return;
              }
              ref
                  .read(aiDescriptionNotifierProvider.notifier)
                  .generateDescription(productName);
            },
      icon: aiState.isLoading
          ? const SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(Iconsax.magicpen, size: 16),
      label: Text(aiState.isLoading ? 'Generating...' : 'Generate with AI'),
      style: TextButton.styleFrom(
        foregroundColor: isDark ? AppColors.white : AppColors.primary,
        textStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.darkText : AppColors.lightText),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // Step 1: Upload images if they are local files
      final List<String> finalImageUrls = [];
      for (final imagePath in _productImages) {
        if (imagePath.startsWith('http://') ||
            imagePath.startsWith('https://')) {
          finalImageUrls.add(imagePath);
        } else {
          // It's a local file, upload it
          final uploadedUrl = await _uploadService.uploadImageBytes(imagePath);
          if (uploadedUrl != null) {
            finalImageUrls.add(uploadedUrl);
          } else {
            throw Exception('Failed to upload image at $imagePath');
          }
        }
      }

      final discountValue = _discountController.text.trim();
      final product = CreateProductDTO(
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        price: double.parse(_priceController.text.trim()),
        stock: double.parse(_stockController.text.trim()),
        discount: discountValue.isEmpty ? null : double.parse(discountValue),
        image: finalImageUrls.isNotEmpty ? finalImageUrls : null,
        categoryId: _selectedCategoryId!,
        isActive: _isActive,
        colors: _selectedColorIds,
        materials: _selectedMaterialIds,
      );

      bool success = false;
      if (_isEditing) {
        if (widget.id == null) return;

        success = await ref
            .read(productsNotifierProvider.notifier)
            .updateProduct(product, widget.id!);
      } else {
        success = await ref
            .read(productsNotifierProvider.notifier)
            .addProduct(product);
      }

      if (mounted) {
        if (success) {
          ToastService.success(
            message: _isEditing
                ? 'Product updated successfully'
                : 'Product created successfully',
          );
          context.go('/products');
        } else {
          ToastService.error(
            message:
                'Failed to ${_isEditing ? 'update' : 'create'} product. Please check your data and try again.',
          );
        }
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
