/// BMI and BMR formulas used by BmiUI and BmrUI.
library;

enum Gender { male, female }

/// BMI = weight (kg) ÷ (height (m) × height (m))
double calculateBmi({required double weightKg, required double heightCm}) {
  final heightM = heightCm / 100;
  return weightKg / (heightM * heightM);
}

/// Thai interpretation of a BMI value (Asian cut-offs).
String interpretBmi(double bmi) {
  if (bmi < 18.5) return 'น้ำหนักต่ำกว่าเกณฑ์';
  if (bmi < 23.0) return 'น้ำหนักสมส่วน';
  if (bmi < 25.0) return 'น้ำหนักเกิน';
  if (bmi < 30.0) return 'โรคอ้วนระดับ 1';
  return 'โรคอ้วนระดับ 2 หรืออ้วนมาก';
}

/// Harris-Benedict BMR in kcal/day.
/// Male:   88.362 + (13.397 × kg) + (4.799 × cm) - (5.677 × age)
/// Female: 447.593 + (9.247 × kg) + (3.098 × cm) - (4.330 × age)
double calculateBmr({
  required Gender gender,
  required double weightKg,
  required double heightCm,
  required int age,
}) {
  switch (gender) {
    case Gender.male:
      return 88.362 + (13.397 * weightKg) + (4.799 * heightCm) - (5.677 * age);
    case Gender.female:
      return 447.593 + (9.247 * weightKg) + (3.098 * heightCm) - (4.330 * age);
  }
}
