import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';

import '../app_theme.dart';
import 'about_ui.dart';
import 'bmi_ui.dart';
import 'bmr_ui.dart';

/// HomeUI - AppBar plus a bottom menu that switches BMI / About / BMR.
class HomeUI extends StatefulWidget {
  const HomeUI({super.key});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  // About (the middle item) is shown first.
  int _currentIndex = 1;

  static const _pages = <Widget>[BmiUI(), AboutUI(), BmrUI()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Body Health Calculator')),
      // IndexedStack keeps what was typed when switching between pages.
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey.shade700,
        selectedLabelStyle: GoogleFonts.kanit(fontSize: 12),
        unselectedLabelStyle: GoogleFonts.kanit(fontSize: 12),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'BMI'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'About'),
          BottomNavigationBarItem(
            icon: Icon(Icons.monitor_weight),
            label: 'BMR',
          ),
        ],
      ),
    );
  }
}
