import 'package:esprit_alumni_frontend/view/components/design/app_colors.dart';
import 'package:esprit_alumni_frontend/view/components/design/app_images.dart';
import 'package:flutter/material.dart';

class SearchBar1 extends StatelessWidget {
  const SearchBar1({Key? key, this.searchText = '', required this.onSearch})
      : super(key: key);

  final String searchText;
  final Function(String) onSearch;

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
              controller: TextEditingController(text: searchText),
              onChanged: onSearch,
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
