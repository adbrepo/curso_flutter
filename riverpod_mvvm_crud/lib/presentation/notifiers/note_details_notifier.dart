import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../data/notes_repository.dart';
import '../../entities/note.dart';

class NoteDetailsNotifier extends AutoDisposeFamilyAsyncNotifier<Note?, int> {
  late final NotesRepository notesRepository =
      ref.read(notesRepositoryProvider);

  @override
  FutureOr<Note?> build(int arg) async {
    return notesRepository.getNoteById(arg);
  }

  Future<void> delete(int id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await notesRepository.deleteNoteById(id);
      return null;
    });
  }
}
