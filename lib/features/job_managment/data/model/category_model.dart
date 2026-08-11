class CategoryModel {
  String? id;
  String? title;

  CategoryModel({this.id, this.title});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }
}
