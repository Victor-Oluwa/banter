import 'package:banter/src/note_manager/domain/entity/note_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final folderProvider =
    StateNotifierProvider<FolderNotifier, List<FolderEntity>>(
        (ref) => FolderNotifier());

class FolderNotifier extends StateNotifier<List<FolderEntity>> {
  FolderNotifier() : super([]);

  void setFolder(List<FolderEntity> folder){
    state = folder;
  }
}
