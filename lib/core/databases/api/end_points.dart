class EndPoints {
  static const String baseUrl =
      "http://127.0.0.1:8000/api/"; // غيّر عند النشر

  // Auth
  static const String register = '/register';
  static const String login = '/login';
  static const String user = '/user';
  static const String profile = '/profile';

  // Posts
  static String posts = '/posts';
  static String postDetails(int postId) => '/posts/$postId';
  static const String userPosts = '/user/posts';

  static String deletePost(int id) => 'posts/$id';

  // Comments
  static String commentDetails(int postId, int commentId) =>
      '/posts/$postId/comments/$commentId';
  static String postComments(int postId) => '/posts/$postId/comments';

  // Likes
  static String postLikes(int postId) => '/posts/$postId/likes';
  static const String likedPosts = '/user/liked-posts';
  static String toggleLike(int postId) => '/posts/$postId/like';

  // Admin
  static const String adminDashboard = '/admin/dashboard';
  static const String adminUsers = '/admin/users';

  static var data;
  static String adminUserDetails(int userId) => '/admin/users/$userId';
}

class ApiKeys {
  static String name = "name";
  static String email = "email";
  static String password = "password";
  static String passwordConfirmation = "password_confirmation";

  static String title = "title";
  static String content = "content";
  static String status = "status";
  static String body = "body";

  static String commentContent = "content"; // نفس content لكن للتوضيح

  // General
  static String message = "message";
  static String data = "data";
  static String errors = "errors";

  // User
  static String user = "user";
  static String id = "id";
  static String userId = "user_id";
  static String role = "role";
  static String createdAt = "created_at";
  static String updatedAt = "updated_at";
  static String emailVerifiedAt = "email_verified_at";

  // Token
  static String token = "token";

  // Profile Stats
  static String stats = "stats";
  static String postsCount = "posts_count";
  static String publishedPosts = "published_posts";
  static String drafts = "drafts";
  static String commentsCount = "comments_count";
  static String likesCount = "likes_count";

  // Likes
  static String like = "like";
  static String postId = "post_id";
  static String commentId = "comment_id";
  static String likedByMe = "liked_by_me";

  static String statusCode = "status_code";
  static String errorMessage = "error_message";
}

/*
What Was Done
WHAT:
   - Centralizes all API endpoints (baseUrl, login, register, user, etc.).
   - Centralizes all field keys used in requests and responses.

   USAGE:
   - EndPoints.baseUrl + EndPoints.login → full URL.
   - ApiKeys.email, ApiKeys.password → request body keys.
 */
