import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/utils/validators.dart';
import '../providers/product_color_provider.dart';

/// Create / Edit product color form
class ProductColorFormPage extends ConsumerStatefulWidget {
  final String? id;

  const ProductColorFormPage({super.key, this.id});

  @override
  ConsumerState<ProductColorFormPage> createState() =>
      _ProductColorFormPageState();
}

class _ProductColorFormPageState extends ConsumerState<ProductColorFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _hexController = TextEditingController();

  bool _isLoading = false;
  bool _isEditing = false;

  Color get _previewColor {
    final hex = _hexController.text.trim().replaceAll('#', '');
    if (hex.length >= 6) {
      try {
        return Color(int.parse('FF${hex.padLeft(6, '0')}', radix: 16));
      } catch (_) {}
    }
    return AppColors.primary;
  }

  @override
  void initState() {
    super.initState();
    _isEditing = widget.id != null;
    if (_isEditing) {
      _loadColor();
    }
  }

  Future<void> _loadColor() async {
    final color = await ref.read(productColorDetailProvider(widget.id!).future);
    if (color != null && mounted) {
      setState(() {
        _nameController.text = color.name;
        _hexController.text = color.hexCode ?? '';
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _hexController.dispose();
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
                  onPressed: () => context.go('/product-colors'),
                  icon: const Icon(Iconsax.arrow_left),
                ),
                const SizedBox(width: AppSpacing.md),
                Text(
                  _isEditing ? 'Edit Color' : 'Add Color',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),

            // Preview swatch
            AnimatedBuilder(
              animation: _hexController,
              builder: (context, _) {
                return Center(
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: _previewColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: _previewColor.withValues(alpha: 0.5),
                          blurRadius: 20,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        _hexController.text.isEmpty
                            ? '?'
                            : _hexController.text.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: _previewColor.computeLuminance() > 0.4
                              ? Colors.black87
                              : Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
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
                      label: 'Color Name',
                      hint: 'e.g. Midnight Blue',
                      validator: (value) =>
                          Validators.required(value, fieldName: 'Color name'),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Hex Code
                    CustomTextField(
                      controller: _hexController,
                      label: 'Hex Code',
                      hint: '#FF0000',
                      onChanged: (_) => setState(() {}),
                      validator: (value) {
                        if (value == null || value.isEmpty) return null;
                        final hex = value.replaceAll('#', '');
                        if (hex.length != 6) {
                          return 'Enter a valid 6-character hex code';
                        }
                        try {
                          int.parse(hex, radix: 16);
                        } catch (_) {
                          return 'Enter a valid hex code (e.g. #FF0000)';
                        }
                        return null;
                      },
                    ),

                    // Color chips palette
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'Quick pick',
                      style: TextStyle(
                        fontSize: 13,
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: _paletteColors.map((hex) {
                        Color c = Color(
                            int.parse('FF${hex.substring(1)}', radix: 16));
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _hexController.text = hex;
                            });
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: c,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: _hexController.text == hex
                                    ? Colors.white
                                    : Colors.transparent,
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: c.withValues(alpha: 0.4),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: AppSpacing.xl),
                    Row(
                      children: [
                        OutlinedButton(
                          onPressed: () => context.go('/product-colors'),
                          child: const Text('Cancel'),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: GradientButton(
                            text: _isEditing ? 'Update Color' : 'Create Color',
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

  static const _paletteColors = [
    '#EF4444',
    '#F97316',
    '#F59E0B',
    '#22C55E',
    '#14B8A6',
    '#3B82F6',
    '#8B5CF6',
    '#EC4899',
    '#10B981',
    '#6366F1',
    '#F43F5E',
    '#84CC16',
    '#1E3A8A',
    '#0F172A',
    '#FFFFFF',
    '#6B7280',
  ];

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final notifier = ref.read(productColorsNotifierProvider.notifier);
    bool success;

    if (_isEditing) {
      success = await notifier.updateColor(
        id: widget.id!,
        name: _nameController.text.trim(),
        hexCode: _hexController.text.trim().isEmpty
            ? null
            : _hexController.text.trim(),
      );
    } else {
      success = await notifier.createColor(
        name: _nameController.text.trim(),
        hexCode: _hexController.text.trim().isEmpty
            ? null
            : _hexController.text.trim(),
      );
    }

    if (mounted) {
      setState(() => _isLoading = false);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isEditing
                ? 'Color updated successfully'
                : 'Color created successfully'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        context.go('/product-colors');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isEditing
                ? 'Failed to update color'
                : 'Failed to create color'),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }
}
