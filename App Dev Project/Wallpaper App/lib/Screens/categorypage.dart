// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:wallpaper_app/Screens/Widget/customappbar.dart';

import '../Controller/apioper.dart';
import '../Models/photos_model.dart';
import 'fullscreenpage.dart';

class CategoryScreen extends StatefulWidget {
  String catName;
  String catImgUrl;

   CategoryScreen({super.key,required this.catImgUrl,required this.catName});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

    List<PhotosModel> categoryResults=[];
    bool isLoading=true;

    GetCatRelWall() async {
    categoryResults = await ApiOperations.searchWallpapers(widget.catName);

    setState(() {
     isLoading=false;
    });
  }

  
  @override
  void initState() {
    GetCatRelWall();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomAppBar(word1: 'Style', word2: ' Wall'),
      ),
      body:  isLoading  ? const Center(child: CircularProgressIndicator(),)  : SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  widget.catImgUrl,
                ),
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black38,
                ),
                Positioned(
                    left: 140,
                    top: 45,
                    child: Column(
                      children: [
                        const Text(
                          'Category',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          widget.catName,
                          style: const TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              height:MediaQuery.of(context).size.height-270,
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 400,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 10,
                ),
                itemCount: categoryResults.length,
                itemBuilder: ((context, index) => GridTile(
                  child: InkWell(
                    onTap: (){
                       Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FullScreen(
                                    imgUrl: categoryResults[index].imgSrc)),
                          );
                    },
                    child: Hero(
                      tag: categoryResults[index].imgSrc,
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
                                  categoryResults[index].imgSrc),
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
