// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'شمسنا';

  @override
  String get welcome => 'مرحبًا بك في شمسنا';

  @override
  String get rtlTest => 'هذه واجهة عربية من اليمين إلى اليسار';

  @override
  String get loginSubtitle => 'مستشارك الذكي لأنظمة الطاقة الشمسية';

  @override
  String get loginTitle => 'تسجيل الدخول';

  @override
  String get emailLabel => 'البريد الإلكتروني';

  @override
  String get emailHint => 'أدخل بريدك الإلكتروني';

  @override
  String get passwordLabel => 'كلمة المرور';

  @override
  String get passwordHint => 'أدخل كلمة المرور';

  @override
  String get forgotPassword => 'نسيت كلمة السر؟';

  @override
  String get loginButton => 'تسجيل الدخول';

  @override
  String get showPassword => 'إظهار كلمة المرور';

  @override
  String get hidePassword => 'إخفاء كلمة المرور';

  @override
  String get emailRequired => 'البريد الإلكتروني مطلوب.';

  @override
  String get emailInvalid => 'أدخل بريدًا إلكترونيًا صحيحًا.';

  @override
  String get passwordRequired => 'كلمة المرور مطلوبة.';

  @override
  String get passwordTooShort =>
      'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل.';

  @override
  String get invalidLoginCredentials => 'بيانات الدخول غير صحيحة.';

  @override
  String get emailNotConfirmed => 'لم يتم تأكيد البريد الإلكتروني بعد.';

  @override
  String get loginFailed => 'تعذر تسجيل الدخول. حاول مرة أخرى.';

  @override
  String get unexpectedError => 'حدث خطأ غير متوقع.';

  @override
  String get emailRequiredForReset =>
      'أدخل بريدك الإلكتروني أولًا لإرسال رابط الاستعادة.';

  @override
  String get resetEmailSent => 'تم إرسال رابط استعادة كلمة المرور إلى بريدك.';

  @override
  String get resetEmailFailed => 'تعذر إرسال رابط الاستعادة. حاول مرة أخرى.';

  @override
  String get googleLogin => 'المتابعة عبر Google';

  @override
  String get googleSetupPending =>
      'سيتم تفعيل تسجيل Google بعد إكمال إعداد OAuth.';

  @override
  String get loginFooter => 'طاقة أنظف، وقرار أذكى';

  @override
  String get noAccount => 'ليس لديك حساب؟';

  @override
  String get createAccount => 'إنشاء حساب';

  @override
  String get displayName => 'الاسم';

  @override
  String get displayNameHint => 'أدخل اسمك';

  @override
  String get nameRequired => 'الاسم مطلوب.';

  @override
  String get accountCreated => 'تم إنشاء الحساب بنجاح.';

  @override
  String get confirmEmailToContinue =>
      'تم إنشاء الحساب. تحقق من بريدك الإلكتروني للتفعيل.';

  @override
  String get backToLogin => 'العودة إلى تسجيل الدخول';

  @override
  String get loadEntryTitle => 'إدخال أحمال الأجهزة';

  @override
  String get loadEntrySubtitle =>
      'أدخل قدرة كل جهاز وساعات تشغيله نهارًا وليلاً.';

  @override
  String get reportTitle => 'اسم التقرير';

  @override
  String get defaultReportTitle => 'تقرير منظومة شمسنا';

  @override
  String get appliance => 'الجهاز';

  @override
  String get applianceName => 'اسم الجهاز';

  @override
  String get wattage => 'القدرة بالواط';

  @override
  String get quantity => 'الكمية';

  @override
  String get dayHours => 'ساعات النهار';

  @override
  String get nightHours => 'ساعات الليل';

  @override
  String get runsDuringPeak => 'يعمل أثناء الذروة';

  @override
  String get addAppliance => 'إضافة جهاز';

  @override
  String get removeAppliance => 'حذف الجهاز';

  @override
  String get calculateSystem => 'حساب المنظومة وحفظ التقرير';

  @override
  String get invalidNumber => 'أدخل رقمًا صحيحًا غير سالب.';

  @override
  String get wattageRequired => 'أدخل قدرة أكبر من صفر.';

  @override
  String get quantityRequired => 'أدخل كمية أكبر من صفر.';

  @override
  String get calculationSaveFailed =>
      'تعذر تنفيذ الحساب أو حفظ التقرير. تحقق من الاتصال وتسجيل الدخول.';

  @override
  String get calculationResult => 'نتيجة حساب المنظومة';

  @override
  String get resultSaved => 'تم حفظ التقرير بنجاح';

  @override
  String get totalDayEnergy => 'طاقة النهار';

  @override
  String get totalNightEnergy => 'طاقة الليل';

  @override
  String get totalEnergy => 'إجمالي الطاقة اليومية';

  @override
  String get peakLoad => 'حمل الذروة';

  @override
  String get recommendedPanels => 'القدرة المقترحة للألواح';

  @override
  String get recommendedBattery => 'سعة البطارية المقترحة';

  @override
  String get recommendedInverter => 'قدرة العاكس المقترحة';

  @override
  String get reportNumber => 'رقم التقرير';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get loginSuccess => 'تم تسجيل الدخول بنجاح';

  @override
  String get startCalculation => 'بدء حساب المنظومة';
}
