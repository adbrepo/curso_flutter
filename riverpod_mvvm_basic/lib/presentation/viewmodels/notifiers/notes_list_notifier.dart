import 'dart:async';

import 'package:collection/collection.dart';
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
      screenState: BaseScreenState.loading,
      error: null,
    );
    await refresh();
  }

  Future<void> refresh() async {
    try {
      final notes = await notesRepository.getAllNotes();
      state = state.copyWith(
        screenState: BaseScreenState.idle,
        notes: notes.sortedBy((n) => n.createdAt),
      );
    } catch (error) {
      state = state.copyWith(
        screenState: BaseScreenState.error,
        error: error.toString(),
      );
    }
  }
}
