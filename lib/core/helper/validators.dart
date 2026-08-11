import 'package:pars_validator/pars_validator.dart';

class Validators {
  static String? simpleFieldEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return "فیلد نمی‌تواند خالی باشد.";
    }

    return null;
  }

  static String? companyValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "لطفاً کد ملی را وارد کنید.";
    }

    if (!RegExp(r'^\d{11}$').hasMatch(value)) {
      return "شناسه ملی باید 11 رقم و فقط شامل اعداد باشد.";
    }

    return null;
  }

  static String? iranianNationalCodeValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "لطفاً کد ملی را وارد کنید.";
    }
    bool isValid = National.isNationalIDValid(value);

    if (!isValid) {
      return "کد ملی وارد شده معتبر نیست.";
    }

    return null;
  }

  static String? phoneNumber(String? value, {bool? optional = false}) {
    if (optional == false) {
      if (value == null || value.isEmpty) {
        return "لطفا شماره تلفن را وارد کنید";
      }
      bool isValid = Phone.isMobileNumberValid(value);

      if (!isValid) {
        return "شماره تلفن وارد شده نامعتبر است";
      }
    }

    return null;
  }

  static String? landPhoneNumber(String? value, {bool? optional = false}) {
    if (optional == false) {
      if (value == null || value.isEmpty) {
        return "لطفا شماره تلفن را وارد کنید";
      }
      bool isValid = Phone.isLandlineNumberValid(value);

      if (!isValid) {
        return "شماره تلفن وارد شده نامعتبر است";
      }
    }
    return null;
  }

  static String? post(String? value, {bool? optional = false}) {
    if (optional == false) {
      if (value == null || value.isEmpty) {
        return "لطفاً کدپستی را وارد کنید.";
      }
      bool isValid = National.isValidPostalCode(value);

      if (!isValid) {
        return "کدپستی وارد شده نامعتبر است";
      }
    }
    return null;
  }

  static String? fax(String? value, {bool? optional = false}) {
    if (optional == false) {
      if (value == null || value.isEmpty) {
        return "لطفاً شماره فکس را وارد کنید.";
      }
      // فرض بر اینکه فکس شبیه تلفن ثابت هست
      if (!RegExp(r'^0\d{10}$').hasMatch(value)) {
        return "شماره فکس وارد شده نامعتبر است.";
      }
    }
    return null;
  }

  static String? email(String? value, {bool? optional = false}) {
    if (optional == false) {
      if (value == null || value.isEmpty) {
        return "لطفاً ایمیل را وارد کنید.";
      }

      bool isValid = Phone.isEmailValid(value);
      if (!isValid) {
        return "ایمیل وارد شده معتبر نیست.";
      }
    }
    return null;
  }

  static String? website(String? value, {bool? optional = false}) {
    if (optional == false) {
      if (value == null || value.isEmpty) {
        return "لطفاً آدرس وب‌سایت را وارد کنید.";
      }
      if (!RegExp(
        r"^(https?:\/\/)?([\w\-]+\.)+[\w\-]{2,}(\/[\w\-._~:/?#[\]@!$&'()*+,;=.]+)?$",
      ).hasMatch(value)) {
        return "آدرس وب‌سایت معتبر نیست.";
      }
    }
    return null;
  }
}
