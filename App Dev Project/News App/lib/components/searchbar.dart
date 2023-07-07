import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/utils/colors.dart';

// ignore: must_be_immutable
class MySearchBar extends StatefulWidget {
  String category;
  MySearchBar({super.key,required this.category});
  static TextEditingController searchcontroller =
      TextEditingController(text: '');

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
                color: AppColors.darkgrey,
                borderRadius: BorderRadius.circular(50)),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Expanded(
                    child: TextField(
                  controller: MySearchBar.searchcontroller,
                  decoration: InputDecoration(
                    hintText: 'Search a Keyword or Phrase',
                    hintStyle: GoogleFonts.lato(),
                    border: InputBorder.none,
                  ),
                ))
              ],
            )),
          ),
        ),
        InkWell(
          onTap: () {
            FocusScope.of(context).unfocus();
            //fetchnews();
          },
          child: Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: AppColors.darkgrey,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.search,
              color: AppColors.white,
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
