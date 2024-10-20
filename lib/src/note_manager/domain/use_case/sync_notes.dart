import 'package:banter/core/usecases/usecases.dart';
import 'package:banter/core/utils/typedef.dart';
import 'package:banter/src/note_manager/domain/entity/note_entity.dart';
import 'package:banter/src/note_manager/domain/repo/note_manager_repo.dart';
import 'package:equatable/equatable.dart';

class SyncNotes extends UsecaseWithParams<List<NoteEntity>, SyncNotesParams> {
  final NoteManagerRepo _repo;

  SyncNotes(this._repo);

  @override
  FutureResult<List<NoteEntity>> call(SyncNotesParams param) async {
    return await _repo.syncNotes(
        notes: param.notes,
        lastSyncTime: param.lastSyncTime,
        limit: param.limit,
        page: param.page,
        userId: param.userId);
  }
}

class SyncNotesParams extends Equatable {
  final List<NoteEntity>? notes;
  final String userId;
  final DateTime? lastSyncTime;
  final int page;
  final int limit;


  const SyncNotesParams({
    required this.notes,
    required this.userId,
    required this.lastSyncTime,
    required this.page,
    required this.limit,
  });

  @override
  List<dynamic> get props => [notes, userId, lastSyncTime, page, limit];
}
