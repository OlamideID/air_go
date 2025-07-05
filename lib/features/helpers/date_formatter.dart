// class DateFormatter {
//   static String formatDate(DateTime date) {
//     return '${_weekdays[date.weekday]} ${date.day} ${_months[date.month]} ${date.year}';
//   }

//   static String formatTime(DateTime time) {
//     final hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
//     final period = time.hour < 12 ? 'AM' : 'PM';
//     return '$hour:${time.minute.toString().padLeft(2, '0')} $period';
//   }

//   static String formatDateTime(DateTime dateTime) {
//     return '${formatDate(dateTime)} at ${formatTime(dateTime)}';
//   }

//   static String formatDuration(int minutes) {
//     final hours = minutes ~/ 60;
//     final mins = minutes % 60;
//     return '${hours}h ${mins}m';
//   }

//   static const _weekdays = {
//     1: 'Mon',
//     2: 'Tue',
//     3: 'Wed',
//     4: 'Thu',
//     5: 'Fri',
//     6: 'Sat',
//     7: 'Sun',
//   };

//   static const _months = {
//     1: 'Jan',
//     2: 'Feb',
//     3: 'Mar',
//     4: 'Apr',
//     5: 'May',
//     6: 'Jun',
//     7: 'Jul',
//     8: 'Aug',
//     9: 'Sep',
//     10: 'Oct',
//     11: 'Nov',
//     12: 'Dec',
//   };
// }