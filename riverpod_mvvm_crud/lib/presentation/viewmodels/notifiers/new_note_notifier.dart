import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/providers.dart';
import '../../../domain/notes_repository.dart';
import '../../../domain/note.dart';
import '../../utils/base_screen_state.dart';
import '../states/new_note_state.dart';

class NewNoteNotifier extends AutoDisposeNotifier<NewNoteState> {
  late final NotesRepository notesRepository =
      ref.read(notesRepositoryProvider);

  @override
  NewNoteState build() {
    return const NewNoteState(
      screenState: BaseScreenState.idle(),
    );
  }

  Future<void> fetchNote(int noteId) async {
    state = state.copyWith(
      screenState: const BaseScreenState.loading(),
      isEditing: true,
    );

    try {
      final note = await notesRepository.getNoteById(noteId);
      state = state.copyWith(
        screenState: const BaseScreenState.idle(),
        note: note,
      );
    } catch (error) {
      state = state.copyWith(
        screenState: BaseScreenState.error(error.toString()),
        isEditing: false,
      );
    }
  }

  Future<void> createOrEditNote(String title, String content) async {
    final Note note;

    // Create a new note or update the existing one
    if (state.isEditing) {
      note = state.note!.copyWith(
        title: title,
        content: content,
        updatedAt: DateTime.now(),
      );
      state = state.copyWith(note: note);
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
        screenState: const BaseScreenState.error('Please fill in all fields.'),
        titleError: !note.isTitleValid,
        contentError: !note.isContentValid,
      );
      return;
    } else {
      state = state.copyWith(
        screenState: const BaseScreenState.idle(),
        titleError: false,
        contentError: false,
      );
    }

    // Insert or update the note in the repository and update the state
    state = state.copyWith(
      screenState: const BaseScreenState.loading(),
    );
    final task = state.isEditing
        ? notesRepository.updateNote(note)
        : notesRepository.insertNote(note);

    try {
      await task;
      state = state.copyWith(
        screenState: const BaseScreenState.idle(),
        //note: note,
        wasCreated: true,
      );
    } catch (error) {
      state = state.copyWith(
        screenState: BaseScreenState.error(error.toString()),
      );
    }
  }
}
