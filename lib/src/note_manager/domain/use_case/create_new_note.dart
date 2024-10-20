import 'package:banter/core/usecases/usecases.dart';
import 'package:banter/core/utils/typedef.dart';
import 'package:banter/src/note_manager/domain/repo/note_manager_repo.dart';
import 'package:equatable/equatable.dart';

class CreateNewNote extends UsecaseWithParams<String, CreateNewNoteParam> {
  final NoteManagerRepo repo;

  CreateNewNote({required this.repo});

  @override
  FutureResult<String> call(CreateNewNoteParam param) {
    return repo.createNewNote(
      id: param.id,
      title: param.title,
      body: param.body,
      dateCreated: param.dateCreated,
      lastEdited: param.lastEdited,
      ownerId: param.ownerId,
      folderIds: param.folderIds,);
  }
}

class CreateNewNoteParam extends Equatable {
  final String id;
  final String title;
  final List<StringMap> body;
  final String dateCreated;
  final String lastEdited;
  final String ownerId;
  final List<String> folderIds;

  const CreateNewNoteParam({
    required this.id,
    required this.title,
    required this.body,
    required this.dateCreated,
    required this.lastEdited,
    required this.ownerId,
    required this.folderIds,
  });

  const CreateNewNoteParam.empty() :this(
    id: '',
    title: '',
    ownerId: '',
    body: const[],
    dateCreated: '',
    folderIds: const[],
    lastEdited: '',
  );

  @override
  List<dynamic> get props =>
      [
        id,
        title,
        body,
        dateCreated,
        lastEdited,
        ownerId,
        folderIds,
      ];
}
