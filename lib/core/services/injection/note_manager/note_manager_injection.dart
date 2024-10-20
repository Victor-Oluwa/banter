import 'package:banter/core/local_database/hive_boxes.dart';
import 'package:banter/src/note_manager/data/datasource/note_manager_datasource.dart';
import 'package:banter/src/note_manager/data/datasource/note_manager_datasource_impl.dart';
import 'package:banter/src/note_manager/data/repo/note_manager_repo_impl.dart';
import 'package:banter/src/note_manager/domain/repo/note_manager_repo.dart';
import 'package:banter/src/note_manager/domain/use_case/add_note_to_folder.dart';
import 'package:banter/src/note_manager/domain/use_case/create_folder.dart';
import 'package:banter/src/note_manager/domain/use_case/create_new_note.dart';
import 'package:banter/src/note_manager/domain/use_case/delete_folder.dart';
import 'package:banter/src/note_manager/domain/use_case/delete_note.dart';
import 'package:banter/src/note_manager/domain/use_case/getAllNotes.dart';
import 'package:banter/src/note_manager/domain/use_case/get_all_folders.dart';
import 'package:banter/src/note_manager/domain/use_case/get_folder_notes.dart';
import 'package:banter/src/note_manager/domain/use_case/remove_note_from_folder.dart';
import 'package:banter/src/note_manager/domain/use_case/rename_folder.dart';
import 'package:banter/src/note_manager/domain/use_case/reorder_folder_list.dart';
import 'package:banter/src/note_manager/domain/use_case/reorder_note_list.dart';
import 'package:banter/src/note_manager/domain/use_case/setNotes.dart';
import 'package:banter/src/note_manager/domain/use_case/set_folder.dart';
import 'package:banter/src/note_manager/domain/use_case/sync_folder.dart';
import 'package:banter/src/note_manager/domain/use_case/sync_notes.dart';
import 'package:banter/src/note_manager/domain/use_case/update_note.dart';
import 'package:banter/src/note_manager/presentation/bloc/note_manager_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final noteManagerBlocProvider = Provider.autoDispose<NoteManagerBloc>(
      (ref) => NoteManagerBloc(
    createNewNote: ref.read(createNewNoteProvider),
    updateNote: ref.read(updateNoteProvider),
    getAllNotes: ref.read(getAllNotesProvider),
    setNote: ref.read(setNoteProvider),
    deleteNote: ref.read(deleteNoteProvider),
    createFolder: ref.read(createFolderProvider),
    renameFolder: ref.read(renameFolderProvider),
    setFolder: ref.read(setFolderProvider),
    deleteFolder: ref.read(deleteFolderProvider),
    getAllFolders: ref.read(getAllFolderProvider),
    addNoteToFolder: ref.read(addNoteToFolderProvider),
    removeNoteFromFolder: ref.read(removeNoteFromFolderProvider),
    getFolderNotes: ref.read(getFolderNotesListProvider),
    reorderNoteList: ref.read(reorderNoteListProvider),
    reorderFolderList: ref.read(reorderFolderListProvider),
    syncFolders: ref.read(syncFoldersProvider),
    syncNotes: ref.read(syncNotesProvider),
  ),
);
final noteManagerDatasourceProvider =
Provider.autoDispose<NoteManagerDatasource>(
      (ref) => NoteManagerDatasourceImpl(
    noteBox: HiveBoxes.noteBox,
    deletedNoteBox: HiveBoxes.deletedNotesBox,
    folderBox: HiveBoxes.folderBox,
    ref: ref, dio: Dio(),
  ),
);
final noteManagerRepoProvider = Provider.autoDispose<NoteManagerRepo>(
      (ref) => NoteManagerRepoImpl(
    datasource: ref.read(noteManagerDatasourceProvider),
  ),
);

final createNewNoteProvider = Provider.autoDispose<CreateNewNote>(
      (ref) => CreateNewNote(
    repo: ref.read(noteManagerRepoProvider),
  ),
);

final updateNoteProvider = Provider.autoDispose<UpdateNote>(
      (ref) => UpdateNote(
    repo: ref.read(noteManagerRepoProvider),
  ),
);

final getAllNotesProvider = Provider.autoDispose<GetAllNotes>(
      (ref) => GetAllNotes(
    repo: ref.read(
      noteManagerRepoProvider,
    ),
  ),
);

final setNoteProvider = Provider.autoDispose<SetNote>(
      (ref) => SetNote(
    repo: ref.read(noteManagerRepoProvider),
  ),
);

final deleteNoteProvider = Provider.autoDispose<DeleteNote>(
      (ref) => DeleteNote(
    ref.read(noteManagerRepoProvider),
  ),
);
final createFolderProvider = Provider.autoDispose<CreateFolder>(
      (ref) => CreateFolder(
    ref.read(noteManagerRepoProvider),
  ),
);

final renameFolderProvider = Provider.autoDispose<RenameFolder>(
      (ref) => RenameFolder(
    ref.read(noteManagerRepoProvider),
  ),
);

final setFolderProvider = Provider.autoDispose<SetFolder>(
      (ref) => SetFolder(
    ref.read(noteManagerRepoProvider),
  ),
);

final deleteFolderProvider = Provider.autoDispose<DeleteFolder>(
      (ref) => DeleteFolder(
    ref.read(noteManagerRepoProvider),
  ),
);

final getAllFolderProvider = Provider.autoDispose<GetAllFolders>(
      (ref) => GetAllFolders(
    ref.read(noteManagerRepoProvider),
  ),
);

final addNoteToFolderProvider = Provider.autoDispose<AddNoteToFolder>(
      (ref) => AddNoteToFolder(
    repo: ref.read(noteManagerRepoProvider),
  ),
);

final removeNoteFromFolderProvider = Provider.autoDispose<RemoveNoteFromFolder>(
      (ref) => RemoveNoteFromFolder(
    repo: ref.read(noteManagerRepoProvider),
  ),
);

final getFolderNotesListProvider = Provider.autoDispose<GetFolderNotes>(
      (ref) => GetFolderNotes(
    repo: ref.read(
      noteManagerRepoProvider,
    ),
  ),
);

final reorderNoteListProvider = Provider.autoDispose<ReorderNoteList>(
      (ref) => ReorderNoteList(
    repo: ref.read(noteManagerRepoProvider),
  ),
);

final reorderFolderListProvider = Provider.autoDispose<ReorderFolderList>(
      (ref) => ReorderFolderList(
    repo: ref.read(noteManagerRepoProvider),
  ),
);

final syncFoldersProvider = Provider.autoDispose<SyncFolders>(
      (ref) => SyncFolders(
    ref.read(noteManagerRepoProvider),
  ),
);
final syncNotesProvider = Provider.autoDispose<SyncNotes>(
      (ref) => SyncNotes(
    ref.read(noteManagerRepoProvider),
  ),
);
