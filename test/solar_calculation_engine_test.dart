import 'package:flutter_test/flutter_test.dart';

import 'package:shamsuna_online/features/calculation/domain/solar_calculation_engine.dart';

void main() {
  const engine = SolarCalculationEngine();

  test('يحسب مثال وثيقة شمسنا الحسابي بدقة', () {
    const input = SolarCalculationInput(
      loads: [
        ApplianceLoad(
          name: 'لمبات LED',
          wattageW: 10,
          quantity: 6,
          dayHours: 0,
          nightHours: 6,
          runsDuringPeak: true,
        ),
        ApplianceLoad(
          name: 'شاشة تلفزيون',
          wattageW: 80,
          quantity: 1,
          dayHours: 2,
          nightHours: 5,
          runsDuringPeak: true,
        ),
        ApplianceLoad(
          name: 'ثلاجة',
          wattageW: 150,
          quantity: 1,
          dayHours: 12,
          nightHours: 12,
          runsDuringPeak: true,
        ),
        ApplianceLoad(
          name: 'مروحة سقف',
          wattageW: 75,
          quantity: 2,
          dayHours: 4,
          nightHours: 2,
          runsDuringPeak: true,
        ),
      ],
    );

    final result = engine.calculate(input);

    expect(result.dayEnergyWh, closeTo(2560, 0.001));
    expect(result.nightEnergyWh, closeTo(2860, 0.001));
    expect(result.totalEnergyWh, closeTo(5420, 0.001));
    expect(result.peakLoadW, closeTo(440, 0.001));
    expect(result.recommendedPanelWp, closeTo(1379.636, 0.01));
    expect(result.recommendedBatteryAh, closeTo(476.666, 0.01));
    expect(result.recommendedInverterW, closeTo(550, 0.001));
  });

  test('يكشف أن البطارية غير كافية عندما يتجاوز عمق التفريغ 100%', () {
    final dod = engine.calculateActualDodPercent(
      nightEnergyWh: 2860,
      actualBatteryAh: 100,
      systemVoltageV: 12,
    );

    expect(dod, closeTo(238.333, 0.01));
    expect(dod > 100, isTrue);
  });

  test('يحسب العمر المتوقع بالأشهر', () {
    final months = engine.calculateLifeMonths(expectedCycles: 1050);
    expect(months, closeTo(34.493, 0.01));
  });

  test('يرفض المحرك ساعات التشغيل غير الصالحة', () {
    const input = SolarCalculationInput(
      loads: [
        ApplianceLoad(
          name: 'جهاز غير صالح',
          wattageW: 100,
          quantity: 1,
          dayHours: 25,
          nightHours: 0,
          runsDuringPeak: false,
        ),
      ],
    );

    expect(() => engine.calculate(input), throwsArgumentError);
  });
}
