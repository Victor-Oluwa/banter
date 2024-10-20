// import 'package:flutter/material.dart';
//
import 'package:banter/core/res/color.dart';
import 'package:banter/src/note_manager/presentation/widgets/toolbar_button_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as ql;

class BanterToolBar extends StatefulWidget {
  const BanterToolBar({
    super.key,
    required ql.QuillController controller,
  }) : _controller = controller;

  final ql.QuillController _controller;

  @override
  State<BanterToolBar> createState() => _BanterToolBarState();
}

class _BanterToolBarState extends State<BanterToolBar> {
  late ql.Attribute<String?> currentAlignment;

  _setAlignment(ql.Attribute<String?> alignment) {
    widget._controller.formatSelection(alignment);
    setState(() {
      currentAlignment = alignment;
    });
  }

  @override
  void initState() {
    currentAlignment = ql.Attribute.leftAlignment;
    super.initState();
  }

  _buildAlignButton(
      {required String toolTip,
        required IconData icon,
        required ql.Attribute<String?> alignment}) {
    return ql.QuillToolbarCustomButtonOptions(
      onPressed: () {
        _setAlignment(alignment);
      },
      tooltip: toolTip,
      icon: Icon(
        icon,
        color: currentAlignment == alignment
            ? BanterColors.tunnel
            : BanterColors.toolBarGrey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: BanterColors.cardColor,
      child: ql.QuillToolbar.simple(
        controller: widget._controller,
        configurations: ql.QuillSimpleToolbarConfigurations(
          showClipboardPaste: true,
          customButtons: [
            _buildAlignButton(
              icon: Icons.format_align_left,
              alignment: ql.Attribute.leftAlignment,
              toolTip: 'Align left',
            ),
            _buildAlignButton(
              icon: Icons.format_align_center,
              alignment: ql.Attribute.centerAlignment,
              toolTip: 'Align center',
            ),
            _buildAlignButton(
              icon: Icons.format_align_right,
              alignment: ql.Attribute.rightAlignment,
              toolTip: 'Align right',
            ),
            _buildAlignButton(
              icon: Icons.format_align_justify,
              alignment: ql.Attribute.justifyAlignment,
              toolTip: 'Align justify',
            ),
          ],
          showAlignmentButtons: false,
          searchButtonType: ql.SearchButtonType.modern,
          buttonOptions: buttonOptions(),
          color: Colors.white12,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}