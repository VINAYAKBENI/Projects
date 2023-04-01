// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';

class FullScreen extends StatelessWidget {
  String imgUrl;
  FullScreen({super.key, required this.imgUrl});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> setWallpaperFromFile(
      String wallpaperUrl, BuildContext context) async {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Downloading Started...")));
    try {
      var response=await GallerySaver.saveImage(wallpaperUrl);
      if (response   == false) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Downloading Failed")));
        return ;
      }
      
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Downloaded Sucessfully")));
      //print("IMAGE DOWNLOADED");
    } on PlatformException catch (error) {
      //print(error);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error Occured - $error")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: ElevatedButton(
          onPressed: () async {
            await setWallpaperFromFile(imgUrl, context);
          },
          child: const Text('Download')),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imgUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
