import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';

import '../app_theme.dart';
import '../utils/health_calculator.dart';
import '../widgets/form_widgets.dart';

/// BmiUI - Body Mass Index calculator.
class BmiUI extends StatefulWidget {
  const BmiUI({super.key});

  @override
  State<BmiUI> createState() => _BmiUIState();
}

class _BmiUIState extends State<BmiUI> {
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();

  double _bmi = 0;
  String _result = 'การแปลผล';

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _calculate() {
    final weight = parsePositive(_weightController);
    final height = parsePositive(_heightController);
    if (weight == null || height == null) {
      showWarning(context, 'กรุณากรอกน้ำหนักและส่วนสูงให้ถูกต้อง');
      return;
    }
    FocusScope.of(context).unfocus();
    final bmi = calculateBmi(weightKg: weight, heightCm: height);
    setState(() {
      _bmi = bmi;
      _result = interpretBmi(bmi);
    });
  }

  void _clear() {
    _weightController.clear();
    _heightController.clear();
    FocusScope.of(context).unfocus();
    setState(() {
      _bmi = 0;
      _result = 'การแปลผล';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'คำนวณหาค่าดัชนีมวลกาย (BMI)',
            textAlign: TextAlign.center,
            style: GoogleFonts.kanit(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          const Center(
            child: AssetImageOrIcon(
              asset: AppImages.bmi,
              fallbackIcon: Icons.speed_rounded,
              size: 120,
            ),
          ),
          const SizedBox(height: 8),
          const FieldLabel('น้ำหนัก (kg.)'),
          NumberField(controller: _weightController, hint: 'กรอกน้ำหนักของคุณ'),
          const FieldLabel('ส่วนสูง (cm.)'),
          NumberField(controller: _heightController, hint: 'กรอกส่วนสูงของคุณ'),
          CalculateButtons(
            calculateLabel: 'คำนวณ BMI',
            onCalculate: _calculate,
            onClear: _clear,
          ),
          ResultBox(
            title: 'BMI',
            value: _bmi.toStringAsFixed(2),
            caption: _result,
          ),
        ],
      ),
    );
  }
}
