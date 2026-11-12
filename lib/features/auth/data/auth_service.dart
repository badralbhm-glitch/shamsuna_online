import 'package:supabase_flutter/supabase_flutter.dart';

/// طبقة المصادقة الخاصة بالتطبيق.
///
/// نعزل Supabase Auth عن Widgets حتى تبقى الواجهات مسؤولة عن العرض فقط،
/// ويمكن اختبارها أو تغييرها لاحقًا دون إعادة بناء كل الشاشات.
class AuthService {
  AuthService({SupabaseClient? client})
    : _auth = (client ?? Supabase.instance.client).auth;

  final GoTrueClient _auth;

  /// الجلسة الحالية، أو null إذا لم يسجل المستخدم الدخول.
  Session? get currentSession => _auth.currentSession;

  /// بث تغيّرات الجلسة لاستخدامه لاحقًا في AuthGate.
  Stream<AuthState> get authStateChanges => _auth.onAuthStateChange;

  /// إنشاء حساب جديد بالبريد وكلمة المرور.
  ///
  /// لا نخزن كلمة المرور في قاعدة البيانات العامة؛ Supabase Auth يتولى ذلك.
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    String? displayName,
  }) async {
    final normalizedEmail = email.trim().toLowerCase();

    if (normalizedEmail.isEmpty) {
      throw const AuthException('البريد الإلكتروني مطلوب.');
    }
    if (password.length < 6) {
      throw const AuthException(
        'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل.',
      );
    }

    return _auth.signUp(
      email: normalizedEmail,
      password: password,
      data: {
        if (displayName != null && displayName.trim().isNotEmpty)
          'display_name': displayName.trim(),
      },
    );
  }

  /// تسجيل الدخول بالبريد وكلمة المرور.
  Future<AuthResponse> signInWithPassword({
    required String email,
    required String password,
  }) async {
    final normalizedEmail = email.trim().toLowerCase();

    if (normalizedEmail.isEmpty) {
      throw const AuthException('البريد الإلكتروني مطلوب.');
    }
    if (password.isEmpty) {
      throw const AuthException('كلمة المرور مطلوبة.');
    }

    return _auth.signInWithPassword(email: normalizedEmail, password: password);
  }

  /// إرسال رابط إعادة تعيين كلمة المرور.
  Future<void> resetPasswordForEmail(String email) async {
    final normalizedEmail = email.trim().toLowerCase();

    if (normalizedEmail.isEmpty) {
      throw const AuthException('البريد الإلكتروني مطلوب.');
    }

    await _auth.resetPasswordForEmail(normalizedEmail);
  }

  /// تسجيل الخروج من الجلسة الحالية.
  Future<void> signOut() => _auth.signOut();
}
