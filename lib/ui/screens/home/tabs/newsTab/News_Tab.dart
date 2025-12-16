import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/data/models/SourcesResponse.dart';
import '../../../../../data/api/api_manager.dart';
import '../../../../../data/models/articles_response_dm.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsTab extends StatefulWidget {
  final String categoryId;
  const NewsTab({super.key, required this.categoryId});

  @override
  State<NewsTab> createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> {
  int currentTabIndex = 0;
  late Future<SourcesResponseDM> sourcesFuture;

  @override
  void initState() {
    super.initState();
    sourcesFuture = ApiManager.getSources(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: sourcesFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.sources == null || snapshot.data!.sources!.isEmpty) {
            return Center(child: Text("No sources found for this category"));
          }
          return getScreenBody(snapshot.data!.sources!);
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget getScreenBody(List<SourceDM> sources) {
    return DefaultTabController(
      length: sources.length,
      child: Builder( // Added Builder to access DefaultTabController
        builder: (context) {
           final TabController? tabController = DefaultTabController.of(context);
           tabController?.addListener(() {
             if (!tabController.indexIsChanging) { // Wait for the swipe to finish
                setState(() {
                  currentTabIndex = tabController.index;
                });
             }
           });

          return Column(
            children: [
              SizedBox(height: 8),
              TabBar(
                isScrollable: true,
                indicatorColor: Colors.transparent,
                onTap: (index) {
                   // This is still needed for tap-to-change
                   // But the TabController listener handles the swipe
                },
                tabs: sources.map((source) {
                  return getTab(
                    source.name ?? " ",
                    currentTabIndex == sources.indexOf(source),
                  );
                }).toList(),
              ),
              Expanded(
                child: TabBarView(
                  children: sources.map((source) {
                    return NewsListWidget(source: source);
                  }).toList(),
                ),
              ),
            ],
          );
        }
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
}

class NewsListWidget extends StatefulWidget {
  final SourceDM source;
  const NewsListWidget({super.key, required this.source});

  @override
  State<NewsListWidget> createState() => _NewsListWidgetState();
}

class _NewsListWidgetState extends State<NewsListWidget> {
  late Future<ArticlesResponseDm> articlesFuture;

  @override
  void initState() {
    super.initState();
    articlesFuture = ApiManager.getArticles(widget.source.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Text(
               widget.source.description ?? "No Description",
               style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
           ),
         ),
        Expanded(
          child: FutureBuilder<ArticlesResponseDm>(
            future: articlesFuture,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else if (snapshot.hasData) {
                 if (snapshot.data!.articles == null || snapshot.data!.articles!.isEmpty) {
                   return Center(child: Text("No articles found"));
                 }
                return ListView.builder(
                  itemCount: snapshot.data!.articles?.length ?? 0,
                  itemBuilder: (context, index) {
                    return buildNewsWidget(context, snapshot.data!.articles![index]);
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ],
    );
  }

  Widget buildNewsWidget(BuildContext context, ArticleDM article) {
    return InkWell(
      onTap: (){
        showModalBottomSheet(context: context, builder: (context) {
          return Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: article.urlToImage ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2jVPjtjhe47WwTy5QUdpprHquI-qCzJOZyQ&s",
                    fit: BoxFit.fill,
                    height: MediaQuery.of(context).size.height * 0.2,
                    placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                    article.content ?? "No content",
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 16),
                ElevatedButton(onPressed: () async {
                  // Open full article logic
                  final Uri url = Uri.parse(article.url!);
                  if (!await launchUrl(url)) {
                  throw Exception('Could not launch $url');
                  }
                }, child: Text("View Full Article"))
              ],
            ),
          );
        },);
      },
      child: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: article.urlToImage ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2jVPjtjhe47WwTy5QUdpprHquI-qCzJOZyQ&s",
                fit: BoxFit.fill,
                height: MediaQuery.of(context).size.height * 0.2,
                placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
                memCacheWidth: 800, // Optimize memory
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
      ),
    );
  }
}
