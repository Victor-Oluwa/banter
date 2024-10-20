import 'package:flutter/material.dart';
import 'package:banter/core/res/color.dart';
import 'package:banter/core/widgets/noted_text_widget.dart';

class EmptyScreen extends StatelessWidget {
  final double height;
  final double width;

  const EmptyScreen({super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: height * 0.20),
        Center(
          child: BanterTextWidget(
            text: 'Empty',
            size: width * 0.07,
            color: BanterColors.toolBarGrey,
          ),
        ),
      ],
    );
  }
}