import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/services/toast_service.dart';

import '../providers/product_material_provider.dart';

/// Create / Edit product material form
class ProductMaterialFormPage extends ConsumerStatefulWidget {
  final String? id;

  const ProductMaterialFormPage({super.key, this.id});

  @override
  ConsumerState<ProductMaterialFormPage> createState() =>
      _ProductMaterialFormPageState();
}

class _ProductMaterialFormPageState
    extends ConsumerState<ProductMaterialFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  bool _isLoading = false;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.id != null;
    if (_isEditing) {
      _loadMaterial();
    }
  }

  Future<void> _loadMaterial() async {
    final material =
        await ref.read(productMaterialDetailProvider(widget.id!).future);
    if (material != null && mounted) {
      setState(() {
        _nameController.text = material.name;
        _descriptionController.text = material.description ?? '';
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
                  onPressed: () => context.go('/product-materials'),
                  icon: const Icon(Iconsax.arrow_left),
                ),
                const SizedBox(width: AppSpacing.md),
                Text(
                  _isEditing ? 'Edit Material' : 'Add Material',
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
                    CustomTextField(
                      controller: _nameController,
                      label: 'Material Name',
                      hint: 'e.g. Oak Wood, Cotton, Leather',
                      validator: (value) => Validators.required(value,
                          fieldName: 'Material name'),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    CustomTextField(
                      controller: _descriptionController,
                      label: 'Description',
                      hint: 'Describe this material...',
                      maxLines: 4,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Row(
                      children: [
                        OutlinedButton(
                          onPressed: () => context.go('/product-materials'),
                          child: const Text('Cancel'),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: GradientButton(
                            text: _isEditing
                                ? 'Update Material'
                                : 'Create Material',
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

    final notifier = ref.read(productMaterialsNotifierProvider.notifier);
    bool success;

    if (_isEditing) {
      success = await notifier.updateMaterial(
        id: widget.id!,
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
      );
    } else {
      success = await notifier.createMaterial(
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
      );
    }

    if (mounted) {
      setState(() => _isLoading = false);
      if (success) {
        ToastService.success(
          message: _isEditing
              ? 'Material updated successfully'
              : 'Material created successfully',
        );
        context.go('/product-materials');
      } else {
        ToastService.error(
          message: _isEditing
              ? 'Failed to update material'
              : 'Failed to create material',
        );
      }
    }
  }
}
