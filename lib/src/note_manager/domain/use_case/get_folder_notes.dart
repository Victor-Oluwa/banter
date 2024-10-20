import 'package:banter/core/usecases/usecases.dart';
import 'package:banter/core/utils/typedef.dart';
import 'package:banter/src/note_manager/domain/entity/note_entity.dart';
import 'package:banter/src/note_manager/domain/repo/note_manager_repo.dart';
import 'package:equatable/equatable.dart';

class GetFolderNotes
    extends UsecaseWithParams<List<NoteEntity>, GetFolderNotesParams> {
  final NoteManagerRepo repo;

  GetFolderNotes({required this.repo});

  @override
  FutureResult<List<NoteEntity>> call(GetFolderNotesParams param) async {
    return await repo.getFolderNotes(
      notes: param.notes,
      folderId: param.folderId,
    );
  }
}

class GetFolderNotesParams extends Equatable {
  final List<NoteEntity> notes;
  final String folderId;

  const GetFolderNotesParams({
    required this.notes,
    required this.folderId,
  });

  @override
  List<dynamic> get props => [notes, folderId];
}
