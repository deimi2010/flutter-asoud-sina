import 'package:asood/core/http_client/api_client.dart';
import 'package:asood/core/http_client/api_status.dart';
import 'package:dio/dio.dart';

class PaymentApiService {
  final DioClient dioClient;
  
  PaymentApiService({required this.dioClient});
  
  Future createPayment(Map<String, dynamic> data) async {
    try {
      final res = await dioClient.postData('user/payments/create/', data);
      return apiStatus(res);
    } catch (e) {
      return customApiStatus();
    }
  }
  
  Future redirectToPayment(Map<String, dynamic> data) async {
    try {
      final res = await dioClient.postData('user/payments/pay', data);
      return apiStatus(res);
    } catch (e) {
      return customApiStatus();
    }
  }
  
  Future verifyPayment(Map<String, dynamic> data) async {
    try {
      final res = await dioClient.postData('user/payments/verify/', data);
      return apiStatus(res);
    } catch (e) {
      return customApiStatus();
    }
  }
  
  Future getPayments() async {
    try {
      final res = await dioClient.getData('user/payments/');
      return apiStatus(res);
    } catch (e) {
      return customApiStatus();
    }
  }
  
  Future getPaymentDetail(String paymentId) async {
    try {
      final res = await dioClient.getData('user/payments/$paymentId/');
      return apiStatus(res);
    } catch (e) {
      return customApiStatus();
    }
  }
}

