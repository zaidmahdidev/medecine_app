class ErrorModel {
  bool? status;
  String? errorMessage;

  ErrorModel({
    required this.status,
    required this.errorMessage,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        status: json["Status"],
        errorMessage: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "message": errorMessage,
      };
}
