import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/custom_image_picker.dart';

import '../../../../generated_code/swagger.swagger.dart';
import '../../domain/entities/client.dart';
import '../providers/client_providers.dart';

class ClientFormPage extends ConsumerStatefulWidget {
  final Client? client;

  const ClientFormPage({super.key, this.client});

  @override
  ConsumerState<ClientFormPage> createState() => _ClientFormPageState();
}

class _ClientFormPageState extends ConsumerState<ClientFormPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _companyController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _projectsController;

  ClientStatus _status = ClientStatus.prospect;
  String? _selectedImagePath;
  bool _imageChanged = false;

  @override
  void initState() {
    super.initState();
    final client = widget.client;

    _nameController = TextEditingController(text: client?.name ?? '');
    _companyController = TextEditingController(text: client?.company ?? '');
    _emailController = TextEditingController(text: client?.email ?? '');
    _phoneController = TextEditingController(text: client?.phone ?? '');
    _projectsController = TextEditingController(
        text: client != null ? client.totalProjects.toString() : '0');

    if (client != null) {
      _status = client.status;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _companyController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _projectsController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final isEditing = widget.client != null;
    final totalProjects = int.tryParse(_projectsController.text) ?? 0;

    final mutations = ref.read(clientMutationsProvider.notifier);
    Client? resultClient;

    if (isEditing) {
      final updateDto = UpdateClientDTO(
        name: _nameController.text.trim(),
        company: _companyController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim().isEmpty
            ? null
            : _phoneController.text.trim(),
        totalProjects: totalProjects.toDouble(),
        status: UpdateClientDTOStatus.values.firstWhere(
          (e) => e.value == _status.name,
          orElse: () => UpdateClientDTOStatus.prospect,
        ),
      );

      resultClient = await mutations.updateClient(widget.client!.id, updateDto);
    } else {
      final createDto = CreateClientDTO(
        name: _nameController.text.trim(),
        company: _companyController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim().isEmpty
            ? null
            : _phoneController.text.trim(),
        totalProjects: totalProjects.toDouble(),
        status: CreateClientDTOStatus.values.firstWhere(
          (e) => e.value == _status.name,
          orElse: () => CreateClientDTOStatus.prospect,
        ),
      );

      resultClient = await mutations.createClient(createDto);
    }

    // Handle Image Upload if selected
    if (resultClient != null && _imageChanged) {
      if (_selectedImagePath != null) {
        await mutations.uploadImage(resultClient.id, File(_selectedImagePath!));
      } else if (isEditing) {
        // Only remove if it was an existing client and image was explicitly removed
        await mutations.removeImage(resultClient.id);
      }
    }

    if (mounted && !ref.read(clientMutationsProvider).hasError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isEditing
              ? 'Client updated successfully'
              : 'Client created successfully'),
          backgroundColor: AppColors.success,
        ),
      );
      context.pop();
    } else if (mounted) {
      final error = ref.read(clientMutationsProvider).error;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    if (value.trim().length < 2) {
      return '$fieldName must be at least 2 characters';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validateNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Total projects is required';
    }
    if (int.tryParse(value) == null) {
      return 'Please enter a valid number';
    }
    if (int.parse(value) < 0) {
      return 'Number cannot be negative';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isEditing = widget.client != null;
    final mutationState = ref.watch(clientMutationsProvider);

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Client' : 'New Client'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Form Fields section
              Container(
                padding: const EdgeInsets.all(AppSpacing.xl),
                decoration: BoxDecoration(
                  color:
                      isDark ? AppColors.darkSurface : AppColors.lightSurface,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                  border: Border.all(
                    color:
                        isDark ? AppColors.darkBorder : AppColors.lightBorder,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Client Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color:
                            isDark ? AppColors.darkText : AppColors.lightText,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // Profile Image
                    CustomImagePicker(
                      label: 'Profile Image',
                      hint: 'Select client profile image',
                      isMultiple: false,
                      uploadImmediately: false,
                      initialImages: widget.client?.imageUrl != null
                          ? [widget.client!.imageUrl!]
                          : [],
                      onImagesChanged: (images) {
                        setState(() {
                          _imageChanged = true;
                          _selectedImagePath =
                              images.isNotEmpty ? images.first : null;
                        });
                      },
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // Name & Company
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: _nameController,
                            label: 'Full Name *',
                            hint: 'e.g., Jane Doe',
                            validator: (v) => _validateRequired(v, 'Name'),
                            icon: Iconsax.user,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: _buildTextField(
                            controller: _companyController,
                            label: 'Company *',
                            hint: 'e.g., Acme Corp',
                            validator: (v) => _validateRequired(v, 'Company'),
                            icon: Iconsax.building,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Email & Phone
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: _emailController,
                            label: 'Email Address *',
                            hint: 'jane@example.com',
                            validator: _validateEmail,
                            icon: Iconsax.sms,
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: _buildTextField(
                            controller: _phoneController,
                            label: 'Phone (Optional)',
                            hint: '+1 234 567 8900',
                            icon: Iconsax.call,
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Total Projects & Status
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: _projectsController,
                            label: 'Total Projects *',
                            hint: '0',
                            validator: _validateNumber,
                            icon: Iconsax.folder,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Status *',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: isDark
                                      ? AppColors.darkText
                                      : AppColors.lightText,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              DropdownButtonFormField<ClientStatus>(
                                initialValue: _status,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppSpacing.radiusMd),
                                    borderSide: BorderSide(
                                      color: isDark
                                          ? AppColors.darkBorder
                                          : AppColors.lightBorder,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: isDark
                                      ? AppColors.darkBackground
                                      : AppColors.lightBackground,
                                ),
                                items: const [
                                  DropdownMenuItem(
                                      value: ClientStatus.active,
                                      child: Text('Active')),
                                  DropdownMenuItem(
                                      value: ClientStatus.inactive,
                                      child: Text('Inactive')),
                                  DropdownMenuItem(
                                      value: ClientStatus.prospect,
                                      child: Text('Prospect')),
                                ],
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(() => _status = value);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed:
                        mutationState.isLoading ? null : () => context.pop(),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xl,
                        vertical: AppSpacing.md,
                      ),
                    ),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  ElevatedButton(
                    onPressed: mutationState.isLoading ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xl,
                        vertical: AppSpacing.md,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusMd),
                      ),
                    ),
                    child: mutationState.isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(isEditing ? 'Save Changes' : 'Create Client'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    String? Function(String?)? validator,
    IconData? icon,
    TextInputType? keyboardType,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isDark ? AppColors.darkText : AppColors.lightText,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          style: TextStyle(
            color: isDark ? AppColors.darkText : AppColors.lightText,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
            prefixIcon: icon != null
                ? Icon(
                    icon,
                    size: 20,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              borderSide: BorderSide(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              borderSide: BorderSide(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
              ),
            ),
            filled: true,
            fillColor:
                isDark ? AppColors.darkBackground : AppColors.lightBackground,
          ),
        ),
      ],
    );
  }
}
