
import 'package:banter/core/providers/state_providers/state_providers.dart';
import 'package:banter/core/services/injection/auth_injection.dart';
import 'package:banter/src/auth_manager/presentation/bloc/auth_bloc.dart';
import 'package:banter/src/note_manager/presentation/animations/welcome_animation.dart';
import 'package:banter/src/note_manager/presentation/widgets/add_new_note_button.dart';
import 'package:banter/src/note_manager/presentation/widgets/empty_screen.dart';
import 'package:banter/src/note_manager/presentation/widgets/note_list.dart';
import 'package:banter/src/note_manager/presentation/widgets/note_sliver_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:banter/core/res/color.dart';
import 'package:banter/core/providers/notes_providers.dart';
import 'package:banter/src/note_manager/domain/entity/note_entity.dart';
import 'package:banter/src/note_manager/presentation/bloc/note_manager_bloc.dart';
import 'package:banter/src/note_manager/presentation/view/create_note_view.dart';

class NoteView extends ConsumerStatefulWidget {
  const NoteView({super.key});

  @override
  ConsumerState<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends ConsumerState<NoteView>
    with TickerProviderStateMixin {
  FolderEntity? folder;
  late TextEditingController _searchController;
  late AnimationController _rotateController;
  late NoteManagerBloc noteManagerBloc;
  late AuthBloc authenticationBloc;
  late WelcomeAnimation _welcomeAnimation;
  late AnimationController _welcomeAnimationController;
  List<NoteEntity> searchedNotes = [];

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  @override
  void didChangeDependencies() {
    if (ref.read(isSyncingProvider) == true) {
      _rotateController.repeat();
    }
    super.didChangeDependencies();
  }

  void _initializeData() {
    folder = Get.arguments;
    _welcomeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _welcomeAnimation = WelcomeAnimation(_welcomeAnimationController);
    // authenticationBloc = ref.read(authBlocProvider);
    authenticationBloc = context.read<AuthBloc>();
    noteManagerBloc = context.read<NoteManagerBloc>();
    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    getAllNotes();
    getAllFolders();
    _searchController = TextEditingController();
    _searchController.addListener(_searchNotes);
    _welcomeAnimationController.forward();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _rotateController.dispose();
    _welcomeAnimationController.dispose();
    super.dispose();
  }

  void _searchNotes() {
    final notes = ref.watch(noteProvider);
    setState(() {
      String searchText = _searchController.text.toLowerCase();
      if (searchText.isNotEmpty) {
        searchedNotes = notes.where((note) {
          return _matchesSearchText(note, searchText);
        }).toList();
      } else {
        searchedNotes = [];
      }
    });
  }

  bool _matchesSearchText(NoteEntity note, String searchText) {
    return note.title.toLowerCase().contains(searchText) ||
        note.body.any((block) {
          final text = block['insert']?.toString() ?? '';
          return text.toLowerCase().contains(searchText);
        });
  }

  void getAllNotes() => noteManagerBloc.add(const GetAllNotesEvent());

  void getAllFolders() => noteManagerBloc.add(GetAllFolderEvent());

  @override
  Widget build(BuildContext context) {
    final notes = ref.watch(noteProvider);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return MultiBlocListener(
      listeners: [
        BlocListener<NoteManagerBloc, NoteManagerState>(
          listener: (context, state) {
            if (state is GottenNotes) {
              _handleGottenNotesState(context, state);
            }else if(state is SyncCompleted){
              _rotateController.stop();
            }else if(state is SyncNoteError){
              _rotateController.stop();
            }
          },
        ),
      ],
      child: Scaffold(
        floatingActionButton: _buildFloatingActionButton(),
        backgroundColor: BanterColors.darkBackground,
        body: BlocBuilder<NoteManagerBloc, NoteManagerState>(
          builder: (context, state) {
            return _buildNoteList(context, notes, width, height);
          },
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return ScaleTransition(
      scale: _welcomeAnimation.pop,
      child: FloatingActionButton(
        onPressed: () {
          Get.to(() => const CreateNoteView(), arguments: folder?.id);
        },
        backgroundColor: BanterColors.textColor1,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _handleGottenNotesState(BuildContext context, GottenNotes state){
    if (folder != null) {
      context.read<NoteManagerBloc>().add(GetFolderNotesEvent(notes: state.notes, folderId: folder!.id));
    } else {
      context.read<NoteManagerBloc>().add(ReorderNoteListEvent(notes: state.notes));
    }
  }


  Widget _buildNoteList(BuildContext context, List<NoteEntity> notes,
      double width, double height) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: CustomScrollView(
        slivers: [
          NoteSliverAppbar(
            height: height,
            width: width,
            ref: ref,
            folder: folder,
            welcomeAnimation: _welcomeAnimation,
            noteManagerBloc: noteManagerBloc,
            searchController: _searchController,
            rotationController: _rotateController,
            authenticationBloc: authenticationBloc,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              notes.isEmpty
                  ? EmptyScreen(height: height, width: width)
                  : SlideTransition(
                position: _welcomeAnimation.slideFromLeft,
                child: NoteList(
                  notes: searchedNotes.isEmpty ? notes : searchedNotes,
                  height: height,
                  width: width,
                  folder: folder,
                ),
              ),
              if (notes.isNotEmpty)
                SlideTransition(
                  position: _welcomeAnimation.slideFromRight,
                  child: AddNewItemBtn(
                    height: height,
                    width: width,
                    text: 'Add new note',
                  ),
                ),
            ]),
          ),
        ],
      ),
    );
  }
}
