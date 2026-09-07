import 'package:flutter/material.dart';
import 'package:wordspace/features/profile/domain/entities/profile_entity.dart';
import 'package:wordspace/core/theme/app_theme.dart';

class ProfileStatsBarWidget extends StatelessWidget {
  final ProfileStatsEntity stats;

  const ProfileStatsBarWidget({
    super.key,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatItem('Posts', stats.postsCount.toString()),
        _buildStatItem('Likes', stats.likesCount.toString()),
        _buildStatItem('Comments', stats.commentsCount.toString()),
      ],
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryDark,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: AppTheme.primaryLight,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
