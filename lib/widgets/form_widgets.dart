import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';

import '../app_theme.dart';

/// Image from assets/images, with an icon shown until the file is added.
class AssetImageOrIcon extends StatelessWidget {
  const AssetImageOrIcon({
    super.key,
    required this.asset,
    required this.fallbackIcon,
    required this.size,
    this.fallbackColor = AppColors.primary,
  });

  final String asset;
  final IconData fallbackIcon;
  final double size;
  final Color fallbackColor;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset,
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (_, _, _) =>
          Icon(fallbackIcon, size: size * 0.85, color: fallbackColor),
    );
  }
}

/// Small label above a text field, e.g. "น้ำหนัก (kg.)".
class FieldLabel extends StatelessWidget {
  const FieldLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, top: 14),
      child: Text(
        text,
        style: GoogleFonts.kanit(fontSize: 14, color: AppColors.textDark),
      ),
    );
  }
}

/// Number field. [decimal] allows one decimal point.
class NumberField extends StatelessWidget {
  const NumberField({
    super.key,
    required this.controller,
    required this.hint,
    this.decimal = true,
  });

  final TextEditingController controller;
  final String hint;
  final bool decimal;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(decimal: decimal),
      inputFormatters: [
        decimal
            ? FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))
            : FilteringTextInputFormatter.digitsOnly,
      ],
      style: GoogleFonts.kanit(fontSize: 15),
      decoration: InputDecoration(hintText: hint),
    );
  }
}

/// "คำนวณ" and "ล้างข้อมูล" buttons.
class CalculateButtons extends StatelessWidget {
  const CalculateButtons({
    super.key,
    required this.calculateLabel,
    required this.onCalculate,
    required this.onClear,
  });

  final String calculateLabel;
  final VoidCallback onCalculate;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 24),
        ElevatedButton(onPressed: onCalculate, child: Text(calculateLabel)),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: onClear,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.clearButton,
          ),
          child: const Text('ล้างข้อมูล'),
        ),
      ],
    );
  }
}

/// Green box that shows the result, e.g. BMI 0.00 การแปลผล.
class ResultBox extends StatelessWidget {
  const ResultBox({
    super.key,
    required this.title,
    required this.value,
    required this.caption,
  });

  final String title;
  final String value;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
      color: AppColors.resultBox,
      child: Column(
        children: [
          Text(
            title,
            style: GoogleFonts.kanit(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          Text(
            value,
            style: GoogleFonts.kanit(
              fontSize: 40,
              fontWeight: FontWeight.w600,
              color: AppColors.resultValue,
              height: 1.2,
            ),
          ),
          Text(
            caption,
            textAlign: TextAlign.center,
            style: GoogleFonts.kanit(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

/// Reads a positive number from a text field, or null if it is not valid.
double? parsePositive(TextEditingController controller) {
  final value = double.tryParse(controller.text.trim());
  return (value == null || value <= 0) ? null : value;
}

void showWarning(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message, style: GoogleFonts.kanit()),
        backgroundColor: AppColors.primary,
      ),
    );
}
