import 'package:flutter/material.dart';
import 'package:wallpaper_app/Screens/searchpage.dart';

// ignore: must_be_immutable
class MySearchBar extends StatelessWidget {
  MySearchBar({super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 25),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onEditingComplete: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SearchScreen(query: _searchController.text),
                  ),
                );
              },
              controller: _searchController,
              decoration: const InputDecoration(
                fillColor: Colors.black12,
                border: InputBorder.none,
                hintText: 'Search Wallpaper',
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SearchScreen(query: _searchController.text),
                ),
              );
            },
            child: const Icon(Icons.search),
          ),
        ],
      ),
    );
  }
}
