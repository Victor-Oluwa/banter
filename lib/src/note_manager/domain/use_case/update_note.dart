import 'package:banter/core/usecases/usecases.dart';
import 'package:banter/core/utils/typedef.dart';
import 'package:banter/src/note_manager/domain/entity/note_entity.dart';
import 'package:banter/src/note_manager/domain/repo/note_manager_repo.dart';
import 'package:equatable/equatable.dart';

class UpdateNote extends UsecaseWithParams<String, NoteEntity> {
  final NoteManagerRepo repo;

  UpdateNote({required this.repo});

  @override
  FutureResult<String> call(NoteEntity param) {
    return repo.updateNote(
     note: param,
    );
  }
}

