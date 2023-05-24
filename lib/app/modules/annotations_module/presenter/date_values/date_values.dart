class DateValues {
  final minutesDateTime = DateTime.now().minute;
  final dayDateTime = DateTime.now().day;
  final monthDateTime = DateTime.now().month;
  final yearDateTime = DateTime.now().year;
  final hoursDateTime = DateTime.now().hour;
  String get annotationDayDateTime =>
      '${dayDateTime >= 10 ? dayDateTime : '0$dayDateTime'}/${monthDateTime >= 10 ? monthDateTime : '0$monthDateTime'}/${yearDateTime >= 10 ? yearDateTime : '0$yearDateTime'}';
  String get annotationHourDateTime =>
      '${hoursDateTime >= 10 ? hoursDateTime : '0$hoursDateTime'}:${minutesDateTime >= 10 ? minutesDateTime : '0$minutesDateTime'}';
}
