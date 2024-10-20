import 'dart:convert';
import 'dart:developer';

import 'package:banter/core/error/catchers.dart';
import 'package:banter/core/error/exception.dart';
import 'package:banter/core/providers/folder_provider.dart';
import 'package:banter/core/providers/notes_providers.dart';
import 'package:banter/core/utils/consts.dart';
import 'package:banter/core/utils/typedef.dart';
import 'package:banter/src/note_manager/data/datasource/note_manager_datasource.dart';
import 'package:banter/src/note_manager/data/model/note_model.dart';
import 'package:banter/src/note_manager/domain/entity/note_entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class NoteManagerDatasourceImpl implements NoteManagerDatasource {
  final Box<NoteEntity> noteBox;
  final Box<NoteEntity> deletedNoteBox;
  final Box<FolderEntity> folderBox;
  final Ref ref;
  final Dio dio;

  NoteManagerDatasourceImpl({
    required this.noteBox,
    required this.deletedNoteBox,
    required this.folderBox,
    required this.ref,
    required this.dio,
  });

  @override
  Future<String> createNewNote(
      {required String id,
      required String title,
      required List<StringMap> body,
      required String dateCreated,
      required String lastEdited,
      required String ownerId,
      required List<String> folderIds}) async {
    try {
      final newNote = NoteModel(
        id: id,
        title: title,
        createdAt: dateCreated,
        updatedAt: lastEdited,
        body: body,
        folderIds: folderIds,
        ownerId: ownerId,
        updated: true,
        version: 1,
      );
      await noteBox.put(id, newNote);
      return Future.value('Note created successfully');
    } on NoteManagerException catch (_) {
      rethrow;
    } catch (e) {
      throw NoteManagerException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  @override
  Future<String> updateNote({
    required NoteEntity note,
  }) async {
    try {
      final newNote = NoteModel(
        id: note.id,
        title: note.title,
        createdAt: note.createdAt,
        updatedAt: note.updatedAt,
        body: note.body,
        folderIds: note.folderIds,
        ownerId: note.ownerId,
        updated: true,
        mongoId: note.mongoId,
        version: note.version,
        deleted: note.deleted,
      );
      await noteBox.put(note.id, newNote);
      return Future.value('Note updated successfully');
    } on NoteManagerException catch (_) {
      rethrow;
    } catch (e) {
      throw NoteManagerException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  @override
  Future<List<NoteModel>> getAllNotes() async {
    try {
      final notes = noteBox.values.toList();
      final result = List<NoteEntity>.from(notes)
          .map((note) => NoteModel.fromEntity(note))
          .toList();
      return result;
    } on NoteManagerException catch (_) {
      rethrow;
    } catch (e) {
      throw NoteManagerException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  @override
  Future<List<NoteModel>> setNote({required List<StringMap> notes}) async {
    try {
      final notesResult = List<StringMap>.from(notes)
          .map((e) => NoteEntity.fromMap(e))
          .toList();

      final entity =
          ref.read(noteProvider.notifier).setNoteState(notes: notesResult);

      return entity.map((e) => NoteModel.fromEntity(e)).toList();
    } on NoteManagerException catch (_) {
      rethrow;
    } catch (e) {
      throw NoteManagerException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  @override
  Future<String> createFolder({required FolderEntity folder}) async {
    try {
      await folderBox.put(folder.id, folder);
      return 'New box created';
    } on NoteManagerException catch (_) {
      rethrow;
    } catch (e) {
      throw NoteManagerException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<String> deleteFolder({required String folderId}) async {
    try {
      await folderBox.delete(folderId);
      return 'Box deleted';
    } on NoteManagerException catch (_) {
      rethrow;
    } catch (e) {
      throw NoteManagerException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<String> deleteNote({required String noteId}) async {
    try {
      final note = noteBox.get(noteId);
      final noteMongoId = note?.mongoId;

      if (note != null && noteMongoId != null) {
        if (noteMongoId.length > 7) {
          final deletedNote = NoteEntity(
              id: noteId,
              title: note.title,
              createdAt: note.createdAt,
              updatedAt: note.updatedAt,
              body: note.body,
              folderIds: note.folderIds,
              ownerId: note.ownerId,
              deleted: true,
              mongoId: note.mongoId);

          await deletedNoteBox.put(noteId, deletedNote);
          log('Deleted notes: ${deletedNoteBox.values.length}');
        }
      }

      await noteBox.delete(noteId);
      return 'Deleted note:';
    } on NoteManagerException catch (_) {
      rethrow;
    } catch (e) {
      throw NoteManagerException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<List<FolderModel>> getAllFolders() async {
    try {
      final folders = folderBox.values.toList();
      return folders.map((e) => FolderModel.fromEntity(e)).toList();
    } on NoteManagerException catch (_) {
      rethrow;
    } catch (e) {
      throw NoteManagerException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<String> renameFolder({required FolderEntity folder}) async {
    try {
      await folderBox.put(folder.id, folder);
      return 'Folder renamed';
    } on NoteManagerException catch (_) {
      rethrow;
    } catch (e) {
      throw NoteManagerException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<String> setFolder({required List<FolderEntity> folders}) async {
    try {
      ref.read(folderProvider.notifier).setFolder(folders);
      return 'Product set';
    } on NoteManagerException catch (_) {
      rethrow;
    } catch (e) {
      throw NoteManagerException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<String> addNoteToFolder(
      {required String folderId, required NoteEntity note}) async {
    try {
      List<String> folderIds = note.folderIds;
      if (folderIds.contains(folderId)) {
        throw const NoteManagerException(
          message: 'Note already added in box',
          statusCode: 500,
        );
      }

      folderIds.add(folderId);

      final newNote = NoteEntity(
        id: note.id,
        title: note.title,
        createdAt: note.createdAt,
        updatedAt: note.updatedAt,
        body: note.body,
        folderIds: folderIds,
        ownerId: note.ownerId,
      );

      await noteBox.put(note.id, newNote);

      return 'Note added to box';
    } on NoteManagerException catch (_) {
      rethrow;
    } catch (e) {
      throw NoteManagerException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<String> removeNoteFromFolder(
      {required NoteEntity note, required String folderId}) async {
    try {
      note.folderIds.removeWhere((folder) => folder == folderId);

      await noteBox.put(note.id, note);
      return 'Removed note from folder';
    } on NoteManagerException catch (_) {
      rethrow;
    } catch (e) {
      throw NoteManagerException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<List<NoteModel>> getFolderNotes(
      {required List<NoteEntity> notes, required String folderId}) async {
    try {
      return notes
          .where((note) => note.folderIds.contains(folderId))
          .toList()
          .map((noteEntity) => NoteModel.fromEntity(noteEntity))
          .toList();
    } on NoteManagerException catch (_) {
      rethrow;
    } catch (e) {
      throw NoteManagerException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<List<FolderModel>> reorderFolderList(
      {required List<FolderEntity> folders}) async {
    try {
      folders.sort((a, b) {
        DateTime dateA = DateTime.parse(a.updatedAt);
        DateTime dateB = DateTime.parse(b.updatedAt);

        return dateB.compareTo(dateA);
      });

      return folders.map((e) => FolderModel.fromEntity(e)).toList();
    } on NoteManagerException catch (_) {
      rethrow;
    } catch (e) {
      throw NoteManagerException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<List<NoteModel>> reorderNoteList(
      {required List<NoteEntity> notes}) async {
    try {
      notes.sort((a, b) {
        DateTime dateA = DateTime.parse(a.updatedAt);
        DateTime dateB = DateTime.parse(b.updatedAt);

        return dateB.compareTo(dateA);
      });

      final result = notes.map((e) => NoteModel.fromEntity(e)).toList();
      return result;
    } on NoteManagerException catch (_) {
      rethrow;
    } catch (e) {
      throw NoteManagerException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<List<FolderEntity>> syncFolders({
    required List<FolderEntity>? folders,
    required String userId,
    required DateTime? lastSyncTime,
    required int page,
    required int limit,
  }) async {
    try {
      final List<StringMap> jsonFolders =
          folders?.map((e) => e.toMap()).toList() ?? [];

      final data = {
        'page': page,
        'limit': limit,
        'userId': userId,
        'folders': jsonFolders,
        'lastSyncTime': lastSyncTime?.toIso8601String()
      };

      final response = await dio.post(
        '$kBaseUrl$kSyncFoldersEndpoint',
        options: Options(headers: kHttpHeader),
        data: data,
      );

      final validateStatusCode = ErrorCatcher.checkStatusCode(
        response: response,
        exceptionType: NoteManagerException,
      );

      return validateStatusCode.fold((l) => throw l, (r) {
        return List<StringMap>.from(
                jsonDecode(response.data) as List<StringMap>)
            .map((e) => FolderEntity.fromMap(e))
            .toList();
      });
    } on NoteManagerException catch (_) {
      rethrow;
    } on DioException catch (e) {
      final responseData = e.response?.data;
      if (responseData != null) {
        throw NoteManagerException(message: responseData[''], statusCode: 500);
      } else {
        throw NoteManagerException(
            message: responseData['message'] != {}
                ? responseData['message'] ?? 'An error occurred'
                : 'An error occurred',
            statusCode: 500);
      }
    } catch (e) {
      throw NoteManagerException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<List<NoteEntity>> syncNotes({
    required List<NoteEntity>? notes,
    required String userId,
    required DateTime? lastSyncTime,
    required int page,
    required int limit,
  }) async {
    try {
      final List<StringMap> jsonNotes =
          notes?.map((e) => e.toMap()).toList() ?? [];

      final data = {
        'page': page,
        'limit': limit,
        'userId': userId,
        'notes': jsonNotes,
        'lastSyncTime': lastSyncTime?.toIso8601String()
      };

      final response = await dio.post(
        '$kBaseUrl$kSyncNotesEndpoint',
        options: Options(headers: kHttpHeader),
        data: data,
      );

      final validateStatusCode = ErrorCatcher.checkStatusCode(
        response: response,
        exceptionType: NoteManagerException,
      );

      return validateStatusCode.fold((l) => throw l, (r) {
        return List<StringMap>.from(response.data['notes']).map((e) {
          final note = NoteEntity.fromMap(e);
          note.updated == false;
          return note;
        }).toList();
      });
    } on NoteManagerException catch (_) {
      rethrow;
    } on DioException catch (e) {
      throw ErrorCatcher.catchDioError(
          dioException: e, exceptionType: NoteManagerException);
    } catch (e) {
      throw ErrorCatcher.catchGeneralError(
          object: e, exceptionType: NoteManagerException);
    }
  }

}

const kSyncFoldersEndpoint = '/sync-folders';
const kSyncNotesEndpoint = '/sync-notes';
