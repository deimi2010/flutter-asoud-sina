class MarketScheduleModel {
  final String market;
  final String day;
  final String start;
  final String? end;

  MarketScheduleModel({
    required this.market,
    required this.day,
    required this.start,
    this.end,
  });

  factory MarketScheduleModel.fromJson(Map<String, dynamic> json) {
    return MarketScheduleModel(
      market: json['market'],
      day: json['day'],
      start: json['start'],
      end: json['end'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'market': market,
      'day': day,
      'start': start,
      if (end != null) 'end': end,
    };
  }
}
