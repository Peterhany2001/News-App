import 'package:flutter/material.dart';
import 'package:newsapp/ui/screens/home/tabs/catigorise/Categories.dart';
import 'package:newsapp/ui/screens/home/tabs/newsTab/News_Tab.dart';
import 'package:newsapp/ui/screens/home/tabs/settings/settings_tab.dart';
import '../../../../l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  static String routeName = "Home";
  late Widget selectedWidget;

  @override
  void initState() {
    super.initState();
    selectedWidget = CategoriesTab(onCategoryClick: onCategoryClick);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings == "Settings" || AppLocalizations.of(context)!.settings == "الإعدادات" ? "News App" : "News App"),
        centerTitle: true,
        leading: selectedWidget is NewsTab 
            ? IconButton(
                onPressed: () {
                  selectedWidget = CategoriesTab(onCategoryClick: onCategoryClick);
                  setState(() {});
                },
                icon: Icon(Icons.arrow_back),
              )
            : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
      ),
      body: selectedWidget,
      drawer: buildDrawerWidget(),
    );
  }

  void onCategoryClick(CategoryDM category) {
    selectedWidget = NewsTab(categoryId: category.id);
    setState(() {});
  }
  
  void onDrawerItemClick(int id){
    Navigator.pop(context);
    if(id == 1){
      selectedWidget = CategoriesTab(onCategoryClick: onCategoryClick);
    }else if(id == 2){
       selectedWidget = SettingsTab();
    }
    setState(() {});
  }

  Widget buildDrawerWidget() {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width * 0.75,
      child: Column(
        children: [
          Container(
            color: Colors.blue,
            height: MediaQuery.of(context).size.height * 0.15,
            child: Center(
              child: Text(
                "News App!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height:12 ,),
          InkWell(
            onTap: (){
              onDrawerItemClick(1);
            },
            child: buildDrawerRow(Icons.menu, AppLocalizations.of(context)!.settings == "Settings" ? "Categories" : "الفئات")
          ),
          SizedBox(height:12 ,),
          InkWell(
            onTap: (){
              onDrawerItemClick(2);
            },
            child: buildDrawerRow(Icons.settings, AppLocalizations.of(context)!.settings)
          ),
        ],
      ),
    );
  }

  Widget buildDrawerRow(IconData icon, String text) {
    return Row(
      children: [
        SizedBox(width:8 ,),
        Icon(icon, size: 28, color: Colors.black),
        SizedBox(width:8 ,),
        Text(
          text,
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
