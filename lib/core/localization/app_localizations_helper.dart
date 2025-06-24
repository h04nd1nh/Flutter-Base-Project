import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        AppLocalizations(const Locale('vi'));
  }

  // App names
  String get appName {
    switch (locale.languageCode) {
      case 'en':
        return 'Flutter Base Project';
      case 'vi':
      default:
        return 'Dự Án Flutter Cơ Bản';
    }
  }

  String get appNameDev {
    switch (locale.languageCode) {
      case 'en':
        return 'Flutter Base Project Dev';
      case 'vi':
      default:
        return 'Dự Án Flutter Cơ Bản Dev';
    }
  }

  String get appNameStaging {
    switch (locale.languageCode) {
      case 'en':
        return 'Flutter Base Project Staging';
      case 'vi':
      default:
        return 'Dự Án Flutter Cơ Bản Staging';
    }
  }

  // Page titles
  String get home {
    switch (locale.languageCode) {
      case 'en':
        return 'Home';
      case 'vi':
      default:
        return 'Trang Chủ';
    }
  }

  String get profile {
    switch (locale.languageCode) {
      case 'en':
        return 'Profile';
      case 'vi':
      default:
        return 'Hồ Sơ';
    }
  }

  // Section titles
  String get appInformation {
    switch (locale.languageCode) {
      case 'en':
        return 'App Information';
      case 'vi':
      default:
        return 'Thông Tin Ứng Dụng';
    }
  }

  String get userInformation {
    switch (locale.languageCode) {
      case 'en':
        return 'User Information';
      case 'vi':
      default:
        return 'Thông Tin Người Dùng';
    }
  }

  // Labels
  String get flavor {
    switch (locale.languageCode) {
      case 'en':
        return 'Flavor';
      case 'vi':
      default:
        return 'Phiên Bản';
    }
  }

  String get title {
    switch (locale.languageCode) {
      case 'en':
        return 'Title';
      case 'vi':
      default:
        return 'Tiêu Đề';
    }
  }

  String get apiBaseUrl {
    switch (locale.languageCode) {
      case 'en':
        return 'API Base URL';
      case 'vi':
      default:
        return 'URL API Cơ Sở';
    }
  }

  String get isDevelopment {
    switch (locale.languageCode) {
      case 'en':
        return 'Is Development';
      case 'vi':
      default:
        return 'Là Phát Triển';
    }
  }

  String get isStaging {
    switch (locale.languageCode) {
      case 'en':
        return 'Is Staging';
      case 'vi':
      default:
        return 'Là Thử Nghiệm';
    }
  }

  String get isProduction {
    switch (locale.languageCode) {
      case 'en':
        return 'Is Production';
      case 'vi':
      default:
        return 'Là Sản Xuất';
    }
  }

  String get name {
    switch (locale.languageCode) {
      case 'en':
        return 'Name';
      case 'vi':
      default:
        return 'Tên';
    }
  }

  String get email {
    switch (locale.languageCode) {
      case 'en':
        return 'Email';
      case 'vi':
      default:
        return 'Email';
    }
  }

  String get avatar {
    switch (locale.languageCode) {
      case 'en':
        return 'Avatar';
      case 'vi':
      default:
        return 'Ảnh Đại Diện';
    }
  }

  String get createdAt {
    switch (locale.languageCode) {
      case 'en':
        return 'Created At';
      case 'vi':
      default:
        return 'Ngày Tạo';
    }
  }

  String get updatedAt {
    switch (locale.languageCode) {
      case 'en':
        return 'Updated At';
      case 'vi':
      default:
        return 'Ngày Cập Nhật';
    }
  }

  String get error {
    switch (locale.languageCode) {
      case 'en':
        return 'Error';
      case 'vi':
      default:
        return 'Lỗi';
    }
  }

  String get retry {
    switch (locale.languageCode) {
      case 'en':
        return 'Retry';
      case 'vi':
      default:
        return 'Thử Lại';
    }
  }

  String get goToProfile {
    switch (locale.languageCode) {
      case 'en':
        return 'Go to Profile';
      case 'vi':
      default:
        return 'Đi Tới Hồ Sơ';
    }
  }

  String get pageNotFound {
    switch (locale.languageCode) {
      case 'en':
        return 'Page not found';
      case 'vi':
      default:
        return 'Không tìm thấy trang';
    }
  }

  String get profilePageDescription {
    switch (locale.languageCode) {
      case 'en':
        return 'This is where user profile information would be displayed.';
      case 'vi':
      default:
        return 'Đây là nơi hiển thị thông tin hồ sơ người dùng.';
    }
  }

  String get language {
    switch (locale.languageCode) {
      case 'en':
        return 'Language';
      case 'vi':
      default:
        return 'Ngôn Ngữ';
    }
  }

  String get changeLanguage {
    switch (locale.languageCode) {
      case 'en':
        return 'Change Language';
      case 'vi':
      default:
        return 'Đổi Ngôn Ngữ';
    }
  }

  String get english {
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'vi':
      default:
        return 'Tiếng Anh';
    }
  }

  String get vietnamese {
    switch (locale.languageCode) {
      case 'en':
        return 'Vietnamese';
      case 'vi':
      default:
        return 'Tiếng Việt';
    }
  }
}
