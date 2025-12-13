import 'package:flutter/material.dart';
import 'package:newsapp/data/models/SourcesResponse.dart';
import '../../../../../data/api/api_manager.dart';
import '../../../../../data/models/articles_response_dm.dart';

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
          return getScreenBody(snapshot.data!.sources!);
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

  Widget getScreenBody(List<SourceDM> sources) {
    return DefaultTabController(
      length: sources.length,
      child: Column(
        children: [
          SizedBox(height: 8),
          TabBar(
            isScrollable: true,
            indicatorColor: Colors.transparent,
            tabs: sources.map((source) {
              return getTab(
                source.name ?? " ",
                currentTabIndex == sources.indexOf(source),
              );
            }).toList(),
            onTap: (index) {
              currentTabIndex = index;
              setState(() {});
            },
          ),
          Expanded(
            child: TabBarView(
              children: sources.map((source) {
                return getTabContent(source);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget getTab(String name, bool isSelected) {
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

  Widget getTabContent(SourceDM sourceDM) {
    return FutureBuilder<ArticlesResponseDm>(
      future: ApiManager.getArticles(sourceDM.id!),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.articles?.length ?? 0,
            itemBuilder: (context, index) {
              return ListView.builder(
                itemCount: snapshot.data!.articles?.length ?? 0,
                itemBuilder: (_, index) {
                  return buildNewsWidget(snapshot.data!.articles![index]);
                },
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget buildNewsWidget(ArticleDM article) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              article.urlToImage ??
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2jVPjtjhe47WwTy5QUdpprHquI-qCzJOZyQ&s",
            ),
          ),
          SizedBox(height: 8),
          Text(
            article.author ?? "",
            textAlign: TextAlign.start,
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          SizedBox(height: 5),
          Text(
            article.title ?? "",
            textAlign: TextAlign.start,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(height: 5),
          Text(
            article.publishedAt ?? "",
            textAlign: TextAlign.end,
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
