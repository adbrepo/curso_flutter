import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../data/notes_repository.dart';
import '../../entities/note.dart';
import '../states/new_note_state.dart';

class NewNoteNotifier extends AutoDisposeFamilyNotifier<NewNoteState, int?> {
  late final NotesRepository notesRepository =
      ref.read(notesRepositoryProvider);

  @override
  NewNoteState build(int? arg) {
    // If no id passed, return a new note state
    if (arg == null) {
      return NewNoteState();
    }

    // If an id is passed, fetch the note from the repository
    AsyncValue.guard(() => notesRepository.getNoteById(arg)).then(
      (value) => value.when(
        data: (note) => state = NewNoteState(
          note: AsyncValue.data(note),
          isEditing: true,
        ),
        loading: () => state = NewNoteState(
          note: const AsyncValue.loading(),
          isEditing: true,
        ),
        error: (error, _) => state = NewNoteState(
          error: error.toString(),
          isEditing: true,
        ),
      ),
    );

    // And return a loading state while fetching the note
    return NewNoteState(
      note: const AsyncValue.loading(),
      isLoading: true,
      isEditing: true,
    );
  }

  Future<void> createOrEditNote(String title, String content) async {
    final Note note;

    // Create a new note or update the existing one
    if (state.isEditing) {
      note = state.note.value!.copyWith(
        title: title,
        content: content,
        updatedAt: DateTime.now(),
      );
      state = state.copyWith(note: AsyncValue.data(note));
    } else {
      note = Note(
        title: title,
        content: content,
        createdAt: DateTime.now(),
      );
    }

    // Validate the note and update the state accordingly
    if (!note.isValid) {
      state = state.copyWith(
        error: 'Please fill in all fields.',
        titleError: !note.isTitleValid,
        contentError: !note.isContentValid,
      );
      return;
    } else {
      state = state.copyWith(
        error: null,
        titleError: false,
        contentError: false,
      );
    }

    // Insert or update the note in the repository and update the state
    state = state.copyWith(isLoading: true);
    final task = state.isEditing
        ? notesRepository.updateNote(note)
        : notesRepository.insertNote(note);
    (await AsyncValue.guard(() => task)).when(
      data: (_) => state = state.copyWith(
        wasCreated: true,
        isLoading: false,
      ),
      loading: () => state = state.copyWith(
        isLoading: true,
      ),
      error: (error, _) => state = state.copyWith(
        error: error.toString(),
        isLoading: false,
      ),
    );
  }
}
