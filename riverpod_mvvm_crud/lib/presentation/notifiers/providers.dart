import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entities/note.dart';
import '../states/new_note_state.dart';
import 'new_note_notifier.dart';
import 'note_details_notifier.dart';
import 'notes_list_notifier.dart';

final notesListProvider =
    AsyncNotifierProvider<NotesListNotifier, List<Note>>(NotesListNotifier.new);

final noteDetailsProvider =
    AutoDisposeAsyncNotifierProviderFamily<NoteDetailsNotifier, Note?, int>(
        NoteDetailsNotifier.new);

final newNoteProvider =
    AutoDisposeNotifierProviderFamily<NewNoteNotifier, NewNoteState, int?>(
        NewNoteNotifier.new);
