import 'package:app/core/theme/app_pallet.dart';
import 'package:app/core/theme/theme.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class XPChart extends StatelessWidget {
  final Map<String, double> xpPerDay;

  const XPChart({super.key, required this.xpPerDay});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final chartColors = theme.extension<ChartColors>();
    final weeklyXP = _getWeeklyXP(xpPerDay);
    final maxXP = weeklyXP.reduce((a, b) => a > b ? a : b);
    final interval = _calculateInterval(maxXP);

    return Card(
      color: chartColors?.background,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.weeklyXpProgress,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: chartColors?.text,
              ),
            ),
            const SizedBox(height: 16),
            AspectRatio(
              aspectRatio: 1.7,
              child: BarChart(
                BarChartData(
                  maxY: maxXP + interval, // Add some padding at the top
                  barGroups: _barDataFromXP(
                      xpPerDay, chartColors?.bar ?? AppPalette.chartBarLight),
                  borderData: FlBorderData(
                    show: true,
                    border: Border(
                      bottom: BorderSide(
                        color:
                            chartColors?.border ?? AppPalette.chartBorderLight,
                        width: 1,
                      ),
                      left: BorderSide(
                        color:
                            chartColors?.border ?? AppPalette.chartBorderLight,
                        width: 1,
                      ),
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: interval,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color:
                            (chartColors?.border ?? AppPalette.chartBorderLight)
                                .withOpacity(0.2),
                        strokeWidth: 1,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: interval,
                        reservedSize: 40,
                        getTitlesWidget: (value, _) {
                          return Text(
                            value.toInt().toString(),
                            style: TextStyle(
                              fontSize: 12,
                              color: chartColors?.text?.withOpacity(0.8),
                            ),
                          );
                        },
                      ),
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
                          final days = [
                            l10n.monday,
                            l10n.tuesday,
                            l10n.wednesday,
                            l10n.thursday,
                            l10n.friday,
                            l10n.saturday,
                            l10n.sunday
                          ];
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              days[value.toInt() % 7],
                              style: TextStyle(
                                fontSize: 12,
                                color: chartColors?.text?.withOpacity(0.8),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  backgroundColor: chartColors?.background,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _calculateInterval(double maxValue) {
    if (maxValue <= 0) return 10;

    // Find the magnitude of the max value
    final magnitude = (maxValue / 5).ceil();

    // Round to a nice number
    if (magnitude <= 5) return 5;
    if (magnitude <= 10) return 10;
    if (magnitude <= 20) return 20;
    if (magnitude <= 25) return 25;
    if (magnitude <= 50) return 50;

    return (magnitude / 50).ceil() * 50;
  }

  List<BarChartGroupData> _barDataFromXP(
      Map<String, double> xpPerDay, Color barColor) {
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
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: weeklyXP.reduce((a, b) => a > b ? a : b),
              color: barColor.withOpacity(0.1),
            ),
          ),
        ],
      );
    });
  }

  List<double> _getWeeklyXP(Map<String, double> xpPerDay) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final startOfWeek =
        today.subtract(Duration(days: today.weekday - 1)); // Monday

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
