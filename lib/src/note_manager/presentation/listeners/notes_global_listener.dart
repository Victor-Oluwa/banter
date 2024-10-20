import 'dart:developer';

import 'package:banter/core/local_database/hive_boxes.dart';
import 'package:banter/core/providers/state_providers/state_providers.dart';
import 'package:banter/core/providers/user_provider.dart';
import 'package:banter/core/utils/show_dialog.dart';
import 'package:banter/src/note_manager/domain/entity/note_entity.dart';
import 'package:banter/src/note_manager/presentation/bloc/note_manager_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotesGlobalListener {
  void noteBlocListener({
    required BuildContext context,
    required NoteManagerState state,
    required WidgetRef ref,
  }) {
    // Handling of different state transitions
    if (state is NoteManagerError) {
      log('Note Manager error: ${state.message}');
      _showSnackbar(title: 'Error', message: 'An error occurred');
    } else if (state is SyncNoteError) {
      ref.invalidate(isSyncingProvider);
      ref.invalidate(syncPage);
      log('Syncing failed because: ${state.message}');
      _showSnackbar(
        title: 'Syncing Failed',
        message: 'Syncing failed because: ${state.message}',
      );
    } else if (state is GottenFolderNotes) {
      _handleGottenFolderNoteState(context: context, state: state);
    } else if (state is ReorderedNoteList) {
      _handleReorderedNoteListState(context: context, state: state);
    } else if (state is NoteDeleted) {
      _handleNoteDeletedState(context);
    } else if (state is FolderCreated) {
      _handleFolderCreatedState(context);
    } else if (state is GottenFolders) {
      _handleGottenFoldersState(context: context, state: state);
    } else if (state is ReorderedFolderList) {
      _handleReorderedFolderListState(context: context, state: state);
    } else if (state is NoteAddedToFolder) {
      _handleNoteAddedToFolderState(context);
    } else if (state is RemovedNoteFromFolder) {
      _handleNoteDeletedFromFolderState(context);
    } else if (state is SyncedNotes) {
      _handleSyncedNoteState(context: context, state: state, ref: ref);
    } else if (state is NoteSet) {
      _handleNoteSetState(state);
    }
  }

  void _handleGottenFolderNoteState(
      {required GottenFolderNotes state, required BuildContext context}) {
    context
        .read<NoteManagerBloc>()
        .add(ReorderNoteListEvent(notes: state.notes));
  }

  void _handleReorderedNoteListState(
      {required BuildContext context, required ReorderedNoteList state}) {
    final notes = state.notes.map((e) => e.toMap()).toList();
    context.read<NoteManagerBloc>().add(SetNoteEvent(notes: notes));
  }

  void _handleNoteDeletedState(BuildContext context) {
    _showSnackbar(title: 'Done', message: 'Note deleted');
    context.read<NoteManagerBloc>().add(const GetAllNotesEvent());
  }

  void _handleFolderCreatedState(BuildContext context) {
    context.read<NoteManagerBloc>().add(GetAllFolderEvent());
  }

  void _handleGottenFoldersState(
      {required GottenFolders state, required BuildContext context}) {
    context.read<NoteManagerBloc>().add(
          ReorderFolderListEvent(folders: state.folders),
        );
  }

  void _handleReorderedFolderListState(
      {required BuildContext context, required ReorderedFolderList state}) {
    context.read<NoteManagerBloc>().add(
          SetFolderEvent(state.folders),
        );
  }

  void _handleNoteAddedToFolderState(BuildContext context) {
    _showSnackbar(title: 'Done', message: 'Added note to box');
    context.read<NoteManagerBloc>().add(const GetAllNotesEvent());
  }

  void _handleNoteDeletedFromFolderState(BuildContext context) {
    _showSnackbar(title: 'Done', message: 'Removed note from box');
    context.read<NoteManagerBloc>().add(const GetAllNotesEvent());
  }

  void _handleSyncedNoteState(
      {required SyncedNotes state,
      required WidgetRef ref,
      required BuildContext context}) {
    final notesBox = HiveBoxes.noteBox;
    final notes =
        notesBox.values.where((note) => note.updated == true).toList();

    log('${state.notes.length} notes returned!');
    log('Is note syncing?: ${ref.read(isSyncingProvider)}');
    log('Note page: ${ref.read(syncPage)}');

    if (state.notes.isEmpty) {
      log('Note should be empty: ${state.notes.length}');
      ref.invalidate(isSyncingProvider);
      ref.invalidate(syncPage);
      HiveBoxes.deletedNotesBox.clear();
      HiveBoxes.lastSyncTimeBox.put('lastSyncTime', DateTime.now());

      context.read<NoteManagerBloc>().add(const ConfirmSyncCompletionEvent());

      log('Sync Complete!');
      _showSnackbar(title: 'Success', message: 'Sync Completed');
      return;
    }

    final Map<dynamic, NoteEntity> noteBatch = {
      for (var note in state.notes) note.id: note,
    };
    notesBox.putAll(noteBatch);

    context
        .read<NoteManagerBloc>()
        .add(ReorderNoteListEvent(notes: notesBox.values.toList()));
    final lastSyncTime = HiveBoxes.lastSyncTimeBox.get('lastSyncTime');

    context.read<NoteManagerBloc>().add(SyncNotesEvent(
        notes: notes,
        userId: ref.read(userProvider).id,
        lastSyncTime: lastSyncTime,
        page: ref.watch(syncPage),
        limit: 30));
    ref.watch(syncPage.notifier).state += 1;
  }

  _handleNoteSetState(NoteSet state) {
    log('${state.notes.length} note set');
  }

  void _showSnackbar({required String title, required String message}) {
    BanterDialog.show(title: title, message: message);
  }
}
