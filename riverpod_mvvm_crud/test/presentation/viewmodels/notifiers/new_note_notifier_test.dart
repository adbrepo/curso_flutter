import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_mvvm_crud/data/providers.dart';
import 'package:riverpod_mvvm_crud/domain/notes_repository.dart';
import 'package:riverpod_mvvm_crud/domain/note.dart';
import 'package:riverpod_mvvm_crud/presentation/utils/base_screen_state.dart';
import 'package:riverpod_mvvm_crud/presentation/viewmodels/providers.dart';
import 'package:riverpod_mvvm_crud/presentation/viewmodels/states/new_note_state.dart';

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
    registerFallbackValue(
      Note(
        id: 1,
        title: 'Title',
        content: 'Content',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
  });

  test(
    'Initial state is Loading and loads the note after that',
    () async {
      // Given
      final notesRepository = MockNotesRepository();
      final listener = Listener<NewNoteState>();
      const noteId = 1;

      final expectedNote = mockedNotes.firstWhere((note) => note.id == noteId);

      when(() => notesRepository.getNoteById(noteId)).thenAnswer(
        (_) async => expectedNote,
      );

      // The container is created with the mocked repository
      final container = makeContainer(notesRepository);

      container.listen(
        newNoteViewModelProvider,
        listener.call,
        fireImmediately: true,
      );

      // Wait for the future state to complete
      await container.read(newNoteViewModelProvider.notifier).fetchNote(noteId);

      // The repository should be called once with the noteId
      verify(() => notesRepository.getNoteById(noteId)).called(1);

      // The initial state should be AsyncLoading and then the mocked notes
      verifyInOrder([
        () => listener.call(
              null,
              const NewNoteState(screenState: BaseScreenState.idle()),
            ),
        () => listener.call(
              const NewNoteState(screenState: BaseScreenState.idle()),
              const NewNoteState(
                screenState: BaseScreenState.loading(),
                isEditing: true,
              ),
            ),
        () => listener.call(
              const NewNoteState(
                screenState: BaseScreenState.loading(),
                isEditing: true,
              ),
              NewNoteState(
                screenState: const BaseScreenState.idle(),
                isEditing: true,
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
      final listener = Listener<NewNoteState>();
      const noteId = 1;
      final exception = Exception('An error occurred');

      when(() => notesRepository.getNoteById(noteId)).thenThrow(exception);

      final container = makeContainer(notesRepository);

      container.listen(
        newNoteViewModelProvider,
        listener.call,
        fireImmediately: true,
      );

      // Wait for the future state to complete
      await container.read(newNoteViewModelProvider.notifier).fetchNote(noteId);

      // The repository should be called once with the noteId
      verify(() => notesRepository.getNoteById(noteId)).called(1);

      // The initial state should be AsyncLoading and then the mocked notes
      verifyInOrder([
        () => listener.call(
              null,
              const NewNoteState(screenState: BaseScreenState.idle()),
            ),
        () => listener.call(
              const NewNoteState(screenState: BaseScreenState.idle()),
              const NewNoteState(
                screenState: BaseScreenState.loading(),
                isEditing: true,
              ),
            ),
        () => listener.call(
              const NewNoteState(
                screenState: BaseScreenState.loading(),
                isEditing: true,
              ),
              NewNoteState(
                screenState: BaseScreenState.error(exception.toString()),
              ),
            ),
      ]);

      // No more interactions
      verifyNoMoreInteractions(listener);
    },
  );

  test(
    'CreateOrEdit creates the note when the note is valid',
    () async {
      // Given
      final notesRepository = MockNotesRepository();
      final listener = Listener<NewNoteState>();

      when(() => notesRepository.insertNote(any())).thenAnswer((_) async {});

      final container = makeContainer(notesRepository);

      container.listen(
        newNoteViewModelProvider,
        listener.call,
        fireImmediately: true,
      );

      // When deleting the note
      //final expectedNote = Note(title: 'Title', content: 'Content');
      await container.read(newNoteViewModelProvider.notifier).createOrEditNote(
            'Title',
            'Content',
          );

      // Verify the interactions with the repository
      verify(() => notesRepository.insertNote(any())).called(1);

      // The initial state should be AsyncLoading and then the mocked notes
      verifyInOrder([
        () => listener.call(
              null,
              const NewNoteState(screenState: BaseScreenState.idle()),
            ),
        () => listener.call(
              const NewNoteState(screenState: BaseScreenState.idle()),
              const NewNoteState(screenState: BaseScreenState.idle()),
            ),
        () => listener.call(
              const NewNoteState(screenState: BaseScreenState.idle()),
              const NewNoteState(screenState: BaseScreenState.loading()),
            ),
        () => listener.call(
              const NewNoteState(screenState: BaseScreenState.loading()),
              const NewNoteState(
                screenState: BaseScreenState.idle(),
                //note: expectedNote,
                wasCreated: true,
              ),
            ),
      ]);

      // No more interactions
      verifyNoMoreInteractions(listener);
    },
  );

  test(
    'CreateOrEdit sets error messages for invalid note',
    () async {
      // Given
      final notesRepository = MockNotesRepository();
      final listener = Listener<NewNoteState>();

      when(() => notesRepository.insertNote(any())).thenAnswer((_) async {});

      final container = makeContainer(notesRepository);

      container.listen(
        newNoteViewModelProvider,
        listener.call,
        fireImmediately: true,
      );

      // When deleting the note
      //final expectedNote = Note(title: 'Title', content: 'Content');
      await container.read(newNoteViewModelProvider.notifier).createOrEditNote(
            '',
            'Content',
          );

      // Verify the interactions with the repository
      verifyNever(() => notesRepository.insertNote(any()));

      // The initial state should be AsyncLoading and then the mocked notes
      verifyInOrder([
        () => listener.call(
              null,
              const NewNoteState(screenState: BaseScreenState.idle()),
            ),
        () => listener.call(
              const NewNoteState(screenState: BaseScreenState.idle()),
              const NewNoteState(
                screenState: BaseScreenState.error(
                  'Please fill in all fields.',
                ),
                titleError: true,
                contentError: false,
              ),
            ),
      ]);

      // No more interactions
      verifyNoMoreInteractions(listener);
    },
  );
}
