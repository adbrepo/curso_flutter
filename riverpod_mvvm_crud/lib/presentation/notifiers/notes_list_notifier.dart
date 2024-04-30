import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../data/notes_repository.dart';
import '../../entities/note.dart';

class NotesListNotifier extends AsyncNotifier<List<Note>> {
  late final NotesRepository notesRepository =
      ref.read(notesRepositoryProvider);

  @override
  FutureOr<List<Note>> build() async {
    return notesRepository.getAllNotes();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => notesRepository.getAllNotes());
  }

  Future<void> delete(int id) async {
    final newNotes =
        state.asData!.value.where((note) => note.id != id).toList();

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await notesRepository.deleteNoteById(id);
      return newNotes;
    });
  }
}
