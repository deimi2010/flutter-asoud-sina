class CountryModel {
  String? id;
  String? name;

  CountryModel({this.id, this.name});

  CountryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
