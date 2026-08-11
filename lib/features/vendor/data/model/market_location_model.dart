class MarketLocationModel {
  String? market;
  String? city;
  String? address;
  String? zipCode;
  String? latitude;
  String? longitude;

  MarketLocationModel({
    this.market,
    this.city,
    this.address,
    this.zipCode,
    this.latitude,
    this.longitude,
  });

  MarketLocationModel.fromJson(Map<String, dynamic> json) {
    market = json['market'];
    city = json['city'];
    address = json['address'];
    zipCode = json['zip_code'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['market'] = market;
    data['city'] = city;
    data['address'] = address;
    data['zip_code'] = zipCode;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
