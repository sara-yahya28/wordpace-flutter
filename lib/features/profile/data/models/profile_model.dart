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
    // محاولة قراءة القيم أو استخدام قيم افتراضية
    final posts = json[ApiKeys.postsCount] ?? json['posts_count'] ?? json['postsCount'] ?? 0;
    final published = json[ApiKeys.publishedPosts] ?? json['published_posts'] ?? json['publishedPosts'] ?? posts;
    final drafts = json[ApiKeys.drafts] ?? json['drafts_count'] ?? json['drafts'] ?? 0;

    return ProfileStatsModel(
      postsCount: posts is int ? posts : int.tryParse(posts.toString()) ?? 0,
      publishedPosts: published is int ? published : int.tryParse(published.toString()) ?? 0,
      drafts: drafts is int ? drafts : int.tryParse(drafts.toString()) ?? 0,
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
    final Map<String, dynamic> userData = (json[ApiKeys.user] is Map<String, dynamic>)
        ? json[ApiKeys.user]
        : (json[ApiKeys.data] is Map<String, dynamic>)
            ? json[ApiKeys.data]
            : json;

    final Map<String, dynamic> statsData = (userData[ApiKeys.stats] is Map<String, dynamic>)
        ? userData[ApiKeys.stats]
        : (json[ApiKeys.stats] is Map<String, dynamic>)
            ? json[ApiKeys.stats]
            : json; // البحث في الـ root الأساسي للـ JSON إذا لم يوجد مفتاح stats

    return ProfileModel(
      id: userData[ApiKeys.id] ?? 0,
      name: userData[ApiKeys.name] ?? '',
      email: userData[ApiKeys.email] ?? '',
      stats: ProfileStatsModel.fromJson(statsData),
    );
  }
}