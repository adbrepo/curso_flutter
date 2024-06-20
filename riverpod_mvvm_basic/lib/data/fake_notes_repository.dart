import 'package:collection/collection.dart';
import 'package:faker_dart/faker_dart.dart';

import '../domain/note.dart';
import '../domain/notes_repository.dart';

class FakeNotesRepository implements NotesRepository {
  final List<Note> _notes = [
    Note(
      id: 1,
      title: 'Note 1',
      content: Faker.instance.lorem.paragraph(sentenceCount: 1),
      createdAt: DateTime.fromMillisecondsSinceEpoch(1641031200000),
    ),
    Note(
      id: 2,
      title: 'Note 2',
      content: Faker.instance.lorem.paragraph(sentenceCount: 2),
      createdAt: DateTime.fromMillisecondsSinceEpoch(1651041200000),
    ),
    Note(
      id: 3,
      title: 'Note 3',
      content: Faker.instance.lorem.paragraph(sentenceCount: 10),
      createdAt: DateTime.fromMillisecondsSinceEpoch(1661051200000),
    ),
    Note(
      id: 3,
      title: 'Note 4',
      content: Faker.instance.lorem.paragraph(sentenceCount: 5),
      createdAt: DateTime.fromMillisecondsSinceEpoch(1671061200000),
    ),
  ];

  @override
  Future<List<Note>> getAllNotes() => Future.delayed(
        const Duration(seconds: 2),
        () => _notes,
      );

  @override
  Future<Note?> getNoteById(int id) async => Future.delayed(
        const Duration(seconds: 1),
        () => _notes.firstWhereOrNull((n) => n.id == id),
      );
}
