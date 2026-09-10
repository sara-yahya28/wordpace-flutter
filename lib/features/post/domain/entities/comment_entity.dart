class CommentEntity {
  final int id;
  final String content;
  final int postId;
  final String userName;
  final DateTime createdAt;

  CommentEntity({
  required this.id, 
  required this.content, 
  required this.postId, 
  required this.userName, 
  required this.createdAt
  });
}