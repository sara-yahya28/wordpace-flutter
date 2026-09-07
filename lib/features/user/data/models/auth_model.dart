import 'package:wordspace/core/databases/api/end_points.dart';
import 'package:wordspace/features/user/data/models/user_model.dart';

class AuthModel {
  final String? message;
  final String token;
  final UserModel user;

  AuthModel({
    this.message,
    required this.token,
    required this.user,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
// checks if there's user
    final bool hasNestedUser = json.containsKey('user') && json['user'] is Map;
    
// nested structure(login)
    if (hasNestedUser) {
      final userData = json['user'] as Map<String, dynamic>;
      return AuthModel(
        message: json['message'] as String?,
        token: json['token'] as String? ?? '',
        user: UserModel.fromJson(userData),//usermodel from userData
      );
    }
    
// flat structure(register)
    else {
      return AuthModel(
        message: json['message'] as String?,
        token: json['token'] as String? ?? '',
        user: UserModel.fromJson(json),//userModel from json
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      if (message != null) ApiKeys.message: message!,
      ApiKeys.token: token,
      ApiKeys.user: user.toJson(),
    };
  }
}
/*
WHAT:
   - Represents the API response for login/register endpoints.
   - Designed specifically for the NEW API flat structure.

   FIELDS:
   - message: Optional (nullable) - kept for compatibility but always null.
   - token: Authentication token (JWT).
   - user: UserModel object built from the same JSON.

   NEW API FORMAT:
   - Response is flat: { id, name, email, role, token, created_at, updated_at }
   - No nested 'user' object.
   - No 'message' field.

   SIMPLICITY:
   - fromJson() directly passes the entire JSON to UserModel.fromJson().
   - No conditional checks, no backward compatibility logic.
   - Clean, maintainable, and focused on the current API.


*/