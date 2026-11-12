import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/auth/presentation/pages/auth_gate.dart';
import 'l10n/generated/app_localizations.dart';

Future<void> main() async {
  // يجب تهيئة Flutter قبل استدعاء أي خدمة غير متزامنة.
  WidgetsFlutterBinding.ensureInitialized();

  // المفتاح هنا Publishable فقط. لا تضع sb_secret أو service_role في التطبيق.
  await Supabase.initialize(
    url: 'https://jrussemahbkzvqruzapp.supabase.co',
    publishableKey: 'sb_publishable_X27u_cuJZBULP45YcAhe3Q_sFDIqGy_',
  );

  runApp(const ShamsunaApp());
}

class ShamsunaApp extends StatelessWidget {
  const ShamsunaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'شمسنا',
      locale: const Locale('ar'),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // يضمن اتجاه RTL على مستوى التطبيق كله.
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child ?? const SizedBox.shrink(),
        );
      },
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'ThmanyahSerifDisplay',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF126E9B)),
      ),
      home: const AuthGate(),
    );
  }
}
