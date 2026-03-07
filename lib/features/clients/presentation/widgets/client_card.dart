import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../domain/entities/client.dart';
import 'client_status_badge.dart';

class ClientCard extends StatelessWidget {
  final Client client;
  final VoidCallback onTap;

  const ClientCard({
    super.key,
    required this.client,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        side: BorderSide(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        ),
      ),
      color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDark
                          ? AppColors.darkBackground
                          : AppColors.lightBackground,
                      border: Border.all(
                        color: isDark
                            ? AppColors.darkBorder
                            : AppColors.lightBorder,
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child:
                        client.imageUrl != null && client.imageUrl!.isNotEmpty
                            ? Image.network(
                                client.imageUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    _buildInitialsAvatar(context),
                              )
                            : _buildInitialsAvatar(context),
                  ),
                  const SizedBox(width: AppSpacing.md),

                  // Name and Company
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          client.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isDark
                                ? AppColors.darkText
                                : AppColors.lightText,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          client.company,
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),

              // Bottom Row (Projects & Status)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.folder_outlined,
                        size: 16,
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${client.totalProjects} Projects',
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                        ),
                      ),
                    ],
                  ),
                  ClientStatusBadge(status: client.status, isSmall: true),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInitialsAvatar(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    String initials = '';
    if (client.name.isNotEmpty) {
      final parts = client.name.split(' ');
      if (parts.length > 1) {
        initials = '\${parts[0][0]}\${parts[1][0]}'.toUpperCase();
      } else {
        initials = client.name
            .substring(0, client.name.length > 1 ? 2 : 1)
            .toUpperCase();
      }
    }

    return Center(
      child: Text(
        initials,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: isDark
              ? AppColors.darkTextSecondary
              : AppColors.lightTextSecondary,
        ),
      ),
    );
  }
}
