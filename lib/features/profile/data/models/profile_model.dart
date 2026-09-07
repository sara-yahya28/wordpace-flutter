import 'package:wordspace/core/databases/api/end_points.dart';
import 'package:wordspace/features/profile/domain/entities/profile_entity.dart';

class ProfileStatsModel extends ProfileStatsEntity {
  ProfileStatsModel({
    required super.postsCount,
    required super.publishedPosts,
    required super.drafts,
    required super.commentsCount,
    required super.likesCount,
  });

  factory ProfileStatsModel.fromJson(Map<String, dynamic> json) {
    return ProfileStatsModel(
      postsCount: json[ApiKeys.postsCount] ?? 0,
      publishedPosts: json[ApiKeys.publishedPosts] ?? 0,
      drafts: json[ApiKeys.drafts] ?? 0,
      commentsCount: json[ApiKeys.commentsCount] ?? 0,
      likesCount: json[ApiKeys.likesCount] ?? 0,
    );
  }
}

class ProfileModel extends ProfileEntity {
  ProfileModel({
    required super.id,
    required super.name,
    required super.email,
    required super.stats,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    final userData = json[ApiKeys.user] ?? json;
    return ProfileModel(
      id: userData[ApiKeys.id] ?? 0,
      name: userData[ApiKeys.name] ?? '',
      email: userData[ApiKeys.email] ?? '',
      stats: ProfileStatsModel.fromJson(json[ApiKeys.stats] ?? {}),
    );
  }
}