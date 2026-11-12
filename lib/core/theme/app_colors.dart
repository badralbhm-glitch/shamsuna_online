import 'package:flutter/material.dart';

/// لوحة ألوان شمسنا المستخرجة من السماء والسحب والألواح والهيكل المعدني.
///
/// وضع الألوان في ملف واحد يجعل تعديل الهوية البصرية لاحقًا آمنًا وسريعًا.
abstract final class AppColors {
  static const sky = Color(0xFFDCEAF7);
  static const cloud = Color(0xFFB9CDE1);
  static const metalBlue = Color(0xFF1E668C);
  static const solarBlue = Color(0xFF2B789C);
  static const panelNavy = Color(0xFF071A2B);
  static const panelNavySoft = Color(0xCC071A2B);
  static const textLight = Color(0xFFF7FAFF);
  static const textMuted = Color(0xFFDCE8F2);
  static const borderLight = Color(0xB3F7FAFF);
  static const error = Color(0xFFFFC4C4);
  static const buttonText = Color(0xFF071A2B);
}
