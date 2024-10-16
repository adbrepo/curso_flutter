import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/providers.dart';
import '../../../domain/notes_repository.dart';
import '../../utils/base_screen_state.dart';
import '../states/note_details_state.dart';

class NoteDetailsNotifier extends AutoDisposeNotifier<NoteDetailsState> {
  late final NotesRepository notesRepository =
      ref.read(notesRepositoryProvider);

  @override
  NoteDetailsState build() {
    return const NoteDetailsState();
  }

  Future<void> fetchNote(int noteId) async {
    state = state.copyWith(
      screenState: BaseScreenState.loading,
      error: null,
    );

    try {
      final note = await notesRepository.getNoteById(noteId);
      state = state.copyWith(
        screenState: BaseScreenState.idle,
        note: note,
      );
    } catch (error) {
      state = state.copyWith(
        screenState: BaseScreenState.error,
        error: error.toString(),
      );
    }
  }
}
