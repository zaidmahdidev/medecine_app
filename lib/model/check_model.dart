class CheckModel {
  bool? status;
  String? name;
  String? category;
  String? imagePath;
  String? message;
  String? error;

  CheckModel({
    required this.status,
    required this.name,
    required this.category,
    required this.imagePath,
    required this.message,
    required this.error
  });

  factory CheckModel.fromJson(Map<String, dynamic> json) => CheckModel(
        status: json["Status"],
        name: json["name"],
        category: json["category"],
        imagePath: json["image_path"],
        message: json["message"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "name": name,
        "category": category,
        "image_path": imagePath,
        "message": message,
        "error": error,
      };
}
