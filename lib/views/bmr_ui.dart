import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';

import '../app_theme.dart';
import '../utils/health_calculator.dart';
import '../widgets/form_widgets.dart';

/// BmrUI - Basal Metabolic Rate calculator.
class BmrUI extends StatefulWidget {
  const BmrUI({super.key});

  @override
  State<BmrUI> createState() => _BmrUIState();
}

class _BmrUIState extends State<BmrUI> {
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _ageController = TextEditingController();

  Gender _gender = Gender.male;
  double _bmr = 0;

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _calculate() {
    final weight = parsePositive(_weightController);
    final height = parsePositive(_heightController);
    final age = int.tryParse(_ageController.text.trim());
    if (weight == null || height == null || age == null || age <= 0) {
      showWarning(context, 'กรุณากรอกน้ำหนัก ส่วนสูง และอายุให้ถูกต้อง');
      return;
    }
    FocusScope.of(context).unfocus();
    setState(() {
      _bmr = calculateBmr(
        gender: _gender,
        weightKg: weight,
        heightCm: height,
        age: age,
      );
    });
  }

  void _clear() {
    _weightController.clear();
    _heightController.clear();
    _ageController.clear();
    FocusScope.of(context).unfocus();
    setState(() {
      _gender = Gender.male;
      _bmr = 0;
    });
  }

  Widget _genderButton(Gender gender, String label) {
    final selected = _gender == gender;
    return Expanded(
      child: ElevatedButton(
        onPressed: () => setState(() => _gender = gender),
        style: ElevatedButton.styleFrom(
          backgroundColor:
              selected ? AppColors.genderSelected : AppColors.white,
          foregroundColor: AppColors.textDark,
          elevation: selected ? 2 : 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(label),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'คำนวณหาอัตราการเผาผลาญที่\nร่างกายต้องการ (BMR)',
            textAlign: TextAlign.center,
            style: GoogleFonts.kanit(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          const Center(
            child: AssetImageOrIcon(
              asset: AppImages.bmr,
              fallbackIcon: Icons.monitor_heart_rounded,
              size: 120,
            ),
          ),
          const FieldLabel('เพศ'),
          Row(
            children: [
              _genderButton(Gender.male, 'ชาย'),
              const SizedBox(width: 12),
              _genderButton(Gender.female, 'หญิง'),
            ],
          ),
          const FieldLabel('น้ำหนัก (kg.)'),
          NumberField(controller: _weightController, hint: 'กรอกน้ำหนักของคุณ'),
          const FieldLabel('ส่วนสูง (cm.)'),
          NumberField(controller: _heightController, hint: 'กรอกส่วนสูงของคุณ'),
          const FieldLabel('อายุ (ปี)'),
          NumberField(
            controller: _ageController,
            hint: 'กรอกอายุของคุณ',
            decimal: false,
          ),
          CalculateButtons(
            calculateLabel: 'คำนวณ BMR',
            onCalculate: _calculate,
            onClear: _clear,
          ),
          ResultBox(
            title: 'BMR',
            value: _bmr.toStringAsFixed(2),
            caption: 'kcal/day',
          ),
        ],
      ),
    );
  }
}
