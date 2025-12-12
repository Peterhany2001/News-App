import 'package:flutter/material.dart';
import 'package:newsapp/data/models/SourcesResponse.dart';

import '../../../../../data/api/api_manager.dart';

class NewsTab extends StatefulWidget {
  const NewsTab({super.key});

  @override
  State<NewsTab> createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> {
  int currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManager.getSources(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //for run
          return buildTabs(snapshot.data!);
        } else if (snapshot.hasError) {
          //for error
          return Text(snapshot.error.toString());
        } else {
          //for reloading
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget buildTabs(List<Source> list) {
    return DefaultTabController(
      length: list.length,
      child: Column(
        children: [
          SizedBox(height: 8),
          TabBar(
            isScrollable: true,
            indicatorColor: Colors.transparent,
            tabs: list
                .map(
                  (source) => buildTabWidget(
                    source.name ?? "",
                    currentTabIndex == list.indexOf(source),
                  ),
                )
                .toList(),
            onTap: (index) {
              currentTabIndex = index;
              setState(() {});
            },
          ),
          Expanded(
            child: TabBarView(
              children: list
                  .map((source) => Container(color: Colors.red))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildTabWidget(String name, bool isSelected) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: isSelected ? Colors.blue : Colors.white,
      borderRadius: BorderRadius.circular(22),
      border: Border.all(color: Colors.blue),
    ),
    child: Text(
      name,
      style: TextStyle(color: isSelected ? Colors.white : Colors.blue),
    ),
  );
}
