import 'note.dart';

abstract interface class NotesRepository {
  Future<List<Note>> getAllNotes();
  Future<Note?> getNoteById(int id);
}
