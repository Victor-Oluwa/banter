import 'package:banter/core/usecases/usecases.dart';
import 'package:banter/core/utils/typedef.dart';
import 'package:banter/src/note_manager/domain/repo/note_manager_repo.dart';

class DeleteNote extends UsecaseWithParams<String, String> {
  DeleteNote(this.repo);

  final NoteManagerRepo repo;

  @override
  FutureResult<String> call(String param) {
    return repo.deleteNote(noteId: param);
  }
}
