import 'package:banter/core/usecases/usecases.dart';
import 'package:banter/core/utils/typedef.dart';
import 'package:banter/src/note_manager/domain/entity/note_entity.dart';
import 'package:banter/src/note_manager/domain/repo/note_manager_repo.dart';

class GetAllFolders extends UseCaseWithoutParams<List<FolderEntity>> {
  GetAllFolders(this.repo);

  final NoteManagerRepo repo;

  @override
  FutureResult<List<FolderEntity>> call() {
    return repo.getAllFolders();
  }
}
