import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_mvvm_basic/data/fake_notes_repository.dart';

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
}
