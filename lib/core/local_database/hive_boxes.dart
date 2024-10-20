import 'package:banter/src/note_manager/domain/entity/note_entity.dart';
import 'package:hive/hive.dart';

class HiveBoxes {
  static Box<NoteEntity> noteBox = Hive.box('notes');
  static Box<NoteEntity> deletedNotesBox = Hive.box('deletedNotes');
  static Box<FolderEntity> folderBox = Hive.box('folder');

  static Box<String> accessTokenBox = Hive.box('accessToken');
  static Box<String> refreshTokenBox = Hive.box('refreshToken');
  static Box<String> userHashBox = Hive.box('userHash');
  static Box<DateTime> lastSyncTimeBox = Hive.box('lastSyncTime');
}
