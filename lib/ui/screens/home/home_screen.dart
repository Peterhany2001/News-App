import 'package:flutter/material.dart';
import 'package:newsapp/ui/screens/home/tabs/newsTab/News_Tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  static String routeName = "Home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
      ),
      body: NewsTab(),
    );
  }
}
