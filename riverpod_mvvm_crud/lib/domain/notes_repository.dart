import 'note.dart';

abstract interface class NotesRepository {
  Future<List<Note>> getAllNotes();
  Future<Note?> getNoteById(int id);
  Future<void> insertNote(Note note);
  Future<void> updateNote(Note note);
  Future<void> deleteNoteById(int id);
}
