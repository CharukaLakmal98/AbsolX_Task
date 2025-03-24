// utils/date_formatter.dart
class DateFormatter {
  static String formatDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }
}

// pubspec.yaml (add this to your pubspec)
/*
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.5
*/
