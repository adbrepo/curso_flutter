import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'notifiers/note_details_notifier.dart';
import 'notifiers/notes_list_notifier.dart';

final notesListViewModelProvider =
    NotifierProvider<NotesListNotifier, NotesListState>(NotesListNotifier.new);

final noteDetailsViewModelProvider =
    AutoDisposeNotifierProvider<NoteDetailsNotifier, NoteDetailsState>(
        NoteDetailsNotifier.new);
