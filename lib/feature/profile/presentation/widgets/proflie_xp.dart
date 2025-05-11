import 'package:app/core/theme/app_pallet.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class XPChart extends StatelessWidget {
  final Map<String, double> xpPerDay;

  const XPChart({super.key, required this.xpPerDay});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppPalette.cardBackground,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Weekly XP Progress",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppPalette.chartBar,
                  ),
            ),
            const SizedBox(height: 16),
            AspectRatio(
              aspectRatio: 1.7,
              child: BarChart(
                BarChartData(
                  barGroups: _barDataFromXP(xpPerDay, AppPalette.chartBar),
                  borderData: FlBorderData(show: false),
                  gridData: const FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              days[value.toInt() % 7],
                              style: const TextStyle(fontSize: 12),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<BarChartGroupData> _barDataFromXP(Map<String, double> xpPerDay, Color barColor) {
    final weeklyXP = _getWeeklyXP(xpPerDay);
    return List.generate(weeklyXP.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: weeklyXP[index],
            color: barColor,
            width: 14,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    });
  }

  List<double> _getWeeklyXP(Map<String, double> xpPerDay) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final startOfWeek = today.subtract(Duration(days: today.weekday - 1)); // Monday

    final result = List<double>.filled(7, 0);

    xpPerDay.forEach((dateStr, xp) {
      final date = DateTime.tryParse(dateStr);
      if (date != null) {
        final diff = date.difference(startOfWeek).inDays;
        if (diff >= 0 && diff < 7) {
          result[diff] += xp;
        }
      }
    });

    return result;
  }
}
