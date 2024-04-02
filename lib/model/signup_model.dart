class SignUpModel {
  bool status;
  String message;
  String? token;

  SignUpModel({
    required this.status,
    required this.message,
    required this.token,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        status: json["Status"],
        message: json["message"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "message": message,
        "token": token,
      };
}
