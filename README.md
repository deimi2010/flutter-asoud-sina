# Flutter Asoud Sina

یک پروژه Flutter تمیز و خوب‌ساختار شده با الگوی BLoC.

A clean and well-structured Flutter project with BLoC pattern architecture.

---

## 🏗️ معماری پروژه | Architecture

این پروژه بر اساس بهترین روش‌های توسعه ساخته شده است:

- **BLoC Pattern** - الگوی مدیریت وضعیت
- **Clean Architecture** - اصول معماری تمیز
- **Dependency Injection (DI)** با `get_it` - تزریق وابستگی

---

## 📦 ساختار پروژه | Project Structure

```
lib/
├── core/
│   └── di/              # تنظیم تزریق وابستگی
├── features/            # ماژول‌های ویژگی
│   ├── data/           # لایه داده‌ها
│   ├── domain/         # لایه دامنه
│   └── presentation/   # لایه ارائه
└── main.dart
```

---

## 🚀 شروع کار | Getting Started

### پیش‌نیازها | Prerequisites
- Flutter SDK (آخرین نسخه)
- Dart SDK

### نصب | Installation

1. کلون کردن Repository:
```bash
git clone https://github.com/deimi2010/flutter-asoud-sina.git
cd flutter-asoud-sina
```

2. دانلود وابستگی‌ها:
```bash
flutter pub get
```

3. اجرای برنامه:
```bash
flutter run
```

---

## 📚 تکنولوژی‌های استفاده‌شده | Technologies Used

- **Flutter** - چارچوب رابط کاربری
- **Dart** - زبان برنامه‌نویسی
- **BLoC** - مدیریت وضعیت
- **get_it** - تزریق وابستگی
- **Clean Architecture** - سازمان‌دهی کد

---

## 🛠️ توسعه | Development

### اجرای تست‌ها | Running Tests
```bash
flutter test
```

### ساخت نسخه انتشار | Building Release
```bash
flutter build apk --release
flutter build ios --release
```

---

## 📝 مجوز | License

این پروژه متن‌باز است و تحت مجوز MIT در دسترس است.

---

## 👨‍💻 نویسنده | Author

**deimi2010**

---

**خوشحال کدنویسی! 🎉**
