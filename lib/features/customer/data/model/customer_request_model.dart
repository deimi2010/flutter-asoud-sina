import 'dart:convert';

class CustomerReqModel {
  final int requestId;
  final String paymentType;
  final String customerName;
  final String cutomerNumber;
  final String requestStatus;
  final String dateTime;
  final String price;
  final String statusDes;
  CustomerReqModel({
    required this.requestId,
    required this.paymentType,
    required this.customerName,
    required this.cutomerNumber,
    required this.requestStatus,
    required this.dateTime,
    required this.price,
    required this.statusDes,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'requestId': requestId,
      'paymentType': paymentType,
      'customerName': customerName,
      'cutomerNumber': cutomerNumber,
      'requestStatus': requestStatus,
      'dateTime': dateTime,
      'price': price,
      'statusDes': statusDes,
    };
  }

  factory CustomerReqModel.fromMap(Map<String, dynamic> map) {
    return CustomerReqModel(
      requestId: map['requestId'] as int,
      paymentType: map['paymentType'] as String,
      customerName: map['customerName'] as String,
      cutomerNumber: map['cutomerNumber'] as String,
      requestStatus: map['requestStatus'] as String,
      dateTime: map['dateTime'] as String,
      price: map['price'] as String,
      statusDes: map['statusDes'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerReqModel.fromJson(String source) =>
      CustomerReqModel.fromMap(json.decode(source) as Map<String, dynamic>);

  bool get stringify => true;
}
