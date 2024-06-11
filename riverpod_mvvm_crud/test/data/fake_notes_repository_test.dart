import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_mvvm_crud/data/fake_notes_repository.dart';
import 'package:riverpod_mvvm_crud/entities/note.dart';

void main() {
  test('getAllNotes returns a list of notes', () async {
    // Given
    final notesRepository = FakeNotesRepository();

    // When
    final notes = await notesRepository.getAllNotes();

    // Then
    expect(notes, isNotEmpty);
  });

  test('getNoteById returns a note', () async {
    // Given
    final notesRepository = FakeNotesRepository();
    const noteId = 1;

    // When
    final note = await notesRepository.getNoteById(noteId);

    // Then
    expect(note, isNotNull);
  });

  test('deleteNoteById deletes a note', () async {
    // Given
    final notesRepository = FakeNotesRepository();

    // When
    final startingNotes = await notesRepository.getAllNotes();
    notesRepository.deleteNoteById(startingNotes.first.id!);
    final endingNotes = await notesRepository.getAllNotes();

    // Then
    expect(endingNotes.length - startingNotes.length, -1);
  });

  test('updateNote updates a note', () async {
    // Given
    final notesRepository = FakeNotesRepository();
    const noteId = 1;
    const newTitle = 'New Title';
    const newContent = 'New Content';

    // When
    final startingNote = await notesRepository.getNoteById(noteId);
    final updatedNote = startingNote!.copyWith(
      title: newTitle,
      content: newContent,
    );
    await notesRepository.updateNote(updatedNote);
    final endingNote = await notesRepository.getNoteById(noteId);

    // Then
    expect(endingNote!.title, newTitle);
    expect(endingNote.content, newContent);
  });

  test('insertNote inserts a note', () async {
    // Given
    final notesRepository = FakeNotesRepository();
    const newTitle = 'New Title';
    const newContent = 'New Content';

    // When
    final startingNotes = await notesRepository.getAllNotes();
    final newNote = Note(
      title: newTitle,
      content: newContent,
      createdAt: DateTime.now(),
    );
    await notesRepository.insertNote(newNote);
    final endingNotes = await notesRepository.getAllNotes();

    // Then
    expect(endingNotes.length - startingNotes.length, 1);
    expect(endingNotes.any((note) => note.title == newNote.title), true);
  });
}
