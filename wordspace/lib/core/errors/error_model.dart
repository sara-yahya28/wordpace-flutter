class ErrorModel {
  final String? message;
  final Map<String, List<String>>? errors; // Validation
  final int? status;        
  final String? errorMessage; 

  ErrorModel({this.message, this.errors, this.status, this.errorMessage});

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      message: json['message'] ?? 'Unexpected Error Occured',
      errors: json['errors'] != null
          ? Map<String, List<String>>.from(json['errors']).map(
              (key, value) => MapEntry(key, List<String>.from(value)),
            )
          : null,
      status: json['status'],
      errorMessage: json['errorMessage'],
    );
  }
}