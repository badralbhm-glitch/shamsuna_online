import 'package:flutter/material.dart';

import '../../../../l10n/generated/app_localizations.dart';
import '../../data/auth_service.dart';
import '../../../calculation/presentation/pages/load_entry_page.dart';

/// الصفحة الرئيسية بعد نجاح المصادقة.
class HomePage extends StatelessWidget {
  const HomePage({required this.email, super.key});

  final String email;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          IconButton(
            tooltip: l10n.logout,
            onPressed: () => AuthService().signOut(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${l10n.loginSuccess}\n$email',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 28),
              FilledButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const LoadEntryPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.solar_power_outlined),
                label: Text(l10n.startCalculation),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
