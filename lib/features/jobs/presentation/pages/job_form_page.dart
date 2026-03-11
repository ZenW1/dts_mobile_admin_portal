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

import '../../../../generated_code/swagger.swagger.dart';
import '../providers/job_provider.dart';

/// Job create/edit form page
class JobFormPage extends ConsumerStatefulWidget {
  final String? id;

  const JobFormPage({super.key, this.id});

  @override
  ConsumerState<JobFormPage> createState() => _JobFormPageState();
}

class _JobFormPageState extends ConsumerState<JobFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _salaryController = TextEditingController();

  String _selectedType =
      'full-time'; // Default to match API value or label? API uses lower-kebab-case usually, or just string. DTO type is String. I will use a simple list of strings.
  // Actually, I should probably stick to the predefined types but as strings.
  final List<String> _jobTypes = [
    'full-time',
    'part-time',
    'contract',
    'freelance',
    'internship'
  ];

  bool _isActive = true;
  bool _isLoading = false;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.id != null;
    if (_isEditing) {
      _loadJob();
    }
  }

  Future<void> _loadJob() async {
    final job = await ref.read(jobByIdProvider(widget.id!).future);
    if (job != null && mounted) {
      setState(() {
        _titleController.text = job.title ?? '';
        _descriptionController.text = job.description ?? '';
        _locationController.text = job.location ?? '';
        _salaryController.text = job.salary ?? '';
        _selectedType = job.type ?? 'full-time';
        _isActive = job.isActive ?? true;
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _salaryController.dispose();
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
                  onPressed: () => context.go('/jobs'),
                  icon: const Icon(Iconsax.arrow_left),
                  tooltip: 'Back',
                ),
                const SizedBox(width: AppSpacing.md),
                Text(
                  _isEditing ? 'Edit Job' : 'Post New Job',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),

            // Form
            Container(
              constraints: const BoxConstraints(maxWidth: 800),
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
                      label: 'Job Title',
                      hint: 'e.g., Senior Interior Designer',
                      validator: (value) =>
                          Validators.required(value, fieldName: 'Job title'),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Description
                    CustomTextField(
                      controller: _descriptionController,
                      label: 'Job Description',
                      hint: 'Describe the role and responsibilities...',
                      maxLines: 5,
                      validator: (value) =>
                          Validators.required(value, fieldName: 'Description'),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Type and Active row
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Job Type',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: isDark
                                      ? AppColors.darkText
                                      : AppColors.lightText,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              DropdownButtonFormField<String>(
                                value: _selectedType,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: isDark
                                      ? AppColors.darkSurface
                                      : AppColors.lightSurface,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppSpacing.radiusSm),
                                  ),
                                ),
                                items: _jobTypes.map((type) {
                                  return DropdownMenuItem(
                                    value: type,
                                    child: Text(type
                                        .replaceAll('-', ' ')
                                        .toUpperCase()),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(() => _selectedType = value);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: AppSpacing.lg),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Active',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: isDark
                                    ? AppColors.darkText
                                    : AppColors.lightText,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Switch(
                              value: _isActive,
                              onChanged: (value) =>
                                  setState(() => _isActive = value),
                              activeTrackColor: AppColors.success,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Location
                    CustomTextField(
                      controller: _locationController,
                      label: 'Location',
                      hint: 'e.g., Jakarta, Indonesia',
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Salary
                    CustomTextField(
                      controller: _salaryController,
                      label: 'Salary',
                      hint: 'e.g., Rp 5,000,000 - 10,000,000',
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // Actions
                    Row(
                      children: [
                        OutlinedButton(
                          onPressed: () => context.go('/jobs'),
                          child: const Text('Cancel'),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: GradientButton(
                            text: _isEditing ? 'Update Job' : 'Post Job',
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
      final job = CreateCareerDTO(
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        location: _locationController.text.trim().isEmpty
            ? null
            : _locationController.text.trim(),
        type: _selectedType,
        salary: _salaryController.text.trim().isEmpty
            ? null
            : _salaryController.text.trim(),
        isActive: _isActive,
      );

      if (_isEditing) {
        await ref
            .read(jobsNotifierProvider.notifier)
            .updateJob(widget.id!, job);
      } else {
        await ref.read(jobsNotifierProvider.notifier).addJob(job);
      }

      if (mounted) {
        ToastService.success(
          message: _isEditing
              ? 'Job updated successfully'
              : 'Job posted successfully',
        );
        context.go('/jobs');
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
