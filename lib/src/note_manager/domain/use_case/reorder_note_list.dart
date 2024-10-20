import 'dart:developer';

import 'package:banter/core/usecases/usecases.dart';
import 'package:banter/core/utils/typedef.dart';
import 'package:banter/src/note_manager/domain/entity/note_entity.dart';
import 'package:banter/src/note_manager/domain/repo/note_manager_repo.dart';
import 'package:equatable/equatable.dart';

class ReorderNoteList
    extends UsecaseWithParams<List<NoteEntity>, List<NoteEntity>> {
  final NoteManagerRepo repo;

  ReorderNoteList({required this.repo});

  @override
  FutureResult<List<NoteEntity>> call(List<NoteEntity> param) async {
    return await repo.reorderNoteList(notes: param);
  }
}
