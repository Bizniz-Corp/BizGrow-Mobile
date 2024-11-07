import 'package:searchfield/searchfield.dart';
import 'package:flutter/material.dart';
import 'package:bizgrow_mobile_frontend/themes/colors.dart';

class DropDownSearchProduct extends StatefulWidget {
  const DropDownSearchProduct({super.key});

  @override
  _DropDownSearchProductState createState() => _DropDownSearchProductState();
}

class _DropDownSearchProductState extends State<DropDownSearchProduct> {
  @override
  Widget build(BuildContext context) {
    return SearchField(
      hint: 'Cari Produk',
      searchInputDecoration: SearchInputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Monochrome.whiteDarkMode, width: 1),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Main.lightBlue, width: 2),
              borderRadius: BorderRadius.circular(10))),
      itemHeight: 50,
      maxSuggestionsInViewPort: 5,
      suggestionsDecoration: SuggestionDecoration(
          color: Main.lightBlue,
          borderRadius: BorderRadius.circular(10),
          selectionColor: Monochrome.whiteDarkMode),
      suggestions: [
        SearchFieldListItem('Ayam Bakar Nashviled'),
        SearchFieldListItem('Ayam Goreng Nashviled'),
        SearchFieldListItem('Ayam Rebus Nashviled'),
      ],
    );
  }
}
