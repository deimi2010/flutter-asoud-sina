class SliderModel {
  String? id;
  String? image;

  SliderModel({this.id, this.image});

  SliderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}
