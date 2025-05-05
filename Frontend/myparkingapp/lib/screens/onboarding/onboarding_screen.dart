import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import '../../constants.dart';
import '../../components/dot_indicators.dart';
import '../auth/sign_in_screen.dart';
import 'components/onboard_content.dart';

class OnboardingScreen extends StatefulWidget {
  final Function(Locale) changeLanguage;
  const OnboardingScreen({super.key, required this.changeLanguage});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPage = 0;

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).translate("Choose Language")),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text("English"),
              onTap: () {
                Get.updateLocale(const Locale('en')); // hoặc Locale('en')
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("Tiếng Việt"),
              onTap: () {
                Get.updateLocale(const Locale('vi')); // hoặc Locale('vi')
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),
            Expanded(
              flex: 14,
              child: PageView.builder(
                itemCount: demoData.length,
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemBuilder: (context, index) => OnboardContent(
                  illustration: demoData[index]["illustration"],
                  title: demoData[index]["title"],
                  text: demoData[index]["text"],
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                demoData.length,
                    (index) => DotIndicator(isActive: index == currentPage),
              ),
            ),
            const Spacer(flex: 2),
            Container(
              width: Get.width/2,
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInScreen(),
                    ),
                  );
                },
                child: Text(AppLocalizations.of(context).translate("Get Started").toUpperCase()),
              ),
            ),
            const Spacer(flex: 1),
            Container(
              width: Get.width/1.5,
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: ElevatedButton(
                onPressed: _showLanguageDialog,
                child: Text(AppLocalizations.of(context).translate("Choose Language").toUpperCase()),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
// Demo data for our Onboarding screen
List<Map<String, dynamic>> demoData = [
  {
    "illustration": "assets/Illustrations/Illustrations_1.svg",
    "title": "Time is gold",
    "text": "Don’t waste time circling for a spot. Let technology guide you to the right place, at the right time."
  },
  {
    "illustration": "assets/Illustrations/Illustrations_2.svg",
    "title": "Convenience makes a difference",
    "text": "A smart choice saves you effort. Book in advance, park easily, and enjoy your day."
  },
  {
    "illustration": "assets/Illustrations/Illustrations_3.svg",
    "title": "Stay in control",
    "text": "Own your journey—don’t let parking slow you down. One tap, and everything is within reach."
  }
];
