import 'package:flutter/material.dart';

import '../design/app_colors.dart';
import '../design/app_images.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
      height: 40,
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                  fillColor: AppColors.searchBarColor,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none),
                  hintText: 'Search',
                  hintStyle: const TextStyle(
                    color: AppColors.searchBarHintTextClr,
                    fontSize: 15,
                    height: 3,
                  ),
                  prefixIcon: Container(
                    padding: const EdgeInsets.all(12),
                    child: const Image(image: AppImages.searchIcon),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
