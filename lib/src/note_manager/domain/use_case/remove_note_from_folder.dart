import 'package:banter/core/usecases/usecases.dart';
import 'package:banter/core/utils/typedef.dart';
import 'package:banter/src/note_manager/domain/entity/note_entity.dart';
import 'package:banter/src/note_manager/domain/repo/note_manager_repo.dart';
import 'package:equatable/equatable.dart';

class RemoveNoteFromFolder
    extends UsecaseWithParams<String, RemoveNoteFromFolderParams> {
  final NoteManagerRepo repo;

  RemoveNoteFromFolder({required this.repo});

  @override
  FutureResult<String> call(RemoveNoteFromFolderParams param) {
    return repo.removeNoteFromFolder(
      note: param.note,
      folderId: param.folderId,
    );
  }
}

class RemoveNoteFromFolderParams extends Equatable {
  final NoteEntity note;
  final String folderId;

  const RemoveNoteFromFolderParams({
    required this.note,
    required this.folderId,
  });

  @override
  List<dynamic> get props => [note, folderId];
}
