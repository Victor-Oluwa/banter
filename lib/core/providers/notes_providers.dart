import 'package:banter/src/note_manager/domain/entity/note_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final noteProvider = StateNotifierProvider<NoteNotifier, List<NoteEntity>>(
    (ref) => NoteNotifier());

class NoteNotifier extends StateNotifier<List<NoteEntity>> {
  NoteNotifier() : super([]);

  List<NoteEntity> setNoteState({required List<NoteEntity> notes}) {
    return state = notes;
  }
}
