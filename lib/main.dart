import 'package:flutter/material.dart';
import 'package:newsapp/providers/settings_provider.dart';
import 'package:newsapp/ui/screens/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(
      ChangeNotifierProvider(
          create: (context) => SettingsProvider(),
          child: const MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('ar'), // Arabic
      ],
      locale: Locale(provider.currentLanguage),
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: provider.currentTheme,
      routes: {
        HomeScreen.routeName: (_)=> HomeScreen()
      },
      initialRoute: HomeScreen.routeName,
    );
  }
}
