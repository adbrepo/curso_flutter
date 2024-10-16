import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/providers.dart';
import '../../../domain/notes_repository.dart';
import '../../utils/base_screen_state.dart';
import '../states/notes_list_state.dart';

class NotesListNotifier extends Notifier<NotesListState> {
  late final NotesRepository notesRepository =
      ref.read(notesRepositoryProvider);

  @override
  NotesListState build() {
    return const NotesListState();
  }

  Future<void> fetchNotes() async {
    state = state.copyWith(
      screenState: const BaseScreenState.loading(),
    );
    await refresh();
  }

  Future<void> refresh() async {
    try {
      final notes = await notesRepository.getAllNotes();
      state = state.copyWith(
        screenState: const BaseScreenState.idle(),
        notes: notes,
      );
    } catch (error) {
      state = state.copyWith(
        screenState: BaseScreenState.error(error.toString()),
      );
    }
  }

  Future<void> delete(int id) async {
    final newNotes = state.notes.where((note) => note.id != id).toList();

    state = state.copyWith(screenState: const BaseScreenState.loading());

    try {
      await notesRepository.deleteNoteById(id);
      state = state.copyWith(
        screenState: const BaseScreenState.idle(),
        notes: newNotes,
      );
    } catch (error) {
      state = state.copyWith(
        screenState: BaseScreenState.error(error.toString()),
      );
    }
  }
}
