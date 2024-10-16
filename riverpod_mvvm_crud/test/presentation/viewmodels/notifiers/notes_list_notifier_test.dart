import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_mvvm_crud/data/providers.dart';
import 'package:riverpod_mvvm_crud/domain/notes_repository.dart';
import 'package:riverpod_mvvm_crud/domain/note.dart';
import 'package:riverpod_mvvm_crud/presentation/utils/base_screen_state.dart';
import 'package:riverpod_mvvm_crud/presentation/viewmodels/providers.dart';
import 'package:riverpod_mvvm_crud/presentation/viewmodels/states/notes_list_state.dart';

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
    registerFallbackValue(const AsyncData<List<Note>>([]));
  });

  test(
    'Initial state is AsyncLoading and loads the notes after that',
    () async {
      // Given
      final notesRepository = MockNotesRepository();
      final listener = Listener<NotesListState>();

      when(() => notesRepository.getAllNotes()).thenAnswer(
        (_) async => mockedNotes,
      );

      //
      final container = makeContainer(notesRepository);

      container.listen(
        notesListViewModelProvider,
        listener.call,
        fireImmediately: true,
      );

      // Call the fetchNotes method
      await container.read(notesListViewModelProvider.notifier).fetchNotes();

      // The repository should be called once
      verify(() => notesRepository.getAllNotes()).called(1);

      // The initial state should be AsyncLoading and then the mocked notes
      verifyInOrder([
        () => listener.call(
              null,
              const NotesListState(screenState: BaseScreenState.idle()),
            ),
        () => listener.call(
              const NotesListState(screenState: BaseScreenState.idle()),
              const NotesListState(screenState: BaseScreenState.loading()),
            ),
        () => listener.call(
              const NotesListState(screenState: BaseScreenState.loading()),
              NotesListState(
                screenState: const BaseScreenState.idle(),
                notes: mockedNotes,
              ),
            ),
      ]);

      // No more interactions
      verifyNoMoreInteractions(listener);
    },
  );

  test(
    'Initial state is AsyncLoading and emits error on exception thrown',
    () async {
      // Given
      final notesRepository = MockNotesRepository();
      final listener = Listener<NotesListState>();
      final exception = Exception('An error');

      when(() => notesRepository.getAllNotes()).thenThrow(exception);

      final container = makeContainer(notesRepository);

      container.listen(
        notesListViewModelProvider,
        listener.call,
        fireImmediately: true,
      );

      // Call the fetchNotes method
      await container.read(notesListViewModelProvider.notifier).fetchNotes();

      // The repository should be called once
      verify(() => notesRepository.getAllNotes()).called(1);

      // The initial state should be AsyncLoading and then the mocked notes
      verifyInOrder([
        () => listener.call(
              null,
              const NotesListState(screenState: BaseScreenState.idle()),
            ),
        () => listener.call(
              const NotesListState(screenState: BaseScreenState.idle()),
              const NotesListState(screenState: BaseScreenState.loading()),
            ),
        () => listener.call(
              const NotesListState(screenState: BaseScreenState.loading()),
              NotesListState(
                screenState: BaseScreenState.error(exception.toString()),
              ),
            ),
      ]);

      // No more interactions
      verifyNoMoreInteractions(listener);
    },
  );

  test(
    'Refresh updates the notes',
    () async {
      // Given
      final notesRepository = MockNotesRepository();
      final listener = Listener<NotesListState>();

      when(() => notesRepository.getAllNotes()).thenAnswer(
        (_) async => mockedNotes,
      );

      final container = makeContainer(notesRepository);

      container.listen(
        notesListViewModelProvider,
        listener.call,
        fireImmediately: true,
      );

      // Call the fetchNotes method
      await container.read(notesListViewModelProvider.notifier).fetchNotes();

      // When refreshing the notes...
      await container.read(notesListViewModelProvider.notifier).refresh();

      // The repository should be called twice
      verify(() => notesRepository.getAllNotes()).called(2);

      // The state should be updated to loading and then the mocked notes
      verifyInOrder([
        // Initial states
        () => listener.call(
              null,
              const NotesListState(screenState: BaseScreenState.idle()),
            ),
        () => listener.call(
              const NotesListState(screenState: BaseScreenState.idle()),
              const NotesListState(screenState: BaseScreenState.loading()),
            ),
        () => listener.call(
              const NotesListState(screenState: BaseScreenState.loading()),
              NotesListState(
                screenState: const BaseScreenState.idle(),
                notes: mockedNotes,
              ),
            ),
        // From here, the refresh states
        () => listener.call(
              NotesListState(
                screenState: const BaseScreenState.idle(),
                notes: mockedNotes,
              ),
              NotesListState(
                screenState: const BaseScreenState.idle(),
                notes: mockedNotes,
              ),
            ),
      ]);

      // No more interactions
      verifyNoMoreInteractions(listener);
    },
  );

  test(
    'Delete removes the note from the list',
    () async {
      // Given
      final notesRepository = MockNotesRepository();
      final listener = Listener<NotesListState>();

      const noteIdToDelete = 1;

      when(() => notesRepository.getAllNotes()).thenAnswer(
        (_) async => mockedNotes,
      );
      when(() => notesRepository.deleteNoteById(1)).thenAnswer(
        (_) async {
          mockedNotes.removeWhere((note) => note.id == noteIdToDelete);
        },
      );

      final container = makeContainer(notesRepository);

      container.listen(
        notesListViewModelProvider,
        listener.call,
        fireImmediately: true,
      );

      // Call the fetchNotes method
      await container.read(notesListViewModelProvider.notifier).fetchNotes();

      // When deleting the note...
      await container
          .read(notesListViewModelProvider.notifier)
          .delete(noteIdToDelete);

      // Verify the interactions with the repository
      verify(() => notesRepository.getAllNotes()).called(1);
      verify(() => notesRepository.deleteNoteById(noteIdToDelete)).called(1);

      // The state should be updated to loading and then the mocked notes
      verifyInOrder([
        // Initial states
        () => listener.call(
              null,
              const NotesListState(screenState: BaseScreenState.idle()),
            ),
        () => listener.call(
              const NotesListState(screenState: BaseScreenState.idle()),
              const NotesListState(screenState: BaseScreenState.loading()),
            ),
        () => listener.call(
              const NotesListState(screenState: BaseScreenState.loading()),
              NotesListState(
                screenState: const BaseScreenState.idle(),
                notes: mockedNotes,
              ),
            ),
        // From here, the delete states
        () => listener.call(
              NotesListState(
                screenState: const BaseScreenState.idle(),
                notes: mockedNotes,
              ),
              NotesListState(
                screenState: const BaseScreenState.loading(),
                notes: mockedNotes,
              ),
            ),
        () => listener.call(
              NotesListState(
                screenState: const BaseScreenState.loading(),
                notes: mockedNotes,
              ),
              NotesListState(
                screenState: const BaseScreenState.idle(),
                notes: mockedNotes,
              ),
            ),
      ]);

      // No more interactions
      verifyNoMoreInteractions(listener);
    },
  );
}
