class Course {
  String? id;
  String name;
  String description;
  String imageUrl;

  Course({
    this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'description': description,
        'imageUrl': imageUrl,
      };

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        imageUrl: json['imageUrl'],
      );
}
