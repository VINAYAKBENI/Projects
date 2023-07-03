// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:wallpaper_app/Controller/apioper.dart';
import 'package:wallpaper_app/Models/photos_model.dart';
import 'package:wallpaper_app/Screens/Widget/category.dart';
import 'package:wallpaper_app/Screens/Widget/customappbar.dart';
import 'package:wallpaper_app/Screens/Widget/searchbar.dart';
import 'package:wallpaper_app/Screens/fullscreenpage.dart';

import '../Models/category_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PhotosModel> trendingWallList = [];
  List<CategoryModel> CatModList = [];
  bool isLoading = true;

  GetCatDetails() async {
    CatModList = ApiOperations.getCategoriesList();
    setState(() {
      CatModList = CatModList;
    });
  }

  GetTrendingWallpaper() async {
    trendingWallList = await ApiOperations.getTrendingWallpaper();

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    GetTrendingWallpaper();
    GetCatDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomAppBar(word1: 'Style', word2: ' Wall'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                 MySearchBar(),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: CatModList.length,
                      itemBuilder: ((context, index) => CategoryBlock(
                            categoryImgSrc: CatModList[index].catImgUrl,
                            categoryName: CatModList[index].catName,
                          )),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    height: MediaQuery.of(context).size.height-265,
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 400,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: trendingWallList.length,
                      itemBuilder: ((context, index) => GridTile(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FullScreen(
                                          imgUrl:
                                              trendingWallList[index].imgSrc)),
                                );
                              },
                              child: Hero(
                                tag: trendingWallList[index].imgSrc,
                                child: Container(
                                  height: 800,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      //color: Colors.amberAccent,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                        height: 800,
                                        width: 50,
                                        fit: BoxFit.cover,
                                        trendingWallList[index].imgSrc),
                                  ),
                                ),
                              ),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
