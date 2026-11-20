# flutter_body_health_calculator_project

แอพ **Body ว้าว** — Body Health Calculator คำนวณ BMI และ BMR (ฟอนต์ Kanit)

| ไฟล์ | Class | หน้าที่ |
|---|---|---|
| `lib/views/splash_screen_ui.dart` | `SplashScreenUI` (stf) | หน้าแรก แสดง 3 วินาทีแล้วไป HomeUI |
| `lib/views/home_ui.dart` | `HomeUI` (stf) | AppBar + BottomNavigationBar (BMI / About / BMR) เริ่มที่ About |
| `lib/views/bmi_ui.dart` | `BmiUI` (stf) | คำนวณ BMI และแปลผล |
| `lib/views/bmr_ui.dart` | `BmrUI` (stf) | คำนวณ BMR (kcal/day) แยกชาย/หญิง |
| `lib/views/about_ui.dart` | `AboutUI` (stl) | ข้อมูลแอพ |

สูตรอยู่ใน `lib/utils/health_calculator.dart`

- BMI = น้ำหนัก (kg) ÷ (ส่วนสูง (m) × ส่วนสูง (m))
  - < 18.5 น้ำหนักต่ำกว่าเกณฑ์ · 18.5–22.9 สมส่วน · 23.0–24.9 น้ำหนักเกิน · 25.0–29.9 โรคอ้วนระดับ 1 · ≥ 30 โรคอ้วนระดับ 2
- BMR ชาย = 88.362 + (13.397 × kg) + (4.799 × cm) − (5.677 × อายุ)
- BMR หญิง = 447.593 + (9.247 × kg) + (3.098 × cm) − (4.330 × อายุ)

## รูปที่ต้องใส่

วางไฟล์ใน `assets/images/` (ถ้ายังไม่มี จะแสดงไอคอนแทน):

| ไฟล์ | ใช้ที่ |
|---|---|
| `calculator.png` | Splash, About, ไอคอนแอพ (`dart run flutter_launcher_icons`) |
| `bmi.png` | หน้าปัด BMI |
| `bmr.png` | หัวใจกับดัมเบล |
| `sau_logo.png` | โลโก้ SAU ด้านล่างหน้า About |

## รัน / ทดสอบ

```bash
flutter pub get
flutter run -d chrome
flutter test    # ทดสอบสูตร + ทุกหน้าที่ขนาด iPhone 15 Pro Max (430 × 932)
```

ฟอนต์ Kanit (SIL Open Font License, `assets/google_fonts/OFL.txt`) ฝังไว้ในโปรเจกต์ จึงไม่ต้องโหลดจากเน็ตตอนรัน
