import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

import '../Models/category_model.dart';
import '../Models/photos_model.dart';

class ApiOperations {
  static List<PhotosModel> trendingWallpapers = [];
  static List<PhotosModel> serachWallpapersList = [];
  static List<CategoryModel> cateogryModelList = [];

  static const String _apikey =
      'JBtv11nnbJieYq2sUM6RQYYpwPlhkiWMkw6jiJ4z1sdPi4l1aQl3G5bR';

  static Future<List<PhotosModel>> getTrendingWallpaper() async {
    await http.get(
      Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
      headers: {'Authorization': _apikey},
    ).then(
      (value) {
        Map<String, dynamic> jsonData = jsonDecode(value.body);
        List photos = jsonData['photos'];
        photos.shuffle();
        for (var element in photos) {
          trendingWallpapers.add(PhotosModel.fromApi2App(element));
        }
      },
    );
    return trendingWallpapers;
  }

  static Future<List<PhotosModel>> searchWallpapers(String query) async {
    await http.get(
      Uri.parse(
          'https://api.pexels.com/v1/search?query=$query&per_page=80&page=1'),
      headers: {'Authorization': _apikey},
    ).then(
      (value) {
        // print(value.body);
        Map<String, dynamic> jsonData = jsonDecode(value.body);
        List photos = jsonData['photos'];
        serachWallpapersList.clear();
        photos.shuffle();

        for (var element in photos) {
          serachWallpapersList.add(PhotosModel.fromApi2App(element));
        }
      },
    );
    return serachWallpapersList;
  }

  static List<CategoryModel> getCategoriesList() {
    List cateogryName = [
      "Cars",
      "Nature",
      "Bikes",
      "Street",
      "City",
      "Flowers"
    ];
    cateogryModelList.clear();
    // ignore: avoid_function_literals_in_foreach_calls
    cateogryName.forEach((catName) async {
      final random = Random();

      PhotosModel photoModel = (await searchWallpapers(catName)
          as dynamic)[0 + random.nextInt(50)];

      cateogryModelList
          .add(CategoryModel(catImgUrl: photoModel.imgSrc, catName: catName));
    });

    return cateogryModelList;
  }
}
