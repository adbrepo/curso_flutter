import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/providers.dart';
import '../../../domain/note.dart';
import '../../../domain/notes_repository.dart';
import '../../utils/base_screen_state.dart';

part '../states/notes_list_state.dart';

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
      final sortedNotes = sortNotes(notes, state.sortOrder);
      
      state = state.copyWith(
        screenState: BaseScreenState.idle,
        notes: sortedNotes,
      );
    } catch (error) {
      state = state.copyWith(
        screenState: BaseScreenState.error,
        error: error.toString(),
      );
    }
  }

  void toggleSortOrder() {
    final newSortOrder = state.sortOrder == SortOrder.ascending
        ? SortOrder.descending
        : SortOrder.ascending;

    final sortedNotes = sortNotes(state.notes, newSortOrder);

    state = state.copyWith(
      sortOrder: newSortOrder,
      notes: sortedNotes,
    );
  }

  @visibleForTesting
  List<Note> sortNotes(List<Note> notes, SortOrder sortOrder) {
    final sortedNotes = List<Note>.from(notes);
    sortedNotes.sort((a, b) {
      final dateA = a.createdAt;
      final dateB = b.createdAt;
      return sortOrder == SortOrder.ascending
          ? dateA.compareTo(dateB)
          : dateB.compareTo(dateA);
    });
    return sortedNotes;
  }
}
