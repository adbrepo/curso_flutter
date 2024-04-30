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
    registerFallbackValue(const AsyncData<Note?>(null));
  });

  test(
    'Initial state is AsyncLoading and loads the note after that',
    () async {
      // Given
      final notesRepository = MockNotesRepository();
      final listener = Listener<AsyncValue<Note?>>();
      const noteId = 1;

      final expectedNote = mockedNotes.firstWhere((note) => note.id == noteId);

      when(() => notesRepository.getNoteById(noteId)).thenAnswer(
        (_) async => expectedNote,
      );

      // The container is created with the mocked repository
      final container = makeContainer(notesRepository);

      container.listen(
        noteDetailsProvider(noteId),
        listener.call,
        fireImmediately: true,
      );

      // Wait for the future state to complete
      await container.read(noteDetailsProvider(noteId).future);

      // The repository should be called once with the noteId
      verify(() => notesRepository.getNoteById(noteId)).called(1);

      // The initial state should be AsyncLoading and then the mocked notes
      verifyInOrder([
        () => listener.call(
              null,
              const AsyncValue.loading(),
            ),
        () => listener.call(
              const AsyncValue.loading(),
              AsyncValue.data(expectedNote),
            ),
      ]);

      // No more interactions
      verifyNoMoreInteractions(listener);
    },
  );

  // Test initial state that throws
  test(
    'Initial state is AsyncLoading and throws an error',
    () async {
      // Given
      final notesRepository = MockNotesRepository();
      final listener = Listener<AsyncValue<Note?>>();
      const noteId = 1;

      when(() => notesRepository.getNoteById(noteId)).thenThrow(
        Exception('An error occurred'),
      );

      final container = makeContainer(notesRepository);

      container.listen(
        noteDetailsProvider(noteId),
        listener.call,
        fireImmediately: true,
      );

      // Wait for the future state to complete
      await container
          .read(noteDetailsProvider(noteId).future)
          .catchError((_) => null);

      // The repository should be called once with the noteId
      verify(() => notesRepository.getNoteById(noteId)).called(1);

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
    'Delete removes the note from the list',
    () async {
      // Given
      final notesRepository = MockNotesRepository();
      final listener = Listener<AsyncValue<Note?>>();
      const noteId = 1;

      final expectedNote = mockedNotes.firstWhere((note) => note.id == noteId);

      when(() => notesRepository.getNoteById(noteId)).thenAnswer(
        (_) async => expectedNote,
      );
      when(() => notesRepository.deleteNoteById(noteId)).thenAnswer(
        (_) async {
          mockedNotes.removeWhere((note) => note.id == noteId);
        },
      );

      final container = makeContainer(notesRepository);

      container.listen(
        noteDetailsProvider(noteId),
        listener.call,
        fireImmediately: true,
      );

      // Wait for the initial state to complete
      await container.read(noteDetailsProvider(noteId).future);

      // When deleting the note
      await container.read(noteDetailsProvider(noteId).notifier).delete(noteId);

      // Verify the interactions with the repository
      verify(() => notesRepository.getNoteById(noteId)).called(1);
      verify(() => notesRepository.deleteNoteById(noteId)).called(1);

      // The state should be updated to loading and then the mocked notes
      verifyInOrder([
        // Initial states
        () => listener.call(
              null,
              const AsyncValue.loading(),
            ),
        () => listener.call(
              const AsyncValue.loading(),
              AsyncValue.data(expectedNote),
            ),
        // From here, the delete states
        () => listener.call(
              AsyncValue.data(expectedNote),
              any(that: isA<AsyncLoading<Note?>>()),
            ),
        () => listener.call(
              any(that: isA<AsyncLoading<Note?>>()),
              const AsyncValue.data(null),
            ),
      ]);

      // No more interactions
      verifyNoMoreInteractions(listener);
    },
  );
}
