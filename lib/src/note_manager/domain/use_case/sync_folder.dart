import 'package:banter/core/usecases/usecases.dart';
import 'package:banter/core/utils/typedef.dart';
import 'package:banter/src/note_manager/domain/entity/note_entity.dart';
import 'package:banter/src/note_manager/domain/repo/note_manager_repo.dart';
import 'package:equatable/equatable.dart';

class SyncFolders
    extends UsecaseWithParams<List<FolderEntity>, SyncFoldersParams> {
  final NoteManagerRepo repo;

  SyncFolders(this.repo);

  @override
  FutureResult<List<FolderEntity>> call(SyncFoldersParams param) async {
    return await repo.syncFolders(
      folders: param.folders,
      userId: param.userId,
      lastSyncTime: param.lastSyncTime,
      limit: param.limit,
      page: param.page,
    );
  }
}

class SyncFoldersParams extends Equatable {
  final List<FolderEntity>? folders;
  final String userId;
  final DateTime? lastSyncTime;
  final int page;
  final int limit;


  const SyncFoldersParams({
    required this.folders,
    required this.userId,
    required this.lastSyncTime,
    required this.page,
    required this.limit,
  });

  @override
  List<dynamic> get props => [folders, userId, lastSyncTime, page, limit];
}
