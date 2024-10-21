// import 'dart:developer';
//
// import 'package:banter/core/providers/folder_provider.dart';
// import 'package:banter/core/providers/notes_providers.dart';
// import 'package:banter/core/services/injection/note_manager/note_manager_injection.dart';
// import 'package:banter/core/utils/show_dialog.dart';
// import 'package:banter/src/note_manager/domain/entity/note_entity.dart';
// import 'package:banter/src/note_manager/presentation/bloc/note_manager_bloc.dart';
// import 'package:banter/src/note_manager/presentation/view/note_view.dart';
// import 'package:banter/src/note_manager/presentation/dialogs/create_folder_dialog.dart';
// import 'package:banter/src/note_manager/presentation/widgets/folder_card.dart';
// import 'package:flutter/material.dart';
// import 'package:banter/core/res/color.dart';
// import 'package:banter/core/widgets/noted_text_field.dart';
// import 'package:banter/core/widgets/noted_text_widget.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get/get.dart';
//
// class FolderView extends ConsumerStatefulWidget {
//   const FolderView({super.key});
//
//   @override
//   ConsumerState<FolderView> createState() => _FolderViewState();
// }
//
// class _FolderViewState extends ConsumerState<FolderView> {
//   late TextEditingController _searchController;
//   late NoteManagerBloc noteManagerBloc;
//   late TextEditingController _folderNameController;
//   List<FolderEntity> searchedFolders = [];
//
//   @override
//   void dispose() {
//     _searchController.dispose();
//     noteManagerBloc.close();
//     _folderNameController.dispose();
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     _searchController = TextEditingController();
//     _searchController.addListener(_searchFolder);
//     _folderNameController = TextEditingController();
//     noteManagerBloc = ref.read(noteManagerBlocProvider);
//     getAllFolders();
//     super.initState();
//   }
//
//   _searchFolder() {
//     final folders = ref.watch(folderProvider);
//
//     setState(() {
//       final searchedText = _searchController.text.toLowerCase().toString();
//       if (searchedText.isEmpty) {
//         searchedFolders = [];
//       } else {
//         searchedFolders = folders
//             .where(
//               (folder) =>
//                   folder.folderName.toLowerCase().contains(searchedText),
//             )
//             .toList();
//         log('Searched: ${searchedFolders[0].folderName}');
//       }
//     });
//   }
//
//   void getAllFolders() {
//     noteManagerBloc.add(GetAllFolderEvent());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final folders = ref.watch(folderProvider);
//     final notes = ref.watch(noteProvider);
//
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//     return BlocProvider(
//       create: (context) => ref.read(noteManagerBlocProvider),
//       child: Scaffold(
//         floatingActionButton: FloatingActionButton(
//           onPressed: () async {
//             showNameDialog(
//               folderNameController: _folderNameController,
//               width: width,
//               height: height,
//               noteBloc: noteManagerBloc,
//             );
//           },
//           backgroundColor: BanterColors.textColor1,
//           child: const Icon(
//             Icons.add,
//           ),
//         ),
//         backgroundColor: BanterColors.darkBackground,
//         body: BlocConsumer<NoteManagerBloc, NoteManagerState>(
//           listener: (context, state) {
//             if (state is FolderCreated) {
//               log('Created folder');
//               context.read<NoteManagerBloc>().add(GetAllFolderEvent());
//             }
//             if (state is GottenFolders) {
//               log('Folder fetched');
//               noteManagerBloc.add(
//                 ReorderFolderListEvent(folders: state.folders),
//               );
//             }
//             if (state is ReorderedFolderList) {
//               log('Reordered folder');
//               context.read<NoteManagerBloc>().add(
//                     SetFolderEvent(state.folders),
//                   );
//             }
//             if (state is FolderDeleted) {
//               BanterDialog.show(title: 'Done', message: 'Box deleted');
//               context.read<NoteManagerBloc>().add(GetAllFolderEvent());
//               log('Folder deleted');
//             }
//             if (state is FolderRenamed) {
//               BanterDialog.show(title: 'Done', message: 'Box renamed');
//               getAllFolders();
//             }
//             if (state is FolderSet) {
//               log('Folder set');
//             }
//             if (state is NoteManagerError) {
//               log('An error occurred: ${state.message}');
//               BanterDialog.show(title: 'Error', message: 'An error occurred');
//             }
//           },
//           builder: (context, state) {
//             return Padding(
//               padding: EdgeInsets.symmetric(horizontal: width * 0.05),
//               child: CustomScrollView(
//                 slivers: [
//                   AppBarSliver(
//                     height: height,
//                     width: width,
//                     ref: ref,
//                     searchController: _searchController,
//                   ),
//                   SliverList(
//                     delegate: SliverChildListDelegate(
//                       [
//                         if (folders.isEmpty)
//                           EmptyScreen(height: height, width: width),
//                       ],
//                     ),
//                   ),
//                   if (folders.isNotEmpty)
//                     SliverList(
//                       delegate: SliverChildBuilderDelegate(
//                         childCount: searchedFolders.isEmpty
//                             ? folders.length
//                             : searchedFolders.length,
//                         (context, index) {
//                           final folder = searchedFolders.isEmpty
//                               ? folders[index]
//                               : searchedFolders[index];
//                           return GestureDetector(
//                             onTap: () {
//                               Get.to(() => const NoteView(), arguments: folder);
//                             },
//                             child: FolderCard(
//                               width: width,
//                               folder: folder,
//                               height: height,
//                               notes: notes,
//                               noteManagerBloc: noteManagerBloc,
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   if (folders.isNotEmpty)
//                     SliverList(
//                       delegate: SliverChildListDelegate(
//                         [
//                           SizedBox(height: height * 0.02),
//                           AddNewNoteCTA(
//                             height: height,
//                             width: width,
//                             text: 'Add new box',
//                           ),
//                         ],
//                       ),
//                     ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
//
// class EmptyScreen extends StatelessWidget {
//   const EmptyScreen({
//     super.key,
//     required this.height,
//     required this.width,
//   });
//
//   final double height;
//   final double width;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//           height: height * 0.20,
//         ),
//         Center(
//           child: BanterTextWidget(
//             text: 'Empty',
//             size: width * 0.07,
//             color: BanterColors.toolBarGrey,
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class AddNewNoteCTA extends StatelessWidget {
//   const AddNewNoteCTA({
//     super.key,
//     required this.height,
//     required this.width,
//     required this.text,
//   });
//
//   final double height;
//   final double width;
//   final String text;
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: height * 0.15,
//       width: width,
//       child: Card(
//         margin: EdgeInsets.only(bottom: height * 0.02),
//         color: Colors.transparent,
//         elevation: 0,
//         shape: ContinuousRectangleBorder(
//           side: const BorderSide(color: Colors.grey),
//           borderRadius: BorderRadius.circular(
//             width * 0.10,
//           ),
//         ),
//         child: Center(
//             child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(
//               Icons.add,
//               color: BanterColors.textColor1,
//             ),
//             SizedBox(
//               width: width * 0.02,
//             ),
//             BanterTextWidget(text: text)
//           ],
//         )),
//       ),
//     );
//   }
// }
//
// class AppBarSliver extends StatelessWidget {
//   const AppBarSliver({
//     super.key,
//     required this.height,
//     required this.width,
//     required this.ref,
//     required TextEditingController searchController,
//   }) : _searchController = searchController;
//
//   final double height;
//   final double width;
//   final TextEditingController _searchController;
//   final WidgetRef ref;
//
//   @override
//   Widget build(BuildContext context) {
//     return SliverAppBar(
//       backgroundColor: Colors.transparent,
//       expandedHeight: height * 0.27,
//       actions: [
//         IconButton(
//           onPressed: () {},
//           icon: const Icon(
//             color: BanterColors.textColor1,
//             Icons.settings,
//           ),
//         ),
//       ],
//       flexibleSpace: FlexibleSpaceBar(
//         background: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               height: height * 0.10,
//             ),
//             BanterTextWidget(
//               text: 'Your Boxes',
//               size: width * 0.10,
//               color: BanterColors.textColor1,
//             ),
//             SizedBox(
//               height: height * 0.02,
//             ),
//             Row(
//               children: [
//                 InkWell(
//                     onTap: () {
//                       Get.offAll(() => const NoteView());
//                     },
//                     child: FolderSwitcher(height: height, width: width)),
//                 SizedBox(
//                   width: width * 0.02,
//                 ),
//                 SearchField(width: width, searchController: _searchController),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class SearchField extends StatelessWidget {
//   const SearchField({
//     super.key,
//     required this.width,
//     required TextEditingController searchController,
//   }) : _searchController = searchController;
//
//   final double width;
//   final TextEditingController _searchController;
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: NotedTextField(
//         hintText: 'Search',
//         hintColor: BanterColors.textColor1,
//         borderRadius: width * 0.04,
//         controller: _searchController,
//       ),
//     );
//   }
// }
//
// class FolderSwitcher extends StatelessWidget {
//   const FolderSwitcher({
//     super.key,
//     required this.height,
//     required this.width,
//   });
//
//   final double height;
//   final double width;
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: height * 0.07,
//       width: width * 0.15,
//       child: Card(
//         elevation: 0,
//         color: Colors.transparent,
//         shape: ContinuousRectangleBorder(
//           side: const BorderSide(color: Colors.grey),
//           borderRadius: BorderRadius.circular(
//             width * 0.07,
//           ),
//         ),
//         child: const Icon(
//           Icons.notes,
//           color: BanterColors.textColor1,
//         ),
//       ),
//     );
//   }
// }
// /**
//  * Background: #303030
//  * Card: #424242
//  */

import 'dart:developer';
import 'package:banter/core/providers/state_providers/state_providers.dart';
import 'package:banter/src/auth_manager/presentation/bloc/auth_bloc.dart';
import 'package:banter/src/note_manager/domain/entity/note_entity.dart';
import 'package:banter/src/note_manager/presentation/animations/welcome_animation.dart';
import 'package:banter/src/note_manager/presentation/widgets/add_new_note_button.dart';
import 'package:banter/src/note_manager/presentation/widgets/empty_screen.dart';
import 'package:banter/src/note_manager/presentation/widgets/folder_card_item.dart';
import 'package:banter/src/note_manager/presentation/widgets/folder_sliver_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:banter/core/providers/folder_provider.dart';
import 'package:banter/core/providers/notes_providers.dart';
import 'package:banter/core/res/color.dart';
import 'package:banter/core/utils/show_dialog.dart';
import 'package:banter/src/note_manager/presentation/bloc/note_manager_bloc.dart';
import 'package:banter/src/note_manager/presentation/dialogs/create_folder_dialog.dart';

class FolderView extends ConsumerStatefulWidget {
  const FolderView({super.key});

  @override
  ConsumerState<FolderView> createState() => _FolderViewState();
}

class _FolderViewState extends ConsumerState<FolderView>
    with TickerProviderStateMixin {
  late TextEditingController _searchController;

  late NoteManagerBloc noteManagerBloc;
  late AuthBloc authenticationBloc;
  late AnimationController _rotateController;
  late TextEditingController _folderNameController;
  late WelcomeAnimation _welcomeAnimation;
  late AnimationController _welcomeAnimationController;
  List<FolderEntity> searchedFolders = [];

  @override
  void initState() {
    _initializeData();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (ref.read(isSyncingProvider) == true) {
      _rotateController.repeat();
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _folderNameController.dispose();
    _rotateController.stop();
    _rotateController.dispose();
    _welcomeAnimationController.dispose();
    super.dispose();
  }

  void _initializeData() {
    _welcomeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _welcomeAnimation = WelcomeAnimation(_welcomeAnimationController);
    noteManagerBloc = context.read<NoteManagerBloc>();
    authenticationBloc = context.read<AuthBloc>();
    _searchController = TextEditingController();
    _folderNameController = TextEditingController();
    _searchController.addListener(_searchFolder);
    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _welcomeAnimationController.forward();
    // getAllFolders();
  }

  void _searchFolder() {
    final folders = ref.watch(folderProvider);
    setState(() {
      final searchText = _searchController.text.toLowerCase();
      if (searchText.isNotEmpty) {
        searchedFolders = folders
            .where((folder) =>
                folder.folderName.toLowerCase().contains(searchText))
            .toList();
      } else {
        searchedFolders = [];
      }
    });
  }

  void getAllFolders() {
    context.read<NoteManagerBloc>().add(GetAllFolderEvent());
  }

  @override
  Widget build(BuildContext context) {
    final folders = ref.watch(folderProvider);
    final notes = ref.watch(noteProvider);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton: _buildFloatingActionButton(width, height),
      backgroundColor: BanterColors.darkBackground,
      body: BlocConsumer<NoteManagerBloc, NoteManagerState>(
        listener: _blocStateListener,
        builder: (context, state) {
          return _buildFolderList(context, folders, notes, width, height);
        },
      ),
    );
  }

  Widget _buildFloatingActionButton(double width, double height) {
    return ScaleTransition(
      scale: _welcomeAnimation.pop,
      child: FloatingActionButton(
        onPressed: () async {
          showCreateFolderDialog(
              folderNameController: _folderNameController,
              width: width,
              height: height,
              context: context);
        },
        backgroundColor: BanterColors.textColor1,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _blocStateListener(BuildContext context, NoteManagerState state) {
    if (state is FolderCreated) {
      log('Created folder');
      context.read<NoteManagerBloc>().add(GetAllFolderEvent());
    } else if (state is GottenFolders) {
      log('Folder fetched');
      context
          .read<NoteManagerBloc>()
          .add(ReorderFolderListEvent(folders: state.folders));
    } else if (state is ReorderedFolderList) {
      log('Reordered folder');
      context.read<NoteManagerBloc>().add(SetFolderEvent(state.folders));
    } else if (state is FolderDeleted) {
      BanterDialog.show(title: 'Done', message: 'Box deleted');
      context.read<NoteManagerBloc>().add(GetAllFolderEvent());
      log('Folder deleted');
    } else if (state is FolderRenamed) {
      BanterDialog.show(title: 'Done', message: 'Box renamed');
      getAllFolders();
    } else if (state is NoteManagerError) {
      log('An error occurred: ${state.message}');
      BanterDialog.show(title: 'Error', message: 'An error occurred');
    } else if (state is SyncCompleted) {
      _rotateController.stop();
    }
  }

  Widget _buildFolderList(BuildContext context, List<FolderEntity> folders,
      List<NoteEntity> notes, double width, double height) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: CustomScrollView(
        slivers: [
          FolderSliverAppbar(
            height: height,
            width: width,
            ref: ref,
            welcomeAnimation: _welcomeAnimation,
            searchController: _searchController,
            rotationController: _rotateController,
            authenticationBloc: authenticationBloc,
            noteManagerBloc: noteManagerBloc,
          ),
          if (folders.isEmpty)
            SliverToBoxAdapter(
                child: EmptyScreen(
              height: height,
              width: width,
            )),
          if (folders.isNotEmpty)
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final folder = searchedFolders.isEmpty
                      ? folders[index]
                      : searchedFolders[index];
                  return SlideTransition(
                    position: _welcomeAnimation.slideFromRight,
                    child: FolderCardItem(
                      folder: folder,
                      notes: notes,
                      context: context,
                      width: width,
                      height: height,
                    ),
                  );
                },
                childCount: searchedFolders.isEmpty
                    ? folders.length
                    : searchedFolders.length,
              ),
            ),
          if (folders.isNotEmpty)
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: height * 0.02),
                GestureDetector(
                  onTap: () {
                    showCreateFolderDialog(
                        folderNameController: _folderNameController,
                        width: width,
                        height: height,
                        context: context);
                  },
                  child: SlideTransition(
                    position: _welcomeAnimation.slideFromLeft,
                    child: AddNewItemBtn(
                      height: height,
                      width: width,
                      text: 'Add new box',
                    ),
                  ),
                ),
              ]),
            ),
        ],
      ),
    );
  }
}
