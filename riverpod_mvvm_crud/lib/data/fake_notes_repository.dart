import 'package:collection/collection.dart';

import '../domain/note.dart';
import '../domain/notes_repository.dart';

class FakeNotesRepository implements NotesRepository {
  final List<Note> _notes = [
    Note(
      id: 1,
      title: 'Note 1',
      content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
          'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
          'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. '
          'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. '
          'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      createdAt: DateTime.fromMillisecondsSinceEpoch(1641031200000),
    ),
    Note(
      id: 2,
      title: 'Note 2',
      content: 'Content of Note 2',
      createdAt: DateTime.fromMillisecondsSinceEpoch(1641041200000),
    ),
    Note(
      id: 3,
      title: 'Note 3',
      content: 'Content of Note 3',
      createdAt: DateTime.fromMillisecondsSinceEpoch(1641051200000),
    ),
  ];

  @override
  Future<List<Note>> getAllNotes() => Future.delayed(
        const Duration(seconds: 2),
        () => _notes.sortedBy((n) => n.updatedAt ?? n.createdAt),
      );

  @override
  Future<Note?> getNoteById(int id) async => Future.delayed(
        const Duration(seconds: 1),
        () => _notes.firstWhereOrNull((n) => n.id == id),
      );

  @override
  Future<void> insertNote(Note note) async => Future.delayed(
        const Duration(seconds: 2),
        () => _notes.add(note.copyWith(id: _notes.length + 1)),
      );

  @override
  Future<void> updateNote(Note note) async => Future.delayed(
        const Duration(seconds: 2),
        () => _notes[_notes.indexWhere((n) => n.id == note.id)] = note,
      );

  @override
  Future<void> deleteNoteById(int id) async => Future.delayed(
        const Duration(seconds: 2),
        () => _notes.removeWhere((n) => n.id == id),
      );
}
