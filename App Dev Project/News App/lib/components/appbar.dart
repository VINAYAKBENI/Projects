import 'package:flutter/material.dart';
import 'package:news_app/utils/colors.dart';
import 'package:news_app/utils/text.dart';

// ignore: must_be_immutable, camel_case_types
class appbar extends StatelessWidget implements PreferredSizeWidget {
  String title;

  appbar({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.black,
      elevation: 0,
      title: SizedBox(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              boldText(text: title, color: AppColors.primary, size: 20),
              modifiedText(text: 'News', color: AppColors.lightwhite, size: 20),
            ],
          )),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}
