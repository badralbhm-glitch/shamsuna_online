import 'package:supabase_flutter/supabase_flutter.dart';

import '../domain/solar_calculation_engine.dart';

/// طبقة الوصول إلى بيانات التقارير.
///
/// لا تضع الواجهة استعلامات Supabase مباشرة؛ هذا الفصل يجعل تغيير مصدر البيانات
/// أو اختبار منطق الحفظ لاحقًا أسهل، ويضمن استخدام جلسة المستخدم الحالية.
class ReportRepository {
  ReportRepository({SupabaseClient? client})
    : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  Future<int> saveReport({
    required String title,
    required SolarCalculationInput input,
    required SolarCalculationResult result,
    String batteryChemistry = 'GEL',
    double batteryVoltageV = 12,
    double batteryDodTargetPercent = 50,
  }) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) {
      throw const AuthException('يجب تسجيل الدخول قبل حفظ التقرير.');
    }

    final report = await _client
        .from('system_reports')
        .insert({
          'user_id': userId,
          'report_title': title,
          'total_day_wh': result.dayEnergyWh,
          'total_night_wh': result.nightEnergyWh,
          'total_wh': result.totalEnergyWh,
          'peak_load_w': result.peakLoadW,
          'recommended_panel_wp': result.recommendedPanelWp,
          'recommended_inverter_w': result.recommendedInverterW,
          'recommended_battery_ah': result.recommendedBatteryAh,
          'battery_chemistry': batteryChemistry,
          'battery_voltage_v': batteryVoltageV,
          'battery_dod_target_pct': batteryDodTargetPercent,
        })
        .select('report_id')
        .single();

    final reportId = (report['report_id'] as num).toInt();

    await _client
        .from('report_appliance_details')
        .insert(
          input.loads
              .map(
                (load) => {
                  'report_id': reportId,
                  'appliance_name_ar_snapshot': load.name.trim(),
                  'unit_wattage_w': load.wattageW,
                  'quantity': load.quantity,
                  'running_hours_day': load.dayHours,
                  'running_hours_night': load.nightHours,
                  'energy_day_wh':
                      load.wattageW * load.quantity * load.dayHours,
                  'energy_night_wh':
                      load.wattageW * load.quantity * load.nightHours,
                  'runs_during_peak': load.runsDuringPeak,
                },
              )
              .toList(),
        );

    return reportId;
  }
}
