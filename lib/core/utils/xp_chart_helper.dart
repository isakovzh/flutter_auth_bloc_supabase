// Map<String, double> updateXpPerDay(
//     Map<String, double> currentXpPerDay, int addedXp) {
//   final today = DateTime.now();
//   final todayKey =
//       "\${today.year}-\${today.month.toString().padLeft(2, '0')}-\${today.day.toString().padLeft(2, '0')}";
//   final currentXp = currentXpPerDay[todayKey] ?? 0;
//   return {
//     ...currentXpPerDay,
//     todayKey: currentXp + addedXp,
//   };
// }
