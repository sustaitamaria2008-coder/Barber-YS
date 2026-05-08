class WorkModel {
  final String imagePath;
  final String description;

  WorkModel({required this.imagePath, required this.description});

  Map<String, dynamic> toMap() {
    return {'imagePath': imagePath, 'description': description};
  }

  factory WorkModel.fromMap(Map<String, dynamic> map) {
    return WorkModel(
      imagePath: map['imagePath'],
      description: map['description'],
    );
  }
}
