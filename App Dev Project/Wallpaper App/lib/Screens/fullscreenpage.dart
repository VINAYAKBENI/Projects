// ignore_for_file: use_build_context_synchronously, must_be_immutable, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:gallery_saver/gallery_saver.dart';

class FullScreen extends StatefulWidget {
  String imgUrl;
  FullScreen({super.key, required this.imgUrl});

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> setWallpaper(String wallSreeen) async {
    try {
      int location;
      if (wallSreeen == 'Home') {
        location = WallpaperManager.HOME_SCREEN;
      } else if (wallSreeen == 'Lock') {
        location = WallpaperManager.LOCK_SCREEN;
      } else {
        location = WallpaperManager.BOTH_SCREEN;
      }
      var file = await DefaultCacheManager().getSingleFile(widget.imgUrl);
      // ignore: unused_local_variable
      bool result =
          await WallpaperManager.setWallpaperFromFile(file.path, location);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Wallpaper Set Succesfully")));
    } on PlatformException catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error Occured - $error")));
    }
  }

  Future<dynamic> bottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                  child: const Text(
                    'Home Screen',
                    style: TextStyle(fontSize: 17),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    setWallpaper('Home');
                  }),
              InkWell(
                  child: const Text(
                    'Lock Screen',
                    style: TextStyle(fontSize: 17),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    setWallpaper('Lock');
                  }),
              InkWell(
                  child: const Text(
                    'Home And Lock Screen',
                    style: TextStyle(fontSize: 17),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    setWallpaper('Both');
                  }),
            ],
          ),
        );
      },
    );
  }

  Future<void> saveWallpaper(String wallpaperUrl, BuildContext context) async {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Downloading Started...")));
    try {
      var response = await GallerySaver.saveImage(wallpaperUrl);
      if (response == false) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Downloading Failed")));
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Downloaded Sucessfully")));
    } on PlatformException catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error Occured - $error")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
              onPressed: () async {
                await saveWallpaper(widget.imgUrl, context);
              },
              child: const Text('Download Image')),
          //SizedBox(width: 20),
          ElevatedButton(
              onPressed: () async {
                bottomSheet(context);
              },
              child: const Text('Set as Wallpaper'))
        ],
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(widget.imgUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
