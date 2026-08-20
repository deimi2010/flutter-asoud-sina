class MarketScheduleModel {
  final String market;
  final String day;
  final String start;
  final String? end;

  MarketScheduleModel({
    required this.market,
    required this.day,
    required this.start,
    this.intervalIndex = 1,
    this.end,
  });

  final int intervalIndex;

  factory MarketScheduleModel.fromJson(Map<String, dynamic> json) {
    return MarketScheduleModel(
      market: json['market']?.toString() ?? '',
      day: json['day']?.toString() ?? '',
      start: json['start']?.toString() ?? '',
      intervalIndex: json['interval_index'] as int? ?? 1,
      end: json['end']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'market': market,
      'day': day,
      'start': start,
      'interval_index': intervalIndex,
      if (end != null) 'end': end,
    };
  }
}
