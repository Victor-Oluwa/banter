import 'package:banter/core/res/color.dart';
import 'package:banter/core/res/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as ql;
import 'package:flutter_quill/flutter_quill.dart';

QuillSimpleToolbarButtonOptions buttonOptions (){
  return ql.QuillSimpleToolbarButtonOptions(
    undoHistory: const ql.QuillToolbarHistoryButtonOptions(
      iconTheme: ql.QuillIconTheme(
        iconButtonSelectedData: ql.IconButtonData(color: Colors.green),
        iconButtonUnselectedData: ql.IconButtonData(color: Colors.blueGrey),
      ),
    ),
    redoHistory: const ql.QuillToolbarHistoryButtonOptions(
      iconTheme: ql.QuillIconTheme(
        iconButtonSelectedData: ql.IconButtonData(color: Colors.green),
        iconButtonUnselectedData: ql.IconButtonData(color: Colors.blueGrey),
      ),
    ),
    fontFamily: QuillToolbarFontFamilyButtonOptions(
      style: TextStyle(
        color: BanterColors.tunnel,
        fontFamily: BanterFonts.balooBhai,
      ),
    ),
    fontSize: QuillToolbarFontSizeButtonOptions(
      style: TextStyle(
        color: BanterColors.tunnel,
        fontFamily: BanterFonts.balooBhai,
      ),
    ),
    bold: ql.QuillToolbarToggleStyleButtonOptions(
      iconTheme: ql.QuillIconTheme(
        iconButtonUnselectedData: const ql.IconButtonData(
          color: BanterColors.toolBarGrey,
        ),
        iconButtonSelectedData: ql.IconButtonData(
            color: BanterColors.darkBackground,
            disabledColor: BanterColors.darkBackground,
            style: ButtonStyle(
              backgroundColor:
              WidgetStateProperty.all<Color>(Colors.blueGrey),
            )),
      ),
    ),
    italic: ql.QuillToolbarToggleStyleButtonOptions(
      iconTheme: ql.QuillIconTheme(
        iconButtonUnselectedData: const ql.IconButtonData(
          color: BanterColors.toolBarGrey,
        ),
        iconButtonSelectedData: ql.IconButtonData(
          color: BanterColors.darkBackground,
          disabledColor: BanterColors.darkBackground,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(Colors.blueGrey),
          ),
        ),
      ),
    ),
    underLine: ql.QuillToolbarToggleStyleButtonOptions(
      iconTheme: ql.QuillIconTheme(
        iconButtonUnselectedData: const ql.IconButtonData(
          color: BanterColors.toolBarGrey,
        ),
        iconButtonSelectedData: ql.IconButtonData(
            color: BanterColors.darkBackground,
            disabledColor: BanterColors.darkBackground,
            style: ButtonStyle(
              backgroundColor:
              WidgetStateProperty.all<Color>(Colors.blueGrey),
            )),
      ),
    ),
    strikeThrough: ql.QuillToolbarToggleStyleButtonOptions(
      iconTheme: ql.QuillIconTheme(
        iconButtonUnselectedData: const ql.IconButtonData(
          color: BanterColors.toolBarGrey,
        ),
        iconButtonSelectedData: ql.IconButtonData(
            color: BanterColors.darkBackground,
            disabledColor: BanterColors.darkBackground,
            style: ButtonStyle(
              backgroundColor:
              WidgetStateProperty.all<Color>(Colors.blueGrey),
            )),
      ),
    ),
    inlineCode: ql.QuillToolbarToggleStyleButtonOptions(
      iconTheme: ql.QuillIconTheme(
        iconButtonUnselectedData: const ql.IconButtonData(
          color: BanterColors.toolBarGrey,
        ),
        iconButtonSelectedData: ql.IconButtonData(
            color: BanterColors.darkBackground,
            disabledColor: BanterColors.darkBackground,
            style: ButtonStyle(
              backgroundColor:
              WidgetStateProperty.all<Color>(Colors.blueGrey),
            )),
      ),
    ),
    subscript: ql.QuillToolbarToggleStyleButtonOptions(
      iconTheme: ql.QuillIconTheme(
        iconButtonUnselectedData: const ql.IconButtonData(
          color: BanterColors.toolBarGrey,
        ),
        iconButtonSelectedData: ql.IconButtonData(
            color: BanterColors.darkBackground,
            disabledColor: BanterColors.darkBackground,
            style: ButtonStyle(
              backgroundColor:
              WidgetStateProperty.all<Color>(Colors.blueGrey),
            )),
      ),
    ),
    superscript: ql.QuillToolbarToggleStyleButtonOptions(
      iconTheme: ql.QuillIconTheme(
        iconButtonUnselectedData: const ql.IconButtonData(
          color: BanterColors.toolBarGrey,
        ),
        iconButtonSelectedData: ql.IconButtonData(
            color: BanterColors.darkBackground,
            disabledColor: BanterColors.darkBackground,
            style: ButtonStyle(
              backgroundColor:
              WidgetStateProperty.all<Color>(Colors.blueGrey),
            )),
      ),
    ),
    color: ql.QuillToolbarColorButtonOptions(
      iconTheme: ql.QuillIconTheme(
        iconButtonUnselectedData: const ql.IconButtonData(
          color: BanterColors.toolBarGrey,
        ),
        iconButtonSelectedData: ql.IconButtonData(
            color: BanterColors.darkBackground,
            disabledColor: BanterColors.darkBackground,
            style: ButtonStyle(
              backgroundColor:
              WidgetStateProperty.all<Color>(Colors.blueGrey),
            )),
      ),
    ),
    backgroundColor: ql.QuillToolbarColorButtonOptions(
      iconTheme: ql.QuillIconTheme(
        iconButtonUnselectedData: const ql.IconButtonData(
          color: BanterColors.toolBarGrey,
        ),
        iconButtonSelectedData: ql.IconButtonData(
            color: BanterColors.darkBackground,
            disabledColor: BanterColors.darkBackground,
            style: ButtonStyle(
              backgroundColor:
              WidgetStateProperty.all<Color>(Colors.blueGrey),
            )),
      ),
    ),
    clearFormat: ql.QuillToolbarClearFormatButtonOptions(
      iconTheme: ql.QuillIconTheme(
        iconButtonUnselectedData: const ql.IconButtonData(
          color: BanterColors.toolBarGrey,
        ),
        iconButtonSelectedData: ql.IconButtonData(
            color: BanterColors.darkBackground,
            disabledColor: BanterColors.darkBackground,
            style: ButtonStyle(
              backgroundColor:
              WidgetStateProperty.all<Color>(Colors.blueGrey),
            )),
      ),
    ),
    selectHeaderStyleButtons: QuillToolbarSelectHeaderStyleButtonsOptions(
      iconTheme: ql.QuillIconTheme(
        iconButtonUnselectedData: const ql.IconButtonData(
          color: BanterColors.toolBarGrey,
        ),
        iconButtonSelectedData: ql.IconButtonData(
            color: BanterColors.darkBackground,
            disabledColor: BanterColors.darkBackground,
            style: ButtonStyle(
              backgroundColor:
              WidgetStateProperty.all<Color>(Colors.blueGrey),
            )),
      ),
    ),
    search: ql.QuillToolbarSearchButtonOptions(
      iconTheme: ql.QuillIconTheme(
        iconButtonUnselectedData: const ql.IconButtonData(
          color: BanterColors.toolBarGrey,
        ),
        iconButtonSelectedData: ql.IconButtonData(
            color: BanterColors.darkBackground,
            disabledColor: BanterColors.darkBackground,
            style: ButtonStyle(
              backgroundColor:
              WidgetStateProperty.all<Color>(Colors.blueGrey),
            )),
      ),
    ),
    selectHeaderStyleDropdownButton:
    ql.QuillToolbarSelectHeaderStyleDropdownButtonOptions(
      iconTheme: ql.QuillIconTheme(
        iconButtonUnselectedData: const ql.IconButtonData(
          color: BanterColors.toolBarGrey,
        ),
        iconButtonSelectedData: ql.IconButtonData(
            color: BanterColors.darkBackground,
            disabledColor: BanterColors.darkBackground,
            style: ButtonStyle(
              backgroundColor:
              WidgetStateProperty.all<Color>(Colors.blueGrey),
            )),
      ),
      textStyle: TextStyle(
          fontFamily: BanterFonts.balooBhai, color: BanterColors.tunnel),
    ),
    listNumbers: ql.QuillToolbarToggleStyleButtonOptions(
      iconTheme: ql.QuillIconTheme(
        iconButtonUnselectedData: const ql.IconButtonData(
          color: BanterColors.toolBarGrey,
        ),
        iconButtonSelectedData: ql.IconButtonData(
            color: BanterColors.darkBackground,
            disabledColor: BanterColors.darkBackground,
            style: ButtonStyle(
              backgroundColor:
              WidgetStateProperty.all<Color>(Colors.blueGrey),
            )),
      ),
    ),
    listBullets: ql.QuillToolbarToggleStyleButtonOptions(
      iconTheme: ql.QuillIconTheme(
        iconButtonUnselectedData: const ql.IconButtonData(
          color: BanterColors.toolBarGrey,
        ),
        iconButtonSelectedData: ql.IconButtonData(
            color: BanterColors.darkBackground,
            disabledColor: BanterColors.darkBackground,
            style: ButtonStyle(
              backgroundColor:
              WidgetStateProperty.all<Color>(Colors.blueGrey),
            )),
      ),
    ),
    toggleCheckList: ql.QuillToolbarToggleCheckListButtonOptions(
      iconTheme: ql.QuillIconTheme(
        iconButtonUnselectedData: const ql.IconButtonData(
          color: BanterColors.toolBarGrey,
        ),
        iconButtonSelectedData: ql.IconButtonData(
            color: BanterColors.darkBackground,
            disabledColor: BanterColors.darkBackground,
            style: ButtonStyle(
              backgroundColor:
              WidgetStateProperty.all<Color>(Colors.blueGrey),
            )),
      ),
    ),
    codeBlock: ql.QuillToolbarToggleStyleButtonOptions(
      iconTheme: ql.QuillIconTheme(
        iconButtonUnselectedData: const ql.IconButtonData(
          color: BanterColors.toolBarGrey,
        ),
        iconButtonSelectedData: ql.IconButtonData(
            color: BanterColors.darkBackground,
            disabledColor: BanterColors.darkBackground,
            style: ButtonStyle(
              backgroundColor:
              WidgetStateProperty.all<Color>(Colors.blueGrey),
            )),
      ),
    ),
    quote: ql.QuillToolbarToggleStyleButtonOptions(
      iconTheme: ql.QuillIconTheme(
        iconButtonUnselectedData: const ql.IconButtonData(
          color: BanterColors.toolBarGrey,
        ),
        iconButtonSelectedData: ql.IconButtonData(
            color: BanterColors.darkBackground,
            disabledColor: BanterColors.darkBackground,
            style: ButtonStyle(
              backgroundColor:
              WidgetStateProperty.all<Color>(Colors.blueGrey),
            )),
      ),
    ),
    clipboardCopy: ql.QuillToolbarToggleStyleButtonOptions(
      iconTheme: ql.QuillIconTheme(
        iconButtonUnselectedData: const ql.IconButtonData(
          disabledColor: BanterColors.toolBarGrey,
          color: BanterColors.toolBarGrey,
        ),
        iconButtonSelectedData: ql.IconButtonData(
            color: BanterColors.darkBackground,
            disabledColor: BanterColors.darkBackground,
            style: ButtonStyle(
              backgroundColor:
              WidgetStateProperty.all<Color>(Colors.blueGrey),
            )),
      ),
    ),
    clipboardPaste: ql.QuillToolbarToggleStyleButtonOptions(
      iconTheme: ql.QuillIconTheme(
        iconButtonUnselectedData: const ql.IconButtonData(
          disabledColor: BanterColors.toolBarGrey,
          color: BanterColors.toolBarGrey,
        ),
        iconButtonSelectedData: ql.IconButtonData(
            color: BanterColors.darkBackground,
            disabledColor: BanterColors.darkBackground,
            style: ButtonStyle(
              backgroundColor:
              WidgetStateProperty.all<Color>(Colors.blueGrey),
            )),
      ),
    ),
    clipboardCut: ql.QuillToolbarToggleStyleButtonOptions(
      iconTheme: ql.QuillIconTheme(
        iconButtonUnselectedData: const ql.IconButtonData(
          disabledColor: BanterColors.toolBarGrey,
          color: BanterColors.toolBarGrey,
        ),
        iconButtonSelectedData: ql.IconButtonData(
            color: BanterColors.darkBackground,
            disabledColor: BanterColors.darkBackground,
            style: ButtonStyle(
              backgroundColor:
              WidgetStateProperty.all<Color>(Colors.blueGrey),
            )),
      ),
    ),
    indentDecrease: ql.QuillToolbarIndentButtonOptions(
      iconTheme: ql.QuillIconTheme(
        iconButtonUnselectedData: const ql.IconButtonData(
          disabledColor: BanterColors.toolBarGrey,
          color: BanterColors.toolBarGrey,
        ),
        iconButtonSelectedData: ql.IconButtonData(
            color: BanterColors.darkBackground,
            disabledColor: BanterColors.darkBackground,
            style: ButtonStyle(
              backgroundColor:
              WidgetStateProperty.all<Color>(Colors.blueGrey),
            )),
      ),
    ),
    indentIncrease: ql.QuillToolbarIndentButtonOptions(
      iconTheme: ql.QuillIconTheme(
        iconButtonUnselectedData: const ql.IconButtonData(
          disabledColor: BanterColors.toolBarGrey,
          color: BanterColors.toolBarGrey,
        ),
        iconButtonSelectedData: ql.IconButtonData(
            color: BanterColors.darkBackground,
            disabledColor: BanterColors.darkBackground,
            style: ButtonStyle(
              backgroundColor:
              WidgetStateProperty.all<Color>(Colors.blueGrey),
            )),
      ),
    ),
    linkStyle: ql.QuillToolbarLinkStyleButtonOptions(
      iconTheme: ql.QuillIconTheme(
        iconButtonUnselectedData: const ql.IconButtonData(
          disabledColor: BanterColors.toolBarGrey,
          color: BanterColors.toolBarGrey,
        ),
        iconButtonSelectedData: ql.IconButtonData(
            color: BanterColors.darkBackground,
            disabledColor: BanterColors.darkBackground,
            style: ButtonStyle(
              backgroundColor:
              WidgetStateProperty.all<Color>(Colors.blueGrey),
            )),
      ),
    ),
    selectAlignmentButtons: ql.QuillToolbarSelectAlignmentButtonOptions(
      iconTheme: ql.QuillIconTheme(
        iconButtonUnselectedData: const ql.IconButtonData(
          color: BanterColors.toolBarGrey,
        ),
        iconButtonSelectedData: ql.IconButtonData(
            color: BanterColors.darkBackground,
            disabledColor: BanterColors.darkBackground,
            style: ButtonStyle(
              backgroundColor:
              WidgetStateProperty.all<Color>(Colors.blueGrey),
            )),
      ),
      showCenterAlignment: true,
      showJustifyAlignment: true,
    ),
  );
}
