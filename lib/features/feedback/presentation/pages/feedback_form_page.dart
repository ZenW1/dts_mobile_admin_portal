import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../../../core/utils/validators.dart';
import '../../domain/entities/customer_feedback.dart';
import '../providers/feedback_provider.dart';
import '../widgets/rating_widget.dart';
import '../../../../core/utils/extensions.dart';

/// Feedback create/edit form page
class FeedbackFormPage extends ConsumerStatefulWidget {
  final String? id;
  final CustomerFeedback? feedback;

  const FeedbackFormPage({super.key, this.id, this.feedback});

  @override
  ConsumerState<FeedbackFormPage> createState() => _FeedbackFormPageState();
}

class _FeedbackFormPageState extends ConsumerState<FeedbackFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _customerNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  int _rating = 5;
  bool _isLoading = false;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    if (widget.feedback != null) {
      _isEditing = true;
      _populateFields(widget.feedback!);
    } else if (widget.id != null) {
      _isEditing = true;
      _loadFeedback();
    }
  }

  void _populateFields(CustomerFeedback feedback) {
    _customerNameController.text = feedback.customerName ?? '';
    _emailController.text = feedback.email ?? '';
    _phoneController.text = feedback.phone ?? '';
    _subjectController.text = feedback.subject ?? '';
    _messageController.text = feedback.message ?? '';
    _rating = feedback.rating ?? 0;
  }

  Future<void> _loadFeedback() async {
    final feedback = await ref.read(feedbackByIdProvider(widget.id!).future);
    if (feedback != null && mounted) {
      setState(() {
        _populateFields(feedback);
      });
    }
  }

  @override
  void dispose() {
    _customerNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 600;

            return SingleChildScrollView(
              padding: EdgeInsets.all(isMobile ? AppSpacing.md : AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with back button
                  _buildHeader(isDark, isMobile),

                  SizedBox(height: isMobile ? AppSpacing.md : AppSpacing.xl),

                  // Form
                  Form(
                    key: _formKey,
                    child: Container(
                      padding: EdgeInsets.all(
                          isMobile ? AppSpacing.md : AppSpacing.xl),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.darkSurface
                            : AppColors.lightSurface,
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusMd),
                        border: Border.all(
                          color: isDark
                              ? AppColors.darkBorder
                              : AppColors.lightBorder,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Section title
                          Row(
                            children: [
                              Icon(
                                Iconsax.user,
                                size: 20,
                                color: isDark
                                    ? AppColors.primaryLight
                                    : AppColors.primary,
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              Text(
                                'Customer Information',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: isDark
                                      ? AppColors.darkText
                                      : AppColors.lightText,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.lg),

                          // Customer name and email — stacked on mobile
                          if (isMobile) ...[
                            CustomTextField(
                              controller: _customerNameController,
                              label: 'Customer Name',
                              hint: 'Enter customer name',
                              prefixIcon: const Icon(Iconsax.user, size: 20),
                              validator: (value) => Validators.required(value,
                                  fieldName: 'Customer name'),
                            ),
                            const SizedBox(height: AppSpacing.lg),
                            CustomTextField(
                              controller: _emailController,
                              label: 'Email',
                              hint: 'Enter email address',
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: const Icon(Iconsax.sms, size: 20),
                              validator: Validators.email,
                            ),
                          ] else
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    controller: _customerNameController,
                                    label: 'Customer Name',
                                    hint: 'Enter customer name',
                                    prefixIcon:
                                        const Icon(Iconsax.user, size: 20),
                                    validator: (value) => Validators.required(
                                        value,
                                        fieldName: 'Customer name'),
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.lg),
                                Expanded(
                                  child: CustomTextField(
                                    controller: _emailController,
                                    label: 'Email',
                                    hint: 'Enter email address',
                                    keyboardType: TextInputType.emailAddress,
                                    prefixIcon:
                                        const Icon(Iconsax.sms, size: 20),
                                    validator: Validators.email,
                                  ),
                                ),
                              ],
                            ),

                          const SizedBox(height: AppSpacing.lg),

                          // Phone — full width on mobile, constrained on desktop
                          if (isMobile)
                            CustomTextField(
                              controller: _phoneController,
                              label: 'Phone (optional)',
                              hint: 'Enter phone number',
                              keyboardType: TextInputType.phone,
                              prefixIcon: const Icon(Iconsax.call, size: 20),
                            )
                          else
                            SizedBox(
                              width: 400,
                              child: CustomTextField(
                                controller: _phoneController,
                                label: 'Phone (optional)',
                                hint: 'Enter phone number',
                                keyboardType: TextInputType.phone,
                                prefixIcon: const Icon(Iconsax.call, size: 20),
                              ),
                            ),

                          const SizedBox(height: AppSpacing.xl),
                          const Divider(),
                          const SizedBox(height: AppSpacing.xl),

                          // Feedback section
                          Row(
                            children: [
                              Icon(
                                Iconsax.message_text,
                                size: 20,
                                color: isDark
                                    ? AppColors.primaryLight
                                    : AppColors.primary,
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              Text(
                                'Feedback Details',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: isDark
                                      ? AppColors.darkText
                                      : AppColors.lightText,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.lg),

                          // Subject
                          CustomTextField(
                            controller: _subjectController,
                            label: 'Subject',
                            hint: 'Enter feedback subject',
                            prefixIcon: const Icon(Iconsax.text, size: 20),
                            validator: (value) => Validators.required(value,
                                fieldName: 'Subject'),
                          ),

                          const SizedBox(height: AppSpacing.lg),

                          // Message
                          CustomTextField(
                            controller: _messageController,
                            label: 'Message',
                            hint: 'Enter feedback message',
                            maxLines: 5,
                            validator: (value) => Validators.required(value,
                                fieldName: 'Message'),
                          ),

                          const SizedBox(height: AppSpacing.lg),

                          // Rating
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Rating',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: isDark
                                      ? AppColors.darkText
                                      : AppColors.lightText,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              Container(
                                padding: const EdgeInsets.all(AppSpacing.md),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? AppColors.darkBackground
                                      : AppColors.lightBackground,
                                  borderRadius: BorderRadius.circular(
                                      AppSpacing.radiusSm),
                                  border: Border.all(
                                    color: isDark
                                        ? AppColors.darkBorder
                                        : AppColors.lightBorder,
                                  ),
                                ),
                                child: isMobile
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RatingWidget(
                                            rating: _rating,
                                            size: 32,
                                            isInteractive: true,
                                            onRatingChanged: (value) {
                                              setState(() => _rating = value);
                                            },
                                          ),
                                          const SizedBox(height: AppSpacing.sm),
                                          Text(
                                            '$_rating out of 5',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: isDark
                                                  ? AppColors.darkTextSecondary
                                                  : AppColors
                                                      .lightTextSecondary,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          RatingWidget(
                                            rating: _rating,
                                            size: 32,
                                            isInteractive: true,
                                            onRatingChanged: (value) {
                                              setState(() => _rating = value);
                                            },
                                          ),
                                          const SizedBox(width: AppSpacing.md),
                                          Text(
                                            '$_rating out of 5',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: isDark
                                                  ? AppColors.darkTextSecondary
                                                  : AppColors
                                                      .lightTextSecondary,
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ],
                          ),

                          const SizedBox(height: AppSpacing.xl),

                          // Submit buttons
                          if (isMobile)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                GradientButton(
                                  onPressed: _isLoading ? null : _submitForm,
                                  icon: _isEditing
                                      ? Iconsax.tick_circle
                                      : Iconsax.add,
                                  text: _isLoading
                                      ? 'Saving...'
                                      : (_isEditing ? 'Update' : 'Create'),
                                ),
                                const SizedBox(height: AppSpacing.sm),
                                TextButton(
                                  onPressed: () => context.go('/feedbacks'),
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: isDark
                                          ? AppColors.darkTextSecondary
                                          : AppColors.lightTextSecondary,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          else
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () => context.go('/feedbacks'),
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: isDark
                                          ? AppColors.darkTextSecondary
                                          : AppColors.lightTextSecondary,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.md),
                                GradientButton(
                                  onPressed: _isLoading ? null : _submitForm,
                                  icon: _isEditing
                                      ? Iconsax.tick_circle
                                      : Iconsax.add,
                                  text: _isLoading
                                      ? 'Saving...'
                                      : (_isEditing ? 'Update' : 'Create'),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDark, bool isMobile) {
    return Row(
      children: [
        IconButton(
          onPressed: () => context.go('/feedbacks'),
          icon: const Icon(Iconsax.arrow_left),
          tooltip: 'Back',
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _isEditing ? 'Edit Feedback' : 'Add Feedback',
                style: TextStyle(
                  fontSize: isMobile ? 20 : 24,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.darkText : AppColors.lightText,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _isEditing
                    ? 'Update customer feedback details'
                    : 'Create a new customer feedback entry',
                style: TextStyle(
                  fontSize: isMobile ? 12 : 14,
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final feedback = CustomerFeedback(
        id: widget.id ?? '',
        customerName: _customerNameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim().isEmpty
            ? null
            : _phoneController.text.trim(),
        subject: _subjectController.text.trim(),
        message: _messageController.text.trim(),
        rating: _rating,
      );

      if (_isEditing) {
        await ref
            .read(feedbackNotifierProvider.notifier)
            .updateFeedback(feedback);
      } else {
        await ref.read(feedbackNotifierProvider.notifier).addFeedback(feedback);
      }

      // Refresh stats
      ref.read(feedbackStatsNotifierProvider.notifier).loadStats();

      if (mounted) {
        context.showSnackBar(
          _isEditing
              ? 'Feedback updated successfully'
              : 'Feedback created successfully',
        );
        context.go('/feedbacks');
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
