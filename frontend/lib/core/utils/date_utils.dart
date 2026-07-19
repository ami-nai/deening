class DateUtils {
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;
  }

  static String formatPrayerDate(DateTime date) {
    if (isToday(date)) {
      return 'Today';
    } else if (isYesterday(date)) {
      return 'Yesterday';
    }
    return '${date.day}/${date.month}/${date.year}';
  }

  static int getMonthDays(int year, int month) {
    if (month == DateTime.february) {
      return isLeapYear(year) ? 29 : 28;
    }
    if ([DateTime.april, DateTime.june, DateTime.september, DateTime.november]
        .contains(month)) {
      return 30;
    }
    return 31;
  }

  static bool isLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }

  static DateTime getFirstDayOfMonth(int year, int month) {
    return DateTime(year, month, 1);
  }

  static DateTime getLastDayOfMonth(int year, int month) {
    return DateTime(year, month + 1, 0);
  }
}
