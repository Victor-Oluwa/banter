import 'package:banter/core/usecases/usecases.dart';
import 'package:banter/core/utils/typedef.dart';
import 'package:banter/src/note_manager/domain/entity/note_entity.dart';
import 'package:banter/src/note_manager/domain/repo/note_manager_repo.dart';

class GetAllNotes extends UseCaseWithoutParams<List<NoteEntity>>{
  final NoteManagerRepo repo;

  GetAllNotes({required this.repo});

  @override
  FutureResult<List<NoteEntity>> call() {
   return repo.getAllNotes();
  }
}