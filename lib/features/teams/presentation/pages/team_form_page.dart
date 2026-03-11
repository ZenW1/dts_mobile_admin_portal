import 'package:dts_admin_portal/generated_code/swagger.swagger.dart';
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
import '../../../../core/services/toast_service.dart';
import '../../../../shared/widgets/keyboard_dissmisable.dart';
import '../../domain/entities/team_member.dart';
import '../providers/team_provider.dart';

/// Team member create/edit form page
class TeamFormPage extends ConsumerStatefulWidget {
  final String? id;

  const TeamFormPage({super.key, this.id});

  @override
  ConsumerState<TeamFormPage> createState() => _TeamFormPageState();
}

class _TeamFormPageState extends ConsumerState<TeamFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _roleController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _avatarUrl;
  bool _isActive = true;
  bool _isLoading = false;
  bool _isEditing = false;
  final _uploadService = UploadService();

  @override
  void initState() {
    super.initState();
    _isEditing = widget.id != null;
    if (_isEditing) {
      _loadTeamMember();
    }
  }

  Future<void> _loadTeamMember() async {
    setState(() => _isLoading = true);
    try {
      final repository = ref.read(teamRepositoryProvider);
      final memberData = await repository.getTeamById(widget.id!);
      final member = memberData.data;
      if (mounted) {
        setState(() {
          _nameController.text = member.name;
          _roleController.text = member.role ?? '';
          _descriptionController.text = member.description ?? '';
          _avatarUrl = member.avatar;
          _isActive = member.isActive ?? false;
        });
      }
    } catch (e) {
      if (mounted) {
        ToastService.error(message: 'Failed to load team member: $e');
        context.go('/teams');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _roleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final teamState = ref.watch(teamNotifierProvider);

    return KeyboardDissmisable(
      child: Scaffold(
        backgroundColor:
            isDark ? AppColors.darkBackground : AppColors.lightBackground,
        body: _isLoading && _isEditing
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => context.go('/teams'),
                          icon: const Icon(Iconsax.arrow_left),
                          tooltip: 'Back',
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Text(
                          _isEditing ? 'Edit Member' : 'Add Member',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // Form
                    Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 600),
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        decoration: BoxDecoration(
                          color:
                              isDark ? AppColors.darkCard : AppColors.lightCard,
                          borderRadius:
                              BorderRadius.circular(AppSpacing.radiusLg),
                          border: Border.all(
                            color: isDark
                                ? AppColors.darkBorder
                                : AppColors.lightBorder,
                          ),
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Avatar Picker
                              Center(
                                child: CustomImagePicker(
                                  label: 'Avatar',
                                  hint: 'Select profile picture',
                                  initialImages: _avatarUrl != null &&
                                          _avatarUrl!.isNotEmpty
                                      ? [_avatarUrl!]
                                      : [],
                                  onImagesChanged: (images) {
                                    setState(() {
                                      _avatarUrl = images.isNotEmpty
                                          ? images.first
                                          : null;
                                    });
                                  },
                                  isMultiple: false,
                                  uploadImmediately: false,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.lg),

                              // Name
                              CustomTextField(
                                controller: _nameController,
                                label: 'Full Name',
                                hint: 'Enter member name',
                                validator: (value) => Validators.required(value,
                                    fieldName: 'Name'),
                              ),
                              const SizedBox(height: AppSpacing.lg),

                              // Role
                              CustomTextField(
                                controller: _roleController,
                                label: 'Role',
                                hint: 'e.g. Senior Developer, UI Designer',
                                validator: (value) => Validators.required(value,
                                    fieldName: 'Role'),
                              ),
                              const SizedBox(height: AppSpacing.lg),

                              // Description
                              CustomTextField(
                                controller: _descriptionController,
                                label: 'Description',
                                hint: 'Tell us something about this member',
                                maxLines: 4,
                              ),
                              const SizedBox(height: AppSpacing.lg),

                              // Status
                              Row(
                                children: [
                                  Text(
                                    'Active Status',
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
                                    onPressed: () => context.go('/teams'),
                                    child: const Text('Cancel'),
                                  ),
                                  const SizedBox(width: AppSpacing.md),
                                  Expanded(
                                    child: GradientButton(
                                      text: _isEditing
                                          ? 'Update Member'
                                          : 'Create Member',
                                      isLoading: teamState.isLoading,
                                      onPressed: _submitForm,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    final notifier = ref.read(teamNotifierProvider.notifier);

    String? finalAvatarUrl = _avatarUrl;

    // Handle local image upload if necessary
    if (_avatarUrl != null && !_avatarUrl!.startsWith('http')) {
      setState(() => _isLoading = true);
      try {
        finalAvatarUrl = await _uploadService.uploadImageBytes(_avatarUrl!);
      } catch (e) {
        if (mounted) ToastService.error(message: 'Avatar upload failed: $e');
        setState(() => _isLoading = false);
        return;
      }
      setState(() => _isLoading = false);
    }

    if(widget.id == null) {
      return;
    }
    final member = CreateTeamDTO(
      name: _nameController.text.trim(),
      role: _roleController.text.trim(),
      description: _descriptionController.text.trim(),
      avatar: finalAvatarUrl,
      isActive: _isActive,
    );

    if (_isEditing) {
      await notifier.updateMember(member, widget.id!);
    } else {
      await notifier.createMember(member);
    }

    final updatedState = ref.read(teamNotifierProvider);
    if (updatedState.error != null) {
      if (mounted) ToastService.error(message: updatedState.error!);
    } else if (updatedState.isSuccess) {
      if (mounted) {
        ToastService.success(
          message: _isEditing
              ? 'Team member updated successfully'
              : 'Team member created successfully',
        );
        context.go('/teams');
      }
    }
  }
}
