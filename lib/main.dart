import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';

import 'app_theme.dart';
import 'views/splash_screen_ui.dart';

void main() {
  // Kanit is bundled in assets/google_fonts, so no download is needed.
  GoogleFonts.config.allowRuntimeFetching = false;
  runApp(const BodyHealthApp());
}

class BodyHealthApp extends StatelessWidget {
  const BodyHealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Body ว้าว',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const SplashScreenUI(),
    );
  }
}
