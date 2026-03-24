import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'l10n/app_localizations.dart';
import 'services/language_service.dart';
import 'splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String savedLanguage = await LanguageService.getSavedLanguage();
  runApp(MyApp(savedLanguage: savedLanguage));
}

class MyApp extends StatefulWidget {
  final String savedLanguage;

  const MyApp({super.key, required this.savedLanguage});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale _locale;

  @override
  void initState() {
    super.initState();
    _locale = LanguageService.getLocale(widget.savedLanguage);

    // Слушаем изменения языка
    LanguageService.addListener(_onLanguageChanged);
  }

  void _onLanguageChanged(String languageCode) {
    setState(() {
      _locale = LanguageService.getLocale(languageCode);
    });
  }

  @override
  void dispose() {
    LanguageService.removeListener(_onLanguageChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TSU Maps',
      theme: ThemeData(
        primaryColor: Colors.black,
        fontFamily: 'Ubuntu',
        scaffoldBackgroundColor: Colors.black,
        useMaterial3: true,
      ),
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ru'), Locale('en'), Locale('kk')],
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
