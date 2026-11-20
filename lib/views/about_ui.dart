import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';

import '../app_theme.dart';
import '../widgets/form_widgets.dart';

/// AboutUI - app information (shown first inside HomeUI).
class AboutUI extends StatelessWidget {
  const AboutUI({super.key});

  @override
  Widget build(BuildContext context) {
    final red = GoogleFonts.kanit(
      color: AppColors.primary,
      fontWeight: FontWeight.w500,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Body Health Calculator',
                      textAlign: TextAlign.center,
                      style: red.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const AssetImageOrIcon(
                      asset: AppImages.calculator,
                      fallbackIcon: Icons.calculate_rounded,
                      size: 110,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'คำนวณหาค่าดัชนีมวลกาย (BMI)\n'
                      'คำนวณหาแคลอรี่ที่ร่างกายต้องการ (BMR)',
                      textAlign: TextAlign.center,
                      style: red.copyWith(fontSize: 15, height: 1.6),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const AssetImageOrIcon(
            asset: AppImages.sauLogo,
            fallbackIcon: Icons.school_rounded,
            fallbackColor: Colors.grey,
            size: 48,
          ),
          const SizedBox(height: 8),
          Text(
            '© 2026 SAU. All rights reserved.\n'
            'Created by SAU Software Development Team',
            textAlign: TextAlign.center,
            style: GoogleFonts.kanit(
              fontSize: 12,
              height: 1.5,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
