class ProfileStatsEntity {
  final int postsCount;
  final int publishedPosts;
  final int drafts;
  final int commentsCount;
  final int likesCount;

  ProfileStatsEntity({
    required this.postsCount,
    required this.publishedPosts,
    required this.drafts,
    required this.commentsCount,
    required this.likesCount,
  });
}

class ProfileEntity {
  final int id;
  final String name;
  final String email;
  final ProfileStatsEntity stats;

  ProfileEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.stats,
  });
}