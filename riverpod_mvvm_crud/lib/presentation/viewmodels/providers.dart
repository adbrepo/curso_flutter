import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'states/new_note_state.dart';
import 'notifiers/new_note_notifier.dart';
import 'notifiers/note_details_notifier.dart';
import 'notifiers/notes_list_notifier.dart';
import 'states/note_details_state.dart';
import 'states/notes_list_state.dart';

final notesListViewModelProvider =
    NotifierProvider<NotesListNotifier, NotesListState>(NotesListNotifier.new);

final noteDetailsViewModelProvider = AutoDisposeNotifierProviderFamily<
    NoteDetailsNotifier, NoteDetailsState, int>(NoteDetailsNotifier.new);

final newNoteViewModelProvider =
    AutoDisposeNotifierProvider<NewNoteNotifier, NewNoteState>(
        NewNoteNotifier.new);
