class ToDoModel {
  ToDoModel({
    this.title,
    this.description,
    this.id,
  });

  String? title;
  String? description;

  int? id;

  factory ToDoModel.fromJson(Map<String, dynamic> json) => ToDoModel(
        title: json["title"],
        description: json["description"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "id": id,
      };

  Map<String, String> toStringJson() => {
        "title": title.toString(),
        "description": description.toString(),
        "id": id.toString(),
      };
}
