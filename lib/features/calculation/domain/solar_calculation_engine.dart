/// نموذج حمل كهربائي واحد كما يدخله المستخدم في تقريره.
///
/// جميع القدرات بالواط W، والساعات هي ساعات تشغيل يومية.
class ApplianceLoad {
  const ApplianceLoad({
    required this.name,
    required this.wattageW,
    required this.quantity,
    required this.dayHours,
    required this.nightHours,
    required this.runsDuringPeak,
  });

  final String name;
  final double wattageW;
  final int quantity;
  final double dayHours;
  final double nightHours;
  final bool runsDuringPeak;

  void validate() {
    if (name.trim().isEmpty) {
      throw ArgumentError('اسم الجهاز مطلوب.');
    }
    if (wattageW <= 0) {
      throw ArgumentError('قدرة الجهاز يجب أن تكون أكبر من صفر.');
    }
    if (quantity <= 0) {
      throw ArgumentError('كمية الجهاز يجب أن تكون أكبر من صفر.');
    }
    if (dayHours < 0 || dayHours > 24) {
      throw ArgumentError('ساعات النهار يجب أن تكون بين 0 و24.');
    }
    if (nightHours < 0 || nightHours > 24) {
      throw ArgumentError('ساعات الليل يجب أن تكون بين 0 و24.');
    }
  }
}

/// مدخلات تصميم المنظومة.
///
/// القيم الافتراضية مأخوذة من وثيقة متطلبات شمسنا، ويمكن جعلها إعدادات
/// قابلة للتعديل لاحقًا عندما نضيف شاشة الإعدادات.
class SolarCalculationInput {
  const SolarCalculationInput({
    required this.loads,
    this.peakSunHours = 5.5,
    this.panelLossFactor = 1.4,
    this.systemVoltageV = 12,
    this.targetDodPercent = 50,
    this.inverterSurgeFactor = 1.25,
  });

  final List<ApplianceLoad> loads;
  final double peakSunHours;
  final double panelLossFactor;
  final double systemVoltageV;
  final double targetDodPercent;
  final double inverterSurgeFactor;

  void validate() {
    if (loads.isEmpty) {
      throw ArgumentError('يجب إدخال حمل واحد على الأقل.');
    }
    for (final load in loads) {
      load.validate();
    }
    if (peakSunHours <= 0) {
      throw ArgumentError('ساعات ذروة الشمس يجب أن تكون أكبر من صفر.');
    }
    if (panelLossFactor < 1) {
      throw ArgumentError('معامل الفقد يجب أن يكون 1 أو أكبر.');
    }
    if (systemVoltageV <= 0) {
      throw ArgumentError('جهد النظام يجب أن يكون أكبر من صفر.');
    }
    if (targetDodPercent <= 0 || targetDodPercent > 100) {
      throw ArgumentError('عمق التفريغ المستهدف يجب أن يكون بين 0 و100%.');
    }
    if (inverterSurgeFactor <= 0) {
      throw ArgumentError('معامل أمان العاكس يجب أن يكون أكبر من صفر.');
    }
  }
}

/// نتيجة المحرك الحسابي، ولا تحتوي على أي اتصال بواجهة المستخدم أو Supabase.
class SolarCalculationResult {
  const SolarCalculationResult({
    required this.dayEnergyWh,
    required this.nightEnergyWh,
    required this.totalEnergyWh,
    required this.peakLoadW,
    required this.recommendedPanelWp,
    required this.recommendedBatteryAh,
    required this.recommendedInverterW,
  });

  final double dayEnergyWh;
  final double nightEnergyWh;
  final double totalEnergyWh;
  final double peakLoadW;
  final double recommendedPanelWp;
  final double recommendedBatteryAh;
  final double recommendedInverterW;
}

/// محرك حساب حتمي Pure Function.
///
/// فصل المحرك عن Flutter وSupabase يجعل اختباره سهلًا ويمنع خلط الحسابات
/// الهندسية بتفاصيل الشبكة أو الواجهة.
class SolarCalculationEngine {
  const SolarCalculationEngine();

  SolarCalculationResult calculate(SolarCalculationInput input) {
    input.validate();

    double dayEnergyWh = 0;
    double nightEnergyWh = 0;
    double peakLoadW = 0;

    for (final load in input.loads) {
      final connectedLoadW = load.wattageW * load.quantity;
      dayEnergyWh += connectedLoadW * load.dayHours;
      nightEnergyWh += connectedLoadW * load.nightHours;

      // لا يدخل الجهاز في Peak Load إلا إذا حدده المستخدم ضمن أحمال الذروة.
      if (load.runsDuringPeak) {
        peakLoadW += connectedLoadW;
      }
    }

    final totalEnergyWh = dayEnergyWh + nightEnergyWh;

    // Wpanels = (Etotal / PSH) * Sf
    final recommendedPanelWp =
        (totalEnergyWh / input.peakSunHours) * input.panelLossFactor;

    // CAh = Enight / (Vsystem * DoDtarget)
    final targetDodFraction = input.targetDodPercent / 100;
    final recommendedBatteryAh =
        nightEnergyWh / (input.systemVoltageV * targetDodFraction);

    // Pinv = PeakLoad * 1.25
    final recommendedInverterW = peakLoadW * input.inverterSurgeFactor;

    return SolarCalculationResult(
      dayEnergyWh: dayEnergyWh,
      nightEnergyWh: nightEnergyWh,
      totalEnergyWh: totalEnergyWh,
      peakLoadW: peakLoadW,
      recommendedPanelWp: recommendedPanelWp,
      recommendedBatteryAh: recommendedBatteryAh,
      recommendedInverterW: recommendedInverterW,
    );
  }

  /// يحسب عمق التفريغ الفعلي لبطارية يحددها المستخدم.
  ///
  /// النتيجة نسبة مئوية. إذا تجاوزت 100% فهذا يعني أن البطارية غير كافية
  /// لتغطية الطاقة الليلية المطلوبة.
  double calculateActualDodPercent({
    required double nightEnergyWh,
    required double actualBatteryAh,
    required double systemVoltageV,
  }) {
    if (nightEnergyWh < 0 || actualBatteryAh <= 0 || systemVoltageV <= 0) {
      throw ArgumentError('قيم حساب عمق التفريغ غير صالحة.');
    }

    return (nightEnergyWh / (actualBatteryAh * systemVoltageV)) * 100;
  }

  /// يحول عدد دورات البطارية المتوقعة إلى أشهر.
  double calculateLifeMonths({required int expectedCycles}) {
    if (expectedCycles <= 0) {
      throw ArgumentError('عدد الدورات المتوقعة يجب أن يكون أكبر من صفر.');
    }

    return expectedCycles / 30.44;
  }
}
