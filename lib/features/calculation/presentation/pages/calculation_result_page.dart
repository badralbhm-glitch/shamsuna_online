import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../calculation/domain/solar_calculation_engine.dart';

/// شاشة عرض نتيجة التصميم المقترح للمنظومة.
class CalculationResultPage extends StatelessWidget {
  const CalculationResultPage({
    required this.result,
    required this.reportId,
    super.key,
  });

  final SolarCalculationResult result;
  final int reportId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.calculationResult)),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Text(
            l10n.resultSaved,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.solarBlue,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 16),
          _ResultTile(
            label: l10n.totalDayEnergy,
            value: '${result.dayEnergyWh.toStringAsFixed(1)} Wh',
            icon: Icons.wb_sunny_outlined,
          ),
          _ResultTile(
            label: l10n.totalNightEnergy,
            value: '${result.nightEnergyWh.toStringAsFixed(1)} Wh',
            icon: Icons.nightlight_outlined,
          ),
          _ResultTile(
            label: l10n.totalEnergy,
            value: '${result.totalEnergyWh.toStringAsFixed(1)} Wh',
            icon: Icons.bolt_outlined,
          ),
          _ResultTile(
            label: l10n.peakLoad,
            value: '${result.peakLoadW.toStringAsFixed(1)} W',
            icon: Icons.flash_on_outlined,
          ),
          _ResultTile(
            label: l10n.recommendedPanels,
            value: '${result.recommendedPanelWp.toStringAsFixed(1)} Wp',
            icon: Icons.solar_power_outlined,
          ),
          _ResultTile(
            label: l10n.recommendedBattery,
            value: '${result.recommendedBatteryAh.toStringAsFixed(1)} Ah',
            icon: Icons.battery_charging_full_outlined,
          ),
          _ResultTile(
            label: l10n.recommendedInverter,
            value: '${result.recommendedInverterW.toStringAsFixed(1)} W',
            icon: Icons.power_outlined,
          ),
          const SizedBox(height: 16),
          Text(
            '${l10n.reportNumber}: $reportId',
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}

class _ResultTile extends StatelessWidget {
  const _ResultTile({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(icon, color: AppColors.solarBlue),
        title: Text(label),
        trailing: Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}
