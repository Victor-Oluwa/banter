import 'package:banter/core/usecases/usecases.dart';
import 'package:banter/core/utils/typedef.dart';
import 'package:banter/src/note_manager/domain/entity/note_entity.dart';
import 'package:banter/src/note_manager/domain/repo/note_manager_repo.dart';
import 'package:equatable/equatable.dart';

class SetNote extends UsecaseWithParams<List<NoteEntity>, List<StringMap>> {
  final NoteManagerRepo repo;

  SetNote({required this.repo});

  @override
  FutureResult<List<NoteEntity>> call(List<StringMap> param) {
   return repo.setNote(
      notes: param,
    );
  }
}
