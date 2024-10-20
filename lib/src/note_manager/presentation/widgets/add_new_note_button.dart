import 'package:flutter/material.dart';
import 'package:banter/core/res/color.dart';
import 'package:banter/core/widgets/noted_text_widget.dart';


class AddNewItemBtn extends StatelessWidget {
  final double height;
  final double width;
  final String text;

  const AddNewItemBtn({
    super.key,
    required this.height,
    required this.width,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.15,
      width: width,
      child: Card(
        margin: EdgeInsets.only(bottom: height * 0.02),
        color: Colors.transparent,
        elevation: 0,
        shape: ContinuousRectangleBorder(
          side: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(width * 0.10),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.add, color: BanterColors.textColor1),
              SizedBox(width: width * 0.02),
              BanterTextWidget(text: text),
            ],
          ),
        ),
      ),
    );
  }
}