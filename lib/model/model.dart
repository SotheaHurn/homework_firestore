class AddPhotoDemo {
  String id;
  String name;
  String imageURL;

  AddPhotoDemo({
    required this.id,
    required this.name,
    required this.imageURL,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'imageURL': imageURL,
      };
  static AddPhotoDemo fromJson(Map<String, dynamic> json) => AddPhotoDemo(
        id: json['id'],
        name: json['name'],
        imageURL: json['imageURL'],
      );
}
