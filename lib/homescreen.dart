import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:letmegrab/detailscreen.dart';
import 'package:letmegrab/models.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isloading = true;
  String? searchQuery;
  Dio dio = Dio();

  Future<NewsItem?> fetchdata() async {
    Response response =
        await dio.get('https://inshorts.deta.dev/news?category=all');
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;

      return NewsItem.fromJson(data);
    }
  }

  Future<NewsItem?> searchCategory() async {
    Response response =
        await dio.get('https://inshorts.deta.dev/news?category=$searchQuery');

    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;

      return NewsItem.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
      displacement: 250,
      backgroundColor: Colors.yellow,
      color: Colors.red,
      strokeWidth: 3,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      onRefresh: () async {
        await Future.delayed(Duration(milliseconds: 1500));

        setState(() {
          fetchdata();
        });
      },
      child: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 6, right: 6),
              child: TextField(
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          searchCategory();
                        });
                      },
                      icon: const Icon(Icons.search)),
                  labelText: 'category',
                  prefixIcon: const Icon(Icons.search),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                ),
                onChanged: (value) {
                  searchQuery = value;
                },
              ),
            ),
            FutureBuilder(
              future: searchQuery == null ? fetchdata() : searchCategory(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.separated(
                      itemCount: snapshot.data?.data.length ?? 0,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                    news: snapshot.data?.data[index])));
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                CachedNetworkImage(
                                  imageUrl:
                                      snapshot.data?.data[index].imageUrl ?? "",
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) => Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey,
                                    ),
                                    child: const Center(
                                        child: CircularProgressIndicator()),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey,
                                    ),
                                    child: const Icon(Icons.error),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data?.data[index].title ?? "",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        snapshot.data?.data[index].content ??
                                            "",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider();
                      },
                    ),
                  );
                } else {
                  return const Center(
                      child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.pinkAccent,
                  ));
                }
              },
            ),
          ],
        ),
      ),
    ));
  }
}
