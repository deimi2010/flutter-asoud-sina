// import 'dart:convert';
import 'dart:io';

String handleHttpError(int statusCode) {
  switch (statusCode) {
    case HttpStatus.badRequest:
      return 'Bad request: مشکلی در داده های ارسالی وجود دارد لطفا مجدد ورودی ها را بررسی و ارسای کنید';
    case HttpStatus.unauthorized:
      return 'Unauthorized: کاربر شما اجازه دسترسی به این بخش را ندارد.';
    case HttpStatus.forbidden:
      return 'Forbidden: کاربر شما اجازه دسترسی به این بخش را ندارد.';
    case HttpStatus.notFound:
      return 'Not Found: اطلاعات درخواستی یافت نشد.';
    case HttpStatus.internalServerError:
      return 'Internal Server Error: مشکلی برای سرورپیش آمده مجدد تلاش کنید.';
    case HttpStatus.notImplemented:
      return 'Not Implemented: متدی برای این درخواست وجود ندارد.';
    case HttpStatus.badGateway:
      return 'Bad Gateway: درخواست شما با مشکل مواجه شد.';
    case HttpStatus.serviceUnavailable:
      return 'Service Unavailable: سرور در دسترس نیست بعد تلاش نمایید.';
    default:
      return 'Unexpected Error: مشکلی در درخواست وجود دارد امکان انجام درخواست وجود نداشت $statusCode.';
  }
}
