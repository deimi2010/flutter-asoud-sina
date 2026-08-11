import 'dart:io';

import 'package:asood/core/http_client/api_client.dart';
import 'package:asood/core/http_client/api_status.dart';
import 'package:asood/core/constants/endpoints.dart';
import 'package:dio/dio.dart';

class InquiryAPIService {
  DioClient dioClient;
  InquiryAPIService({required this.dioClient});

  Future submitInquiry(
    String inquiryType,
    String inquiryTitle,
    String? inquiryDescription,
    String? inquiryDetails,
    String inquiryCategory,
    double? inquiryAmount,
    String? inquiryUnit,
    String? inquiryName,
    List<File>? inquiryImages,
  ) async {
    var body = {
      "type": inquiryType,
      "name": inquiryTitle,
      if (inquiryDetails != null) "technical_detail": inquiryDetails,
      if (inquiryAmount != null) "amount": inquiryAmount.toString(),
      if (inquiryUnit != null) "unit": inquiryUnit,
      // Backend requires expiry; set 7 days ahead by default
      "expiry": DateTime.now().add(const Duration(days: 7)).toIso8601String(),
    };
    var uri = '${Endpoints.inquiry}create/';
    try {
      Response res = await dioClient.postData(uri, body);
      return apiStatus(res);
    } catch (e) {
      return customApiStatus();
    }
  }
}
