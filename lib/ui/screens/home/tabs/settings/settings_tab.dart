import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:newsapp/providers/settings_provider.dart';
import '../../../../../l10n/app_localizations.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    var localizations = AppLocalizations.of(context)!;
    
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(localizations.language, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          SizedBox(height: 12),
          InkWell(
            onTap: () {
              showLanguageBottomSheet(context);
            },
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(provider.currentLanguage == 'en' ? localizations.english : localizations.arabic),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),
          Text(localizations.theme, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          SizedBox(height: 12),
          InkWell(
            onTap: () {
              showThemeBottomSheet(context);
            },
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(provider.currentTheme == ThemeMode.light ? localizations.light : localizations.dark),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(context: context, builder: (context) {
      return LanguageBottomSheet();
    });
  }

  void showThemeBottomSheet(BuildContext context) {
    showModalBottomSheet(context: context, builder: (context) {
      return ThemeBottomSheet();
    });
  }
}

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    var localizations = AppLocalizations.of(context)!;
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              provider.changeLanguage('en');
              Navigator.pop(context);
            },
            child: getSelectedItemWidget(localizations.english, provider.currentLanguage == 'en')
          ),
          SizedBox(height: 12),
          InkWell(
            onTap: () {
               provider.changeLanguage('ar');
               Navigator.pop(context);
            },
            child: getSelectedItemWidget(localizations.arabic, provider.currentLanguage == 'ar')
          ),
        ],
      ),
    );
  }

  Widget getSelectedItemWidget(String text, bool isSelected) {
    if(isSelected){
       return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: TextStyle(fontSize: 18, color: Colors.blue, fontWeight: FontWeight.bold)),
          Icon(Icons.check, color: Colors.blue),
        ],
      );
    } else {
      return Text(text, style: TextStyle(fontSize: 18));
    }
  }
}

class ThemeBottomSheet extends StatelessWidget {
  const ThemeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    var localizations = AppLocalizations.of(context)!;
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              provider.changeTheme(ThemeMode.light);
              Navigator.pop(context);
            },
            child: getSelectedItemWidget(localizations.light, provider.currentTheme == ThemeMode.light)
          ),
          SizedBox(height: 12),
          InkWell(
            onTap: () {
               provider.changeTheme(ThemeMode.dark);
               Navigator.pop(context);
            },
            child: getSelectedItemWidget(localizations.dark, provider.currentTheme == ThemeMode.dark)
          ),
        ],
      ),
    );
  }

  Widget getSelectedItemWidget(String text, bool isSelected) {
    if(isSelected){
       return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: TextStyle(fontSize: 18, color: Colors.blue, fontWeight: FontWeight.bold)),
          Icon(Icons.check, color: Colors.blue),
        ],
      );
    } else {
      return Text(text, style: TextStyle(fontSize: 18));
    }
  }
}
