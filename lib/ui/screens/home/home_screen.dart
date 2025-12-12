import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/data/api/api_manager.dart';
import 'package:newsapp/ui/screens/home/tabs/newsTab/News_Tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("News app")),
      body: NewsTab(),
    );
  }
}
