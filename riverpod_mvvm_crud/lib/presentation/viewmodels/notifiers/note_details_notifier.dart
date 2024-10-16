import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/providers.dart';
import '../../../domain/notes_repository.dart';
import '../../utils/base_screen_state.dart';
import '../states/note_details_state.dart';

class NoteDetailsNotifier
    extends AutoDisposeFamilyNotifier<NoteDetailsState, int> {
  late final NotesRepository notesRepository =
      ref.read(notesRepositoryProvider);

  @override
  NoteDetailsState build(int arg) {
    return const NoteDetailsState();
  }

  Future<void> fetchNote(int noteId) async {
    state = state.copyWith(
      screenState: const BaseScreenState.loading(),
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
      );
    }
  }

  Future<void> delete(int id) async {
    state = state.copyWith(
      screenState: const BaseScreenState.loading(),
    );

    try {
      await notesRepository.deleteNoteById(id);
      state = const NoteDetailsState(
        screenState: BaseScreenState.idle(),
        note: null,
      );
    } catch (error) {
      state = state.copyWith(
        screenState: BaseScreenState.error(error.toString()),
      );
    }
  }
}
