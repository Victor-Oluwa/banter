import 'package:banter/core/utils/typedef.dart';
import 'package:banter/src/note_manager/data/model/note_model.dart';
import 'package:banter/src/note_manager/domain/entity/note_entity.dart';

abstract class NoteManagerDatasource {
  Future<String> createNewNote({
    required String id,
    required String title,
    required List<StringMap> body,
    required String dateCreated,
    required String lastEdited,
    required String ownerId,
    required List<String> folderIds,
  });

  Future<String> updateNote({
    required NoteEntity note,
  });

  Future<List<NoteModel>> getAllNotes();

  Future<List<NoteModel>> setNote({required List<StringMap> notes});

  Future<List<FolderEntity>> getAllFolders();

  Future<String> deleteNote({required String noteId});

  Future<String> createFolder({required FolderEntity folder});

  Future<String> renameFolder({required FolderEntity folder});

  Future<String> deleteFolder({required String folderId});

  Future<String> setFolder({required List<FolderEntity> folders});

  Future<String> addNoteToFolder({
    required String folderId,
    required NoteEntity note,
  });

  Future<String> removeNoteFromFolder({
    required NoteEntity note,
    required String folderId,
  });

  Future<List<NoteEntity>> getFolderNotes({
    required List<NoteEntity> notes,
    required String folderId,
  });

  Future<List<NoteEntity>> reorderNoteList({required List<NoteEntity> notes});

  Future<List<FolderEntity>> reorderFolderList(
      {required List<FolderEntity> folders});

  Future<List<NoteEntity>> syncNotes({
    required List<NoteEntity>? notes,
    required String userId,
    required DateTime? lastSyncTime,
    required int page,
    required int limit,
  });

  Future<List<FolderEntity>> syncFolders({
    required List<FolderEntity>? folders,
    required String userId,
    required DateTime? lastSyncTime,
    required int page,
    required int limit,
  });

}
