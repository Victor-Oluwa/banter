import 'package:banter/core/widgets/noted_text_field.dart';
import 'package:flutter/material.dart';
import 'package:banter/core/res/color.dart';


class SearchField extends StatelessWidget {
  final double width;
  final TextEditingController searchController;

  const SearchField({
    super.key,
    required this.width,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NotedTextField(
        hintText: 'Search',
        hintColor: BanterColors.textColor1,
        borderRadius: width * 0.04,
        controller: searchController,
      ),
    );
  }
}