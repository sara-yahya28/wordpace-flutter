// is in model since it represents api response
class LikeResponseModel {
  final bool liked;
  final int likesCount;

  LikeResponseModel({required this.liked, required this.likesCount});

  factory LikeResponseModel.fromJson(Map<String, dynamic> json) {
    return LikeResponseModel(
        liked: json['liked'] ?? false, 
        likesCount: json['likes_count'] ?? 0);
  }
}
