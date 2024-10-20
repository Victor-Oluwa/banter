part of 'note_manager_bloc.dart';

sealed class NoteManagerState extends Equatable {
  const NoteManagerState();

  @override
  List<Object> get props => [];
}

final class NoteManagerInitial extends NoteManagerState {}

class NoteManagerError extends NoteManagerState {
  final String message;

  const NoteManagerError({required this.message});

  @override
  List<String> get props => [message];
}

class SyncNoteError extends NoteManagerState {
  final String message;

  const SyncNoteError({required this.message});

  @override
  List<String> get props => [message];
}

class NoteManagerLoading extends NoteManagerState {}

class NoteCreated extends NoteManagerState {
  final String message;

  const NoteCreated({required this.message});

  @override
  List<String> get props => [message];
}

class NoteUpdated extends NoteManagerState {
  final String message;

  const NoteUpdated({required this.message});

  @override
  List<String> get props => [message];
}

class GottenNotes extends NoteManagerState {
  final List<NoteEntity> notes;

  const GottenNotes({required this.notes});

  @override
  List<List<NoteEntity>> get props => [notes];
}

class NoteSet extends NoteManagerState {
  final List<NoteEntity> notes;

  const NoteSet(this.notes);

  @override
  List<List<NoteEntity>> get props => [notes];
}

class FolderCreated extends NoteManagerState {
  final String message;

  const FolderCreated(this.message);

  @override
  List<String> get props => [message];
}

class NoteDeleted extends NoteManagerState {
  final String message;

  const NoteDeleted(this.message);

  @override
  List<String> get props => [message];
}

class FolderRenamed extends NoteManagerState {
  final String message;

  const FolderRenamed(this.message);

  @override
  List<String> get props => [message];
}

class FolderDeleted extends NoteManagerState {
  final String message;

  const FolderDeleted(this.message);

  @override
  List<String> get props => [message];
}

class FolderSet extends NoteManagerState {
  final String message;

  const FolderSet(this.message);

  @override
  List<String> get props => [message];
}

class GottenFolders extends NoteManagerState {
  final List<FolderEntity> folders;

  const GottenFolders(this.folders);

  @override
  List<List<FolderEntity>> get props => [folders];
}

class NoteAddedToFolder extends NoteManagerState {
  final String message;

  const NoteAddedToFolder({required this.message});

  @override
  List<String> get props => [message];
}

class RemovedNoteFromFolder extends NoteManagerState {
  final String message;

  const RemovedNoteFromFolder(this.message);

  @override
  List<String> get props => [message];
}

class GottenFolderNotes extends NoteManagerState {
  final List<NoteEntity> notes;

  const GottenFolderNotes({required this.notes});

  @override
  List<List<NoteEntity>> get props => [notes];
}

class ReorderedNoteList extends NoteManagerState {
  final List<NoteEntity> notes;

  const ReorderedNoteList({required this.notes});

  @override
  List<List<NoteEntity>> get props => [notes];
}

class ReorderedFolderList extends NoteManagerState {
  final List<FolderEntity> folders;

  const ReorderedFolderList({required this.folders});

  @override
  List<List<FolderEntity>> get props => [folders];
}

class SyncedNotes extends NoteManagerState{
  final List<NoteEntity> notes;

  const SyncedNotes({required this.notes});

  @override
  List<List<NoteEntity>> get props=>[notes];
}

class SyncedFolders extends NoteManagerState{
  final List<FolderEntity> folders;

  const SyncedFolders({required this.folders});

  @override
  List<List<FolderEntity>> get props=>[folders];
}

class SyncCompleted extends NoteManagerState{
  const SyncCompleted();

}
