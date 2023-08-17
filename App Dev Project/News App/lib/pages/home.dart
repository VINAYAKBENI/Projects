import 'package:flutter/material.dart';

import '../backend/functions.dart';
import '../components/appbar.dart';
import '../components/newsbox.dart';
import '../components/searchbar.dart';
import '../utils/colors.dart';
import '../utils/contansts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  Future<List> news = Future(() => []);
  List category = [
    'general',
    'science',
    'sports',
    'technology',
    'business',
    'entertainment',
    'health',
  ];
  List nodata = ['Check Your Connection'];
  List appbartitle = [
    'Daily ',
    'Scientific ',
    'Sports ',
    'Tech ',
    'Business ',
    'Fun ',
    'Health ',
  ];
  int index = 0;

  @override
  void initState() {
    super.initState();
    news = fetchnews(category[index]);
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.near_me),
        onPressed: () {
          setState(
            () {
              if (index == 6) {
                index = 0;
              } else {
                index++;
              }
            },
          );
        },
      ),
      backgroundColor: AppColors.black,
      appBar: appbar(
        title: appbartitle[index],
      ),
      body: news != Future(() => [])
          ? Column(
              children: [
                MySearchBar(
                  category: category[index],
                ),
                Expanded(
                  child: SizedBox(
                    width: w,
                    child: FutureBuilder<List>(
                      initialData: [nodata],
                      future: fetchnews(category[index]),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return NewsBox(
                                url: snapshot.data![index]['url'],
                                imageurl: snapshot.data![index]['urlToImage'] ??
                                    Constants.imageurl,
                                title: snapshot.data![index]['title'],
                                time: snapshot.data![index]['publishedAt'],
                                description: snapshot.data![index]
                                        ['description']
                                    .toString(),
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }

                        // By default, show a loading spinner.
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            )
          : Text('a'),
    );
  }
}
