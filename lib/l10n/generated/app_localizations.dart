import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('ar')];

  /// No description provided for @appTitle.
  ///
  /// In ar, this message translates to:
  /// **'شمسنا'**
  String get appTitle;

  /// No description provided for @welcome.
  ///
  /// In ar, this message translates to:
  /// **'مرحبًا بك في شمسنا'**
  String get welcome;

  /// No description provided for @rtlTest.
  ///
  /// In ar, this message translates to:
  /// **'هذه واجهة عربية من اليمين إلى اليسار'**
  String get rtlTest;

  /// No description provided for @loginSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'مستشارك الذكي لأنظمة الطاقة الشمسية'**
  String get loginSubtitle;

  /// No description provided for @loginTitle.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول'**
  String get loginTitle;

  /// No description provided for @emailLabel.
  ///
  /// In ar, this message translates to:
  /// **'البريد الإلكتروني'**
  String get emailLabel;

  /// No description provided for @emailHint.
  ///
  /// In ar, this message translates to:
  /// **'أدخل بريدك الإلكتروني'**
  String get emailHint;

  /// No description provided for @passwordLabel.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور'**
  String get passwordLabel;

  /// No description provided for @passwordHint.
  ///
  /// In ar, this message translates to:
  /// **'أدخل كلمة المرور'**
  String get passwordHint;

  /// No description provided for @forgotPassword.
  ///
  /// In ar, this message translates to:
  /// **'نسيت كلمة السر؟'**
  String get forgotPassword;

  /// No description provided for @loginButton.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول'**
  String get loginButton;

  /// No description provided for @showPassword.
  ///
  /// In ar, this message translates to:
  /// **'إظهار كلمة المرور'**
  String get showPassword;

  /// No description provided for @hidePassword.
  ///
  /// In ar, this message translates to:
  /// **'إخفاء كلمة المرور'**
  String get hidePassword;

  /// No description provided for @emailRequired.
  ///
  /// In ar, this message translates to:
  /// **'البريد الإلكتروني مطلوب.'**
  String get emailRequired;

  /// No description provided for @emailInvalid.
  ///
  /// In ar, this message translates to:
  /// **'أدخل بريدًا إلكترونيًا صحيحًا.'**
  String get emailInvalid;

  /// No description provided for @passwordRequired.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور مطلوبة.'**
  String get passwordRequired;

  /// No description provided for @passwordTooShort.
  ///
  /// In ar, this message translates to:
  /// **'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل.'**
  String get passwordTooShort;

  /// No description provided for @invalidLoginCredentials.
  ///
  /// In ar, this message translates to:
  /// **'بيانات الدخول غير صحيحة.'**
  String get invalidLoginCredentials;

  /// No description provided for @emailNotConfirmed.
  ///
  /// In ar, this message translates to:
  /// **'لم يتم تأكيد البريد الإلكتروني بعد.'**
  String get emailNotConfirmed;

  /// No description provided for @loginFailed.
  ///
  /// In ar, this message translates to:
  /// **'تعذر تسجيل الدخول. حاول مرة أخرى.'**
  String get loginFailed;

  /// No description provided for @unexpectedError.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ غير متوقع.'**
  String get unexpectedError;

  /// No description provided for @emailRequiredForReset.
  ///
  /// In ar, this message translates to:
  /// **'أدخل بريدك الإلكتروني أولًا لإرسال رابط الاستعادة.'**
  String get emailRequiredForReset;

  /// No description provided for @resetEmailSent.
  ///
  /// In ar, this message translates to:
  /// **'تم إرسال رابط استعادة كلمة المرور إلى بريدك.'**
  String get resetEmailSent;

  /// No description provided for @resetEmailFailed.
  ///
  /// In ar, this message translates to:
  /// **'تعذر إرسال رابط الاستعادة. حاول مرة أخرى.'**
  String get resetEmailFailed;

  /// No description provided for @googleLogin.
  ///
  /// In ar, this message translates to:
  /// **'المتابعة عبر Google'**
  String get googleLogin;

  /// No description provided for @googleSetupPending.
  ///
  /// In ar, this message translates to:
  /// **'سيتم تفعيل تسجيل Google بعد إكمال إعداد OAuth.'**
  String get googleSetupPending;

  /// No description provided for @loginFooter.
  ///
  /// In ar, this message translates to:
  /// **'طاقة أنظف، وقرار أذكى'**
  String get loginFooter;

  /// No description provided for @noAccount.
  ///
  /// In ar, this message translates to:
  /// **'ليس لديك حساب؟'**
  String get noAccount;

  /// No description provided for @createAccount.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء حساب'**
  String get createAccount;

  /// No description provided for @displayName.
  ///
  /// In ar, this message translates to:
  /// **'الاسم'**
  String get displayName;

  /// No description provided for @displayNameHint.
  ///
  /// In ar, this message translates to:
  /// **'أدخل اسمك'**
  String get displayNameHint;

  /// No description provided for @nameRequired.
  ///
  /// In ar, this message translates to:
  /// **'الاسم مطلوب.'**
  String get nameRequired;

  /// No description provided for @accountCreated.
  ///
  /// In ar, this message translates to:
  /// **'تم إنشاء الحساب بنجاح.'**
  String get accountCreated;

  /// No description provided for @confirmEmailToContinue.
  ///
  /// In ar, this message translates to:
  /// **'تم إنشاء الحساب. تحقق من بريدك الإلكتروني للتفعيل.'**
  String get confirmEmailToContinue;

  /// No description provided for @backToLogin.
  ///
  /// In ar, this message translates to:
  /// **'العودة إلى تسجيل الدخول'**
  String get backToLogin;

  /// No description provided for @loadEntryTitle.
  ///
  /// In ar, this message translates to:
  /// **'إدخال أحمال الأجهزة'**
  String get loadEntryTitle;

  /// No description provided for @loadEntrySubtitle.
  ///
  /// In ar, this message translates to:
  /// **'أدخل قدرة كل جهاز وساعات تشغيله نهارًا وليلاً.'**
  String get loadEntrySubtitle;

  /// No description provided for @reportTitle.
  ///
  /// In ar, this message translates to:
  /// **'اسم التقرير'**
  String get reportTitle;

  /// No description provided for @defaultReportTitle.
  ///
  /// In ar, this message translates to:
  /// **'تقرير منظومة شمسنا'**
  String get defaultReportTitle;

  /// No description provided for @appliance.
  ///
  /// In ar, this message translates to:
  /// **'الجهاز'**
  String get appliance;

  /// No description provided for @applianceName.
  ///
  /// In ar, this message translates to:
  /// **'اسم الجهاز'**
  String get applianceName;

  /// No description provided for @wattage.
  ///
  /// In ar, this message translates to:
  /// **'القدرة بالواط'**
  String get wattage;

  /// No description provided for @quantity.
  ///
  /// In ar, this message translates to:
  /// **'الكمية'**
  String get quantity;

  /// No description provided for @dayHours.
  ///
  /// In ar, this message translates to:
  /// **'ساعات النهار'**
  String get dayHours;

  /// No description provided for @nightHours.
  ///
  /// In ar, this message translates to:
  /// **'ساعات الليل'**
  String get nightHours;

  /// No description provided for @runsDuringPeak.
  ///
  /// In ar, this message translates to:
  /// **'يعمل أثناء الذروة'**
  String get runsDuringPeak;

  /// No description provided for @addAppliance.
  ///
  /// In ar, this message translates to:
  /// **'إضافة جهاز'**
  String get addAppliance;

  /// No description provided for @removeAppliance.
  ///
  /// In ar, this message translates to:
  /// **'حذف الجهاز'**
  String get removeAppliance;

  /// No description provided for @calculateSystem.
  ///
  /// In ar, this message translates to:
  /// **'حساب المنظومة وحفظ التقرير'**
  String get calculateSystem;

  /// No description provided for @invalidNumber.
  ///
  /// In ar, this message translates to:
  /// **'أدخل رقمًا صحيحًا غير سالب.'**
  String get invalidNumber;

  /// No description provided for @wattageRequired.
  ///
  /// In ar, this message translates to:
  /// **'أدخل قدرة أكبر من صفر.'**
  String get wattageRequired;

  /// No description provided for @quantityRequired.
  ///
  /// In ar, this message translates to:
  /// **'أدخل كمية أكبر من صفر.'**
  String get quantityRequired;

  /// No description provided for @calculationSaveFailed.
  ///
  /// In ar, this message translates to:
  /// **'تعذر تنفيذ الحساب أو حفظ التقرير. تحقق من الاتصال وتسجيل الدخول.'**
  String get calculationSaveFailed;

  /// No description provided for @calculationResult.
  ///
  /// In ar, this message translates to:
  /// **'نتيجة حساب المنظومة'**
  String get calculationResult;

  /// No description provided for @resultSaved.
  ///
  /// In ar, this message translates to:
  /// **'تم حفظ التقرير بنجاح'**
  String get resultSaved;

  /// No description provided for @totalDayEnergy.
  ///
  /// In ar, this message translates to:
  /// **'طاقة النهار'**
  String get totalDayEnergy;

  /// No description provided for @totalNightEnergy.
  ///
  /// In ar, this message translates to:
  /// **'طاقة الليل'**
  String get totalNightEnergy;

  /// No description provided for @totalEnergy.
  ///
  /// In ar, this message translates to:
  /// **'إجمالي الطاقة اليومية'**
  String get totalEnergy;

  /// No description provided for @peakLoad.
  ///
  /// In ar, this message translates to:
  /// **'حمل الذروة'**
  String get peakLoad;

  /// No description provided for @recommendedPanels.
  ///
  /// In ar, this message translates to:
  /// **'القدرة المقترحة للألواح'**
  String get recommendedPanels;

  /// No description provided for @recommendedBattery.
  ///
  /// In ar, this message translates to:
  /// **'سعة البطارية المقترحة'**
  String get recommendedBattery;

  /// No description provided for @recommendedInverter.
  ///
  /// In ar, this message translates to:
  /// **'قدرة العاكس المقترحة'**
  String get recommendedInverter;

  /// No description provided for @reportNumber.
  ///
  /// In ar, this message translates to:
  /// **'رقم التقرير'**
  String get reportNumber;

  /// No description provided for @logout.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الخروج'**
  String get logout;

  /// No description provided for @loginSuccess.
  ///
  /// In ar, this message translates to:
  /// **'تم تسجيل الدخول بنجاح'**
  String get loginSuccess;

  /// No description provided for @startCalculation.
  ///
  /// In ar, this message translates to:
  /// **'بدء حساب المنظومة'**
  String get startCalculation;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
