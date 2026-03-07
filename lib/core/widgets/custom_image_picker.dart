import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../network/upload_service.dart';

class CustomImagePicker extends StatefulWidget {
  final bool isMultiple;
  final List<String> initialImages;
  final Function(List<String>) onImagesChanged;
  final String label;
  final String? hint;
  final bool uploadImmediately;

  const CustomImagePicker({
    super.key,
    this.isMultiple = false,
    this.initialImages = const [],
    required this.onImagesChanged,
    this.label = 'Select Image',
    this.hint,
    this.uploadImmediately = true,
  });

  @override
  State<CustomImagePicker> createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  final ImagePicker _picker = ImagePicker();
  final UploadService _uploadService = UploadService();
  List<String> _images = [];
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    _images = List.from(widget.initialImages);
  }

  Future<void> _pickImage() async {
    try {
      if (widget.isMultiple) {
        final List<XFile> pickedFiles = await _picker.pickMultiImage();
        if (pickedFiles.isNotEmpty) {
          if (widget.uploadImmediately) {
            setState(() {
              _isUploading = true;
            });

            for (final file in pickedFiles) {
              final url = await _uploadService.uploadImageBytes(file.path);
              if (url != null) {
                _images.add(url);
              }
            }
          } else {
            for (final file in pickedFiles) {
              _images.add(file.path);
            }
          }

          setState(() {
            _isUploading = false;
            widget.onImagesChanged(_images);
          });
        }
      } else {
        final XFile? pickedFile =
            await _picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          if (widget.uploadImmediately) {
            setState(() {
              _isUploading = true;
            });

            final fileData = pickedFile.path;
            final url = await _uploadService.uploadImageBytes(fileData);

            if (url != null) {
              _images = [url];
            }
          } else {
            _images = [pickedFile.path];
          }

          setState(() {
            _isUploading = false;
            widget.onImagesChanged(_images);
          });
        }
      }
    } catch (e) {
      setState(() {
        _isUploading = false;
      });
      debugPrint('Error picking or uploading image: $e');
    }
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
      widget.onImagesChanged(_images);
    });
  }

  Widget _buildImagePreview(String path, int index) {
    final isNetwork = path.startsWith('http://') || path.startsWith('https://');
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        Container(
          width: 100,
          height: 100,
          margin: const EdgeInsets.only(
              right: AppSpacing.md, bottom: AppSpacing.md, top: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            border: Border.all(
              color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
            ),
            image: DecorationImage(
              image: isNetwork
                  ? NetworkImage(path) as ImageProvider
                  : (kIsWeb ? NetworkImage(path) : FileImage(File(path))),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            icon: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.cancel, color: AppColors.error, size: 24),
            ),
            onPressed: () => _removeImage(index),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label.isNotEmpty) ...[
          Text(
            widget.label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark ? AppColors.darkText : AppColors.lightText,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        if (widget.hint != null && _images.isEmpty) ...[
          Text(
            widget.hint!,
            style: TextStyle(
              fontSize: 12,
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        Wrap(
          children: [
            ...List.generate(_images.length,
                (index) => _buildImagePreview(_images[index], index)),
            if (widget.isMultiple || _images.isEmpty)
              GestureDetector(
                onTap: _isUploading ? null : _pickImage,
                child: Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(
                      right: AppSpacing.md, bottom: AppSpacing.md, top: 8),
                  decoration: BoxDecoration(
                    color:
                        isDark ? AppColors.darkSurface : AppColors.lightSurface,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    border: Border.all(
                      color:
                          isDark ? AppColors.darkBorder : AppColors.lightBorder,
                    ),
                  ),
                  child: Center(
                    child: _isUploading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Icon(
                            Iconsax.camera,
                            color: isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary,
                          ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
