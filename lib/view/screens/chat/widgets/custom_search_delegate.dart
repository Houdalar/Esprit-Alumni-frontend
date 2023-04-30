import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  CustomSearchDelegate({required this.onResult, required this.onSuggest});

  final Widget Function(BuildContext context, String query) onResult, onSuggest;
  @override
  String get searchFieldLabel => "Search";
  @override
  TextStyle get searchFieldStyle =>
      GoogleFonts.sourceSansPro(fontWeight: FontWeight.w300, fontSize: 16);

  @override
  ThemeData appBarTheme(BuildContext context) {
    var superThemeData = super.appBarTheme(context);
    return superThemeData.copyWith(
      textTheme: superThemeData.textTheme.copyWith(
        titleLarge: searchFieldStyle,
      ),
    );
  }

  @override
  List<Widget>? buildActions(Object context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
          query = '';
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    log(query);

    return onResult(context, query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return onSuggest(context, query);
  }
}
