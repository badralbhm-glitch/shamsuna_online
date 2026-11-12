import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/auth_service.dart';
import 'home_page.dart';
import 'login_page.dart';

/// يقرر أول شاشة اعتمادًا على حالة جلسة Supabase الحالية.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return StreamBuilder<AuthState>(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        final session = snapshot.data?.session ?? authService.currentSession;

        if (session == null) {
          return const LoginPage();
        }

        return HomePage(email: session.user.email ?? '');
      },
    );
  }
}
