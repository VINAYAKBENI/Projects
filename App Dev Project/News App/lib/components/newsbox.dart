import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/components/bottomsheet.dart';
import 'package:news_app/components/components.dart';

import '../utils/colors.dart';
import '../utils/text.dart';

class NewsBox extends StatefulWidget {
  final String imageurl, title, time, description, url;
  const NewsBox({
    super.key,
    required this.description,
    required this.imageurl,
    required this.time,
    required this.title,
    required this.url,
  });

  @override
  State<NewsBox> createState() => _NewsBoxState();
}

class _NewsBoxState extends State<NewsBox> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        InkWell(
          onTap: () {
            showMyBottomSheet(context, widget.title, widget.description, widget.imageurl, widget.url);
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
            width: w,
            color: AppColors.black,
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: widget.imageurl,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.yellow),
                  ),
                  placeholder: (context, url) =>
                      CircularProgressIndicator(color: AppColors.primary),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      modifiedText(
                          color: AppColors.white, size: 16, text: widget.title),
                      const SizedBox(height: 5),
                      modifiedText(
                          color: AppColors.lightwhite, size: 12, text: widget.time),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const DividerWidget()
      ],
    );
  }
}
