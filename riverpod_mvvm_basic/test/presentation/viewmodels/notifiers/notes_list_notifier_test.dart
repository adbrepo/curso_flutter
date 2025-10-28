import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_mvvm_basic/data/providers.dart';
import 'package:riverpod_mvvm_basic/domain/notes_repository.dart';
import 'package:riverpod_mvvm_basic/domain/note.dart';
import 'package:riverpod_mvvm_basic/presentation/utils/base_screen_state.dart';
import 'package:riverpod_mvvm_basic/presentation/viewmodels/notifiers/notes_list_notifier.dart';
import 'package:riverpod_mvvm_basic/presentation/viewmodels/providers.dart';

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

      // The container is created with the mocked repository
      final container = makeContainer(notesRepository);

      container.listen(
        notesListViewModelProvider,
        listener.call,
        fireImmediately: true,
      );

      // Call the fetchNotes method
      await container.read(notesListViewModelProvider.notifier).fetchNotes();

      // The expected notes sorted in descending order (initial sort state)
      final expectedNotes = container
          .read(notesListViewModelProvider.notifier)
          .sortNotes(mockedNotes, SortOrder.descending);

      // The repository should be called once
      verify(() => notesRepository.getAllNotes()).called(1);

      // The initial state should be AsyncLoading and then the mocked notes
      verifyInOrder([
        () => listener.call(
              null,
              const NotesListState(screenState: BaseScreenState.idle),
            ),
        () => listener.call(
              const NotesListState(screenState: BaseScreenState.idle),
              const NotesListState(screenState: BaseScreenState.loading),
            ),
        () => listener.call(
              const NotesListState(screenState: BaseScreenState.loading),
              NotesListState(
                screenState: BaseScreenState.idle,
                notes: expectedNotes,
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
              const NotesListState(screenState: BaseScreenState.idle),
            ),
        () => listener.call(
              const NotesListState(screenState: BaseScreenState.idle),
              const NotesListState(screenState: BaseScreenState.loading),
            ),
        () => listener.call(
              const NotesListState(screenState: BaseScreenState.loading),
              NotesListState(
                screenState: BaseScreenState.error,
                error: exception.toString(),
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

      // The expected notes sorted in descending order (initial sort state)
      final expectedNotes = container
          .read(notesListViewModelProvider.notifier)
          .sortNotes(mockedNotes, SortOrder.descending);

      // The repository should be called twice
      verify(() => notesRepository.getAllNotes()).called(2);

      // The state should be updated to loading and then the mocked notes
      verifyInOrder([
        // Initial states
        () => listener.call(
              null,
              const NotesListState(screenState: BaseScreenState.idle),
            ),
        () => listener.call(
              const NotesListState(screenState: BaseScreenState.idle),
              const NotesListState(screenState: BaseScreenState.loading),
            ),
        () => listener.call(
              const NotesListState(screenState: BaseScreenState.loading),
              NotesListState(
                screenState: BaseScreenState.idle,
                notes: expectedNotes,
              ),
            ),
        // From here, the refresh states
        () => listener.call(
              NotesListState(
                screenState: BaseScreenState.idle,
                notes: expectedNotes,
              ),
              NotesListState(
                screenState: BaseScreenState.idle,
                notes: expectedNotes,
              ),
            ),
      ]);

      // No more interactions
      verifyNoMoreInteractions(listener);
    },
  );

  test(
    'Initial sort order is descending',
    () async {
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

      expect(
        container.read(notesListViewModelProvider).sortOrder,
        equals(SortOrder.descending),
      );
    },
  );

  test(
    'toggleSortOrder switches between ascending and descending',
    () async {
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

      // Initial state should be descending
      expect(
        container.read(notesListViewModelProvider).sortOrder,
        equals(SortOrder.descending),
      );

      // Toggle to ascending
      container.read(notesListViewModelProvider.notifier).toggleSortOrder();

      verifyInOrder([
        () => listener.call(
              null,
              const NotesListState(screenState: BaseScreenState.idle),
            ),
        () => listener.call(
              const NotesListState(screenState: BaseScreenState.idle),
              const NotesListState(
                screenState: BaseScreenState.idle,
                sortOrder: SortOrder.ascending,
              ),
            ),
      ]);

      // Toggle back to descending
      container.read(notesListViewModelProvider.notifier).toggleSortOrder();

      verify(
        () => listener.call(
          const NotesListState(
            screenState: BaseScreenState.idle,
            sortOrder: SortOrder.ascending,
          ),
          const NotesListState(
            screenState: BaseScreenState.idle,
            sortOrder: SortOrder.descending,
          ),
        ),
      );

      // No more interactions
      verifyNoMoreInteractions(listener);
    },
  );

}
