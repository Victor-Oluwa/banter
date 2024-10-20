import 'package:banter/core/usecases/usecases.dart';
import 'package:banter/core/utils/typedef.dart';
import 'package:banter/src/note_manager/domain/entity/note_entity.dart';
import 'package:banter/src/note_manager/domain/repo/note_manager_repo.dart';

class RenameFolder extends UsecaseWithParams<String, FolderEntity>{
  RenameFolder(this.repo);
  final NoteManagerRepo repo;

  @override
  FutureResult<String> call(FolderEntity param) {
  return repo.renameFolder(folder: param);
  }
}