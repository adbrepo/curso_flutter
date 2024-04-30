import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_mvvm_crud/core/providers.dart';
import 'package:riverpod_mvvm_crud/data/notes_repository.dart';
import 'package:riverpod_mvvm_crud/entities/note.dart';
import 'package:riverpod_mvvm_crud/presentation/notifiers/providers.dart';

import '../../mocks/notes.dart';

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
      final listener = Listener<AsyncValue<List<Note>>>();

      when(() => notesRepository.getAllNotes()).thenAnswer(
        (_) async => mockedNotes,
      );

      //
      final container = makeContainer(notesRepository);

      container.listen(
        notesListProvider,
        listener.call,
        fireImmediately: true,
      );

      // Wait for the future state to complete
      await container.read(notesListProvider.future);

      // The repository should be called once
      verify(() => notesRepository.getAllNotes()).called(1);

      // The initial state should be AsyncLoading and then the mocked notes
      verifyInOrder([
        () => listener.call(
              null,
              const AsyncValue.loading(),
            ),
        () => listener.call(
              const AsyncValue.loading(),
              AsyncValue.data(mockedNotes),
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
      final listener = Listener<AsyncValue<List<Note>>>();
      final exception = Exception('An error');

      when(() => notesRepository.getAllNotes()).thenThrow(exception);

      final container = makeContainer(notesRepository);

      container.listen(
        notesListProvider,
        listener.call,
        fireImmediately: true,
      );

      // Wait for the future state to complete, catching the error
      await container
          .read(notesListProvider.future)
          .catchError((_) => <Note>[]);

      // The repository should be called once
      verify(() => notesRepository.getAllNotes()).called(1);

      // The initial state should be AsyncLoading and then the mocked notes
      verifyInOrder([
        () => listener.call(
              null,
              const AsyncValue.loading(),
            ),
        () => listener.call(
              const AsyncValue.loading(),
              any(that: isA<AsyncError>()),
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
      final listener = Listener<AsyncValue<List<Note>>>();

      when(() => notesRepository.getAllNotes()).thenAnswer(
        (_) async => mockedNotes,
      );

      final container = makeContainer(notesRepository);

      container.listen(
        notesListProvider,
        listener.call,
        fireImmediately: true,
      );

      // Wait for the initial state to complete
      await container.read(notesListProvider.future);

      // When refreshing the notes
      await container.read(notesListProvider.notifier).refresh();

      // The repository should be called twice
      verify(() => notesRepository.getAllNotes()).called(2);

      // The state should be updated to loading and then the mocked notes
      verifyInOrder([
        // Initial states
        () => listener.call(
              null,
              const AsyncValue.loading(),
            ),
        () => listener.call(
              const AsyncValue.loading(),
              AsyncValue.data(mockedNotes),
            ),
        // From here, the refresh states
        () => listener.call(
              AsyncValue.data(mockedNotes),
              any(that: isA<AsyncLoading<List<Note>>>()),
            ),
        () => listener.call(
              any(that: isA<AsyncLoading<List<Note>>>()),
              AsyncValue.data(mockedNotes),
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
      final listener = Listener<AsyncValue<List<Note>>>();

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
        notesListProvider,
        listener.call,
        fireImmediately: true,
      );

      // Wait for the initial state to complete
      await container.read(notesListProvider.future);

      // When deleting the note
      await container.read(notesListProvider.notifier).delete(noteIdToDelete);

      // Verify the interactions with the repository
      verify(() => notesRepository.getAllNotes()).called(1);
      verify(() => notesRepository.deleteNoteById(noteIdToDelete)).called(1);

      // The state should be updated to loading and then the mocked notes
      verifyInOrder([
        // Initial states
        () => listener.call(
              null,
              const AsyncValue.loading(),
            ),
        () => listener.call(
              const AsyncValue.loading(),
              AsyncValue.data(mockedNotes),
            ),
        // From here, the delete states
        () => listener.call(
              AsyncValue.data(mockedNotes),
              any(that: isA<AsyncLoading<List<Note>>>()),
            ),
        () => listener.call(
              any(that: isA<AsyncLoading<List<Note>>>()),
              any(that: isA<AsyncData<List<Note>>>()),
            ),
      ]);

      // No more interactions
      verifyNoMoreInteractions(listener);
    },
  );
}
