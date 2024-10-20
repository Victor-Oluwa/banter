
import 'package:banter/core/res/color.dart';
import 'package:banter/core/widgets/noted_text_widget.dart';
import 'package:banter/src/note_manager/presentation/widgets/editor/banter_tool_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart'as ql;

class ToolsRevealer extends StatelessWidget {
  const ToolsRevealer({
    super.key,
    required ql.QuillController controller,
  }) : _controller = controller;

  final ql.QuillController _controller;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(horizontal: 4),
      collapsedIconColor: BanterColors.toolBarGrey,
      iconColor: BanterColors.toolBarGrey,
      shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(15), side: BorderSide.none),
      title: const BanterTextWidget(
        text: 'Tools',
      ),
      children: [
        BanterToolBar(controller: _controller),
      ],
    );
  }
}

