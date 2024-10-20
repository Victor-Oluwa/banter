import 'package:banter/core/error/exception.dart';
import 'package:banter/core/error/failure.dart';
import 'package:banter/core/utils/typedef.dart';
import 'package:banter/src/note_manager/data/datasource/note_manager_datasource.dart';
import 'package:banter/src/note_manager/domain/entity/note_entity.dart';
import 'package:banter/src/note_manager/domain/repo/note_manager_repo.dart';
import 'package:fpdart/fpdart.dart';

class NoteManagerRepoImpl implements NoteManagerRepo {
  final NoteManagerDatasource datasource;

  NoteManagerRepoImpl({required this.datasource});

  @override
  FutureResult<String> createNewNote({
    required String id,
    required String title,
    required List<StringMap> body,
    required String dateCreated,
    required String lastEdited,
    required String ownerId,
    required List<String> folderIds,
  }) async {
    try {
      final result = await datasource.createNewNote(
        id: id,
        title: title,
        body: body,
        dateCreated: dateCreated,
        lastEdited: lastEdited,
        ownerId: ownerId,
        folderIds: folderIds,
      );
      return Right(result);
    } on NoteManagerException catch (e) {
      return Left(NoteManagerFailure.fromException(e));
    }
  }

  @override
  FutureResult<String> updateNote({
    required NoteEntity note,
  }) async {
    try {
      final result = await datasource.updateNote(
        note: note,
      );
      return Right(result);
    } on NoteManagerException catch (e) {
      return Left(NoteManagerFailure.fromException(e));
    }
  }

  @override
  FutureResult<List<NoteEntity>> getAllNotes() async {
    try {
      final result = await datasource.getAllNotes();
      return Right(result);
    } on NoteManagerException catch (e) {
      return Left(NoteManagerFailure.fromException(e));
    }
  }

  @override
  FutureResult<List<NoteEntity>> setNote(
      {required List<StringMap> notes}) async {
    try {
      final result = await datasource.setNote(notes: notes);
      return Right(result);
    } on NoteManagerException catch (e) {
      return Left(NoteManagerFailure.fromException(e));
    }
  }

  @override
  FutureResult<String> createFolder({required FolderEntity folder}) async {
    try {
      final result = await datasource.createFolder(folder: folder);
      return Right(result);
    } on NoteManagerException catch (e) {
      return Left(NoteManagerFailure.fromException(e));
    }
  }

  @override
  FutureResult<String> deleteFolder({required String folderId}) async {
    try {
      final result = await datasource.deleteFolder(folderId: folderId);
      return Right(result);
    } on NoteManagerException catch (e) {
      return Left(NoteManagerFailure.fromException(e));
    }
  }

  @override
  FutureResult<String> deleteNote({required String noteId}) async {
    try {
      final result = await datasource.deleteNote(noteId: noteId);
      return Right(result);
    } on NoteManagerException catch (e) {
      return Left(NoteManagerFailure.fromException(e));
    }
  }

  @override
  FutureResult<List<FolderEntity>> getAllFolders() async {
    try {
      final result = await datasource.getAllFolders();
      return Right(result);
    } on NoteManagerException catch (e) {
      return Left(NoteManagerFailure.fromException(e));
    }
  }

  @override
  FutureResult<String> renameFolder({required FolderEntity folder}) async {
    try {
      final result = await datasource.renameFolder(folder: folder);
      return Right(result);
    } on NoteManagerException catch (e) {
      return Left(NoteManagerFailure.fromException(e));
    }
  }

  @override
  FutureResult<String> setFolder({required List<FolderEntity> folders}) async {
    try {
      final result = await datasource.setFolder(folders: folders);
      return Right(result);
    } on NoteManagerException catch (e) {
      return Left(NoteManagerFailure.fromException(e));
    }
  }

  @override
  FutureResult<String> addNoteToFolder(
      {required String folderId, required NoteEntity note}) async {
    try {
      final result =
          await datasource.addNoteToFolder(folderId: folderId, note: note);
      return Right(result);
    } on NoteManagerException catch (e) {
      return Left(NoteManagerFailure.fromException(e));
    }
  }

  @override
  FutureResult<String> removeNoteFromFolder(
      {required NoteEntity note, required String folderId}) async {
    try {
      final result =
          await datasource.removeNoteFromFolder(note: note, folderId: folderId);
      return Right(result);
    } on NoteManagerException catch (e) {
      return Left(NoteManagerFailure.fromException(e));
    }
  }

  @override
  FutureResult<List<NoteEntity>> getFolderNotes(
      {required List<NoteEntity> notes, required String folderId}) async {
    try {
      final result =
          await datasource.getFolderNotes(notes: notes, folderId: folderId);
      return Right(result);
    } on NoteManagerException catch (e) {
      return Left(NoteManagerFailure.fromException(e));
    }
  }

  @override
  FutureResult<List<FolderEntity>> reorderFolderList(
      {required List<FolderEntity> folders}) async {
    try {
      final result = await datasource.reorderFolderList(folders: folders);
      return Right(result);
    } on NoteManagerException catch (e) {
      return Left(NoteManagerFailure.fromException(e));
    }
  }

  @override
  FutureResult<List<NoteEntity>> reorderNoteList(
      {required List<NoteEntity> notes}) async {
    try {
      final result = await datasource.reorderNoteList(notes: notes);
      return Right(result);
    } on NoteManagerException catch (e) {
      return Left(NoteManagerFailure.fromException(e));
    }
  }

  @override
  FutureResult<List<FolderEntity>> syncFolders({
    required List<FolderEntity>? folders,
    required String userId,
    required DateTime? lastSyncTime,
    required int page,
    required int limit,
  }) async {
    try {
      final result = await datasource.syncFolders(
        folders: folders,
        lastSyncTime: lastSyncTime,
        userId: userId,
        page: page,
        limit: limit,
      );
      return Right(result);
    } on NoteManagerException catch (e) {
      return Left(NoteManagerFailure.fromException(e));
    }
  }

  @override
  FutureResult<List<NoteEntity>> syncNotes({
    required List<NoteEntity>? notes,
    required String userId,
    required DateTime? lastSyncTime,
    required int page,
    required int limit,
  }) async {
    try {
      final result = await datasource.syncNotes(
        notes: notes,
        userId: userId,
        lastSyncTime: lastSyncTime,
        page: page,
        limit: limit,
      );
      return Right(result);
    } on NoteManagerException catch (e) {
      return Left(NoteManagerFailure.fromException(e));
    }
  }
}
