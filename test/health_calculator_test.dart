import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_body_health_calculator_project/utils/health_calculator.dart';

void main() {
  group('calculateBmi', () {
    test('70 kg, 175 cm', () {
      expect(calculateBmi(weightKg: 70, heightCm: 175), closeTo(22.857, 0.001));
    });
  });

  group('interpretBmi uses the given ranges', () {
    const cases = <(double, String)>[
      (18.4, 'น้ำหนักต่ำกว่าเกณฑ์'),
      (18.5, 'น้ำหนักสมส่วน'),
      (22.9, 'น้ำหนักสมส่วน'),
      (23.0, 'น้ำหนักเกิน'),
      (24.9, 'น้ำหนักเกิน'),
      (25.0, 'โรคอ้วนระดับ 1'),
      (29.9, 'โรคอ้วนระดับ 1'),
      (30.0, 'โรคอ้วนระดับ 2 หรืออ้วนมาก'),
    ];
    for (final (bmi, expected) in cases) {
      test('$bmi → $expected', () => expect(interpretBmi(bmi), expected));
    }
  });

  group('calculateBmr', () {
    test('male 70 kg, 175 cm, 25 years', () {
      // 88.362 + 13.397*70 + 4.799*175 - 5.677*25
      expect(
        calculateBmr(gender: Gender.male, weightKg: 70, heightCm: 175, age: 25),
        closeTo(1724.052, 0.001),
      );
    });

    test('female 60 kg, 165 cm, 30 years', () {
      // 447.593 + 9.247*60 + 3.098*165 - 4.330*30
      expect(
        calculateBmr(
          gender: Gender.female,
          weightKg: 60,
          heightCm: 165,
          age: 30,
        ),
        closeTo(1383.683, 0.001),
      );
    });
  });
}
