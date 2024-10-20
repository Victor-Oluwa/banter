// import 'dart:developer';
//
// import 'package:banter/core/services/injection/note_manager/note_manager_injection.dart';
// import 'package:banter/core/utils/typedef.dart';
// import 'package:banter/src/note_manager/domain/entity/note_entity.dart';
// import 'package:banter/src/note_manager/presentation/bloc/note_manager_bloc.dart';
// import 'package:banter/src/note_manager/presentation/widgets/toolbar_button_options.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_quill/flutter_quill.dart' as ql;
// import 'package:flutter_quill/flutter_quill.dart';
// import 'package:banter/core/res/color.dart';
// import 'package:banter/core/res/fonts.dart';
// import 'package:banter/core/widgets/noted_text_field.dart';
// import 'package:banter/core/widgets/noted_text_widget.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';
//
// class CreateNoteView extends ConsumerStatefulWidget {
//   const CreateNoteView({super.key});
//
//   @override
//   ConsumerState<CreateNoteView> createState() => _CreateNoteViewState();
// }
//
// class _CreateNoteViewState extends ConsumerState<CreateNoteView> {
//   final argument = Get.arguments;
//   late ql.QuillController _controller;
//   late TextEditingController _titleController;
//   final _editorFocusNode = FocusNode();
//   final _editorScrollController = ScrollController();
//   late NoteManagerBloc noteManagerBloc;
//   var _isReadOnly = false;
//   bool isSaved = false;
//
//   // var _isSpellcheckerActive = false;
//
//   final doc = ql.Document()..insert(0, 'Welcome to Banter!');
//
//   @override
//   void initState() {
//     noteManagerBloc = ref.read(noteManagerBlocProvider);
//
//     List<dynamic>? bodyFromArg;
//     String? titleFromArg;
//     Document? body;
//
//     if (argument is NoteEntity) {
//       bodyFromArg = argument?.body;
//       titleFromArg = argument?.title;
//     } else if (argument is StringMap) {
//       bodyFromArg = argument?['note'].body;
//       titleFromArg = argument?['note'].title;
//     }
//     if (bodyFromArg != null) {
//       body = ql.Document.fromJson(bodyFromArg);
//     }
//     _controller = ql.QuillController(
//       document: body ?? doc,
//       selection: const TextSelection.collapsed(offset: 0),
//     );
//
//     _titleController = TextEditingController(text: titleFromArg ?? 'Untitled');
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     noteManagerBloc.close();
//     _controller.dispose();
//     _titleController.dispose();
//     _editorFocusNode.dispose();
//     _editorScrollController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//
//     // Dynamic text sizes based on screen width
//     double h1Size = width * 0.08; // 8% of screen width
//     double h2Size = width * 0.06; // 6% of screen width
//     double h3Size = width * 0.045; // 4.5% of screen width
//     double titleSize = width * 0.10;
//     double paragraphSize = width * 0.035; // 3.5% of screen width
//
//     _controller.readOnly = _isReadOnly;
//     return PopScope(
//       canPop: false,
//       onPopInvokedWithResult: (canPop, _) async {
//         if (argument is String || argument == null) {
//           if (isSaved) {
//             return;
//           }
//           log('Argument is String! :: $argument');
//           final noteId = UniqueKey();
//
//           noteManagerBloc.add(
//             CreateNewNoteEvent(
//               id: noteId.toString(),
//               title: _titleController.text.toString(),
//               body: _controller.document.toDelta().toJson(),
//               dateCreated: DateTime.now().toIso8601String(),
//               lastEdited: DateTime.now().toIso8601String(),
//               ownerId: '',
//               folderIds: [argument ?? ''],
//             ),
//           );
//           log('New note created');
//         }
//         if (argument is StringMap || argument is NoteEntity) {
//           if (isSaved) {
//             return;
//           }
//
//           String? id;
//           String? dateCreated;
//           List<String>? folders;
//
//           if (argument is StringMap) {
//             id = argument['note'].id;
//             dateCreated = argument['note'].dateCreated;
//             folders = argument['note'].folderIds;
//           } else {
//             id = argument?.id;
//             dateCreated = argument?.dateCreated;
//             folders = argument?.folderIds;
//           }
//           noteManagerBloc.add(
//             UpdateNoteEvent(
//               id: id ?? '',
//               title: _titleController.text,
//               body: _controller.document.toDelta().toJson(),
//               dateCreated: dateCreated ?? '',
//               lastEdited: DateTime.now().toIso8601String(),
//               ownerId: '',
//               folderIds: folders ?? [],
//             ),
//           );
//           log('Note edited');
//         }
//       },
//       child: BlocProvider(
//         create: (context) => ref.read(noteManagerBlocProvider),
//         child: Scaffold(
//           appBar: AppBar(
//             leading: Icon(
//               Icons.more_vert_rounded,
//               color: BanterColors.textColor1,
//             ),
//             toolbarHeight: height * 0.10,
//             backgroundColor: Colors.transparent,
//             automaticallyImplyLeading: false,
//             actions: [
//               if (_isReadOnly)
//                 Padding(
//                   padding: EdgeInsets.only(
//                     right: width * 0.05,
//                     top: height * 0.03,
//                   ),
//                   child: IconButton(
//                     onPressed: () {
//                       setState(() {
//                         _isReadOnly = false;
//                       });
//                     },
//                     icon: Column(
//                       children: [
//                         Icon(
//                           Icons.edit_note_rounded,
//                           color: BanterColors.textColor1,
//                           size: width * 0.07,
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//               else
//                 Padding(
//                   padding: EdgeInsets.only(
//                     right: width * 0.05,
//                     top: height * 0.03,
//                   ),
//                   child: IconButton(
//                     onPressed: () {
//                       setState(() {
//                         _isReadOnly = true;
//                       });
//                     },
//                     icon: Column(
//                       children: [
//                         Icon(
//                           Icons.zoom_in_map,
//                           color: BanterColors.textColor1,
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//             ],
//             title: NotedTextField(
//               isReadOnly: _isReadOnly,
//               contentPadding: EdgeInsets.zero,
//               hintText: 'Untitled',
//               hintSize: width * 0.10,
//               controller: _titleController,
//               textSize: titleSize,
//               isBorderless: true,
//             ),
//           ),
//           backgroundColor: BanterColors.darkBackground,
//           body: BlocConsumer<NoteManagerBloc, NoteManagerState>(
//             listener: (context, state) {
//               if (state is NoteCreated) {
//                 log('Note created');
//                 context.read<NoteManagerBloc>().add(const GetAllNotesEvent());
//               }
//
//               if (state is NoteUpdated) {
//                 context.read<NoteManagerBloc>().add(const GetAllNotesEvent());
//               }
//
//               if (state is GottenNotes) {
//                 log('Gotten note');
//                 if (argument is String) {
//                   noteManagerBloc.add(
//                     GetFolderNotesEvent(
//                       notes: state.notes,
//                       folderId: argument,
//                     ),
//                   );
//                 } else if (argument is StringMap) {
//                   noteManagerBloc.add(
//                     GetFolderNotesEvent(
//                       notes: state.notes,
//                       folderId: argument['folderId'],
//                     ),
//                   );
//                 } else {
//                   noteManagerBloc.add(
//                     ReorderNoteListEvent(notes: state.notes),
//                   );
//                 }
//               }
//               if (state is GottenFolderNotes) {
//                 noteManagerBloc.add(
//                   ReorderNoteListEvent(notes: state.notes),
//                 );
//               }
//
//               if (state is ReorderedNoteList) {
//                 final notes = List<NoteEntity>.from(state.notes)
//                     .map((e) => e.toMap())
//                     .toList();
//
//                 context.read<NoteManagerBloc>().add(
//                       SetNoteEvent(notes: notes),
//                     );
//               }
//
//               if (state is NoteSet) {
//                 log('Note set from CreateNote');
//                 setState(() {
//                   isSaved = true;
//                 });
//                 Get.back();
//               }
//
//               if (state is NoteManagerError) {
//                 log('Note manager error: ${state.message}');
//               }
//             },
//             builder: (context, state) {
//               return SafeArea(
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: width * 0.05),
//                   child: Column(children: [
//                     !_isReadOnly
//                         ? Column(
//                             children: [
//                               ToolsRevealer(controller: _controller),
//                               Divider(color: Colors.grey.shade700),
//                             ],
//                           )
//                         : const SizedBox.shrink(),
//                     SizedBox(
//                       height: height * 0.02,
//                     ),
//                     Expanded(
//                       child: ql.QuillEditor(
//                         scrollController: _editorScrollController,
//                         focusNode: _editorFocusNode,
//                         controller: _controller,
//                         configurations: ql.QuillEditorConfigurations(
//                           scrollable: true,
//                           customStyles:
//                           ql.DefaultStyles(
//                             color: BanterColors.textColor1,
//                             h1: _getDefaultTextStyle(
//                                 horiSpaceLeft: 0.0,
//                                 horiSpaceRight: 0.0,
//                                 lineSpaceLeft: 0.0,
//                                 lineSpaceRight: 0.0,
//                                 vertiSpaceLeft: 0,
//                                 vertiSpaceRight: 1.5,
//                                 fontSize: h1Size,
//                                 fontWeight: FontWeight.bold),
//                             h2: _getDefaultTextStyle(
//                               horiSpaceLeft: 0.0,
//                               horiSpaceRight: 0.0,
//                               lineSpaceLeft: 0.0,
//                               lineSpaceRight: 0.0,
//                               vertiSpaceLeft: 0,
//                               vertiSpaceRight: 1.5,
//                               fontSize: h2Size,
//                             ),
//                             h3: _getDefaultTextStyle(
//                                 horiSpaceLeft: 0.0,
//                                 horiSpaceRight: 0.0,
//                                 lineSpaceLeft: 0.0,
//                                 lineSpaceRight: 0.0,
//                                 vertiSpaceLeft: 0,
//                                 vertiSpaceRight: 1.5,
//                                 fontSize: h1Size),
//                             paragraph: _getDefaultTextStyle(
//                               horiSpaceLeft: 0.0,
//                               horiSpaceRight: 0.0,
//                               lineSpaceLeft: 0.0,
//                               lineSpaceRight: 0.0,
//                               vertiSpaceLeft: 0,
//                               vertiSpaceRight: 1.5,
//                               fontSize: paragraphSize,
//                             ),
//                           ),
//                         ),
//                       ),
//                     )
//                   ]),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   DefaultTextBlockStyle _getDefaultTextStyle({
//     required double horiSpaceLeft,
//     required double horiSpaceRight,
//     required double vertiSpaceLeft,
//     required double vertiSpaceRight,
//     required double lineSpaceLeft,
//     required double lineSpaceRight,
//     double? fontSize,
//     FontWeight? fontWeight,
//   }) {
//     return ql.DefaultTextBlockStyle(
//       TextStyle(
//         color: BanterColors.textColor1,
//         fontFamily: BanterFonts.balooBhai,
//         fontSize: fontSize,
//         fontWeight: fontWeight,
//       ),
//       ql.HorizontalSpacing(horiSpaceLeft, horiSpaceRight),
//       ql.VerticalSpacing(vertiSpaceLeft, vertiSpaceRight),
//       ql.VerticalSpacing(lineSpaceLeft, lineSpaceRight),
//       null,
//     );
//   }
// }
//
// class ToolsRevealer extends StatelessWidget {
//   const ToolsRevealer({
//     super.key,
//     required ql.QuillController controller,
//   }) : _controller = controller;
//
//   final ql.QuillController _controller;
//
//   @override
//   Widget build(BuildContext context) {
//     return ExpansionTile(
//       tilePadding: const EdgeInsets.symmetric(horizontal: 4),
//       collapsedIconColor: BanterColors.toolBarGrey,
//       iconColor: BanterColors.toolBarGrey,
//       shape: ContinuousRectangleBorder(
//           borderRadius: BorderRadius.circular(15), side: BorderSide.none),
//       title: const BanterTextWidget(
//         text: 'Tools',
//       ),
//       children: [
//         NotedToolBar(controller: _controller),
//       ],
//     );
//   }
// }
//
// class NotedToolBar extends StatefulWidget {
//   const NotedToolBar({
//     super.key,
//     required ql.QuillController controller,
//   }) : _controller = controller;
//
//   final ql.QuillController _controller;
//
//   @override
//   State<NotedToolBar> createState() => _NotedToolBarState();
// }
//
// class _NotedToolBarState extends State<NotedToolBar> {
//   late ql.Attribute<String?> currentAlignment;
//
//   _setAlignment(ql.Attribute<String?> alignment) {
//     widget._controller.formatSelection(alignment);
//     setState(() {
//       currentAlignment = alignment;
//     });
//   }
//
//   @override
//   void initState() {
//     currentAlignment = ql.Attribute.leftAlignment;
//     super.initState();
//   }
//
//   _buildAlignButton(
//       {required String toolTip,
//       required IconData icon,
//       required ql.Attribute<String?> alignment}) {
//     return ql.QuillToolbarCustomButtonOptions(
//       onPressed: () {
//         _setAlignment(alignment);
//       },
//       tooltip: toolTip,
//       icon: Icon(
//         icon,
//         color: currentAlignment == alignment
//             ? BanterColors.tunnel
//             : BanterColors.toolBarGrey,
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 0,
//       color: BanterColors.cardColor,
//       child: ql.QuillToolbar.simple(
//         controller: widget._controller,
//         configurations: ql.QuillSimpleToolbarConfigurations(
//           customButtons: [
//             _buildAlignButton(
//               icon: Icons.format_align_left,
//               alignment: ql.Attribute.leftAlignment,
//               toolTip: 'Align left',
//             ),
//             _buildAlignButton(
//               icon: Icons.format_align_center,
//               alignment: ql.Attribute.centerAlignment,
//               toolTip: 'Align center',
//             ),
//             _buildAlignButton(
//               icon: Icons.format_align_right,
//               alignment: ql.Attribute.rightAlignment,
//               toolTip: 'Align right',
//             ),
//             _buildAlignButton(
//               icon: Icons.format_align_justify,
//               alignment: ql.Attribute.justifyAlignment,
//               toolTip: 'Align justify',
//             ),
//           ],
//           showAlignmentButtons: false,
//           searchButtonType: ql.SearchButtonType.modern,
//           buttonOptions: buttonOptions(),
//           color: Colors.white12,
//           decoration: const BoxDecoration(
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }
// }
