import 'package:banter/core/usecases/usecases.dart';
import 'package:banter/core/utils/typedef.dart';
import 'package:banter/src/note_manager/domain/entity/note_entity.dart';
import 'package:banter/src/note_manager/domain/repo/note_manager_repo.dart';
import 'package:equatable/equatable.dart';

class AddNoteToFolder
    extends UsecaseWithParams<String, AddNoteToFolderParams> {
  final NoteManagerRepo repo;

  AddNoteToFolder({required this.repo});

  @override
  FutureResult<String> call(AddNoteToFolderParams param) {
   return repo.addNoteToFolder(folderId: param.folderId, note: param.note);
  }
}

class AddNoteToFolderParams extends Equatable {
  final NoteEntity note;
  final String folderId;

  const AddNoteToFolderParams({
    required this.note,
    required this.folderId,
  });

  @override
  List<dynamic> get props => [note, folderId];
}
