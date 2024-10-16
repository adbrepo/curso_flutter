import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_mvvm_basic/data/providers.dart';
import 'package:riverpod_mvvm_basic/domain/notes_repository.dart';
import 'package:riverpod_mvvm_basic/domain/note.dart';
import 'package:riverpod_mvvm_basic/presentation/utils/base_screen_state.dart';
import 'package:riverpod_mvvm_basic/presentation/viewmodels/providers.dart';
import 'package:riverpod_mvvm_basic/presentation/viewmodels/states/note_details_state.dart';

import '../../../mocks/notes.dart';

class MockNotesRepository extends Mock implements NotesRepository {}

class Listener<T> extends Mock {
  void call(T? previous, T next);
}

void main() {
  ProviderContainer makeContainer(NotesRepository notesRepository) {
    final container = ProviderContainer(
      overrides: [
        notesRepositoryProvider.overrideWithValue(
          notesRepository,
        ),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  setUp(() {
    registerFallbackValue(const AsyncLoading<void>());
    registerFallbackValue(const AsyncData<Note?>(null));
  });

  test(
    'Initial state is Loading and loads the note after that',
    () async {
      // Given
      final notesRepository = MockNotesRepository();
      final listener = Listener<NoteDetailsState>();
      const noteId = 1;

      final expectedNote = mockedNotes.firstWhere((note) => note.id == noteId);

      when(() => notesRepository.getNoteById(noteId)).thenAnswer(
        (_) async => expectedNote,
      );

      // The container is created with the mocked repository
      final container = makeContainer(notesRepository);

      container.listen(
        noteDetailsViewModelProvider,
        listener.call,
        fireImmediately: true,
      );

      // Wait for the future state to complete
      await container
          .read(noteDetailsViewModelProvider.notifier)
          .fetchNote(noteId);

      // The repository should be called once with the noteId
      verify(() => notesRepository.getNoteById(noteId)).called(1);

      // The initial state should be AsyncLoading and then the mocked notes
      verifyInOrder([
        () => listener.call(
              null,
              const NoteDetailsState(screenState: BaseScreenState.idle),
            ),
        () => listener.call(
              const NoteDetailsState(screenState: BaseScreenState.idle),
              const NoteDetailsState(screenState: BaseScreenState.loading),
            ),
        () => listener.call(
              const NoteDetailsState(screenState: BaseScreenState.loading),
              NoteDetailsState(
                screenState: BaseScreenState.idle,
                note: expectedNote,
              ),
            ),
      ]);

      // No more interactions
      verifyNoMoreInteractions(listener);
    },
  );

  test(
    'Initial state is AsyncLoading and throws an error',
    () async {
      // Given
      final notesRepository = MockNotesRepository();
      final listener = Listener<NoteDetailsState>();
      const noteId = 1;
      final exception = Exception('An error occurred');

      when(() => notesRepository.getNoteById(noteId)).thenThrow(exception);

      final container = makeContainer(notesRepository);

      container.listen(
        noteDetailsViewModelProvider,
        listener.call,
        fireImmediately: true,
      );

      // Wait for the future state to complete
      await container
          .read(noteDetailsViewModelProvider.notifier)
          .fetchNote(noteId);

      // The repository should be called once with the noteId
      verify(() => notesRepository.getNoteById(noteId)).called(1);

      // The initial state should be AsyncLoading and then the mocked notes
      verifyInOrder([
        () => listener.call(
              null,
              const NoteDetailsState(screenState: BaseScreenState.idle),
            ),
        () => listener.call(
              const NoteDetailsState(screenState: BaseScreenState.idle),
              const NoteDetailsState(screenState: BaseScreenState.loading),
            ),
        () => listener.call(
              const NoteDetailsState(screenState: BaseScreenState.loading),
              NoteDetailsState(
                screenState: BaseScreenState.error,
                error: exception.toString(),
              ),
            ),
      ]);

      // No more interactions
      verifyNoMoreInteractions(listener);
    },
  );
}
