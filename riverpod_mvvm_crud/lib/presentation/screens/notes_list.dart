import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/app_router.dart';
import '../../entities/note.dart';
import '../utils/base_screen_state.dart';
import '../viewmodels/providers.dart';
import '../widgets/note_item.dart';
import 'new_note.dart';
import 'note_details.dart';

class NotesListScreen extends ConsumerStatefulWidget {
  static const name = 'NotesListScreen';

  const NotesListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotesListScreenState();
}

class _NotesListScreenState extends ConsumerState<NotesListScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(notesListViewModelProvider.notifier).fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(notesListViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My notes'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _onNewNoteTap(context),
      ),
      body: state.screenState.when(
        idle: () {
          return _NotesList(
            notes: state.notes,
            onRefresh: _onRefresh,
            onNoteTap: (note) => _onNoteTap(context, note.id ?? -1),
            onNoteEdit: (note) => _onNoteEditTap(context, note.id ?? -1),
            onNoteDismiss: (note) => _onNoteDismiss(context, note),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error) => Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    await ref.read(notesListViewModelProvider.notifier).refresh();
  }

  void _onNewNoteTap(BuildContext context) async {
    final shouldRefresh = await context.pushNamed(
      NewNoteScreen.name,
      pathParameters: AppRouter.newNoteParameters(null),
    );
    if (shouldRefresh == true) {
      await _onRefresh();
    }
  }

  void _onNoteEditTap(BuildContext context, int noteId) async {
    final shouldRefresh = await context.pushNamed(
      NewNoteScreen.name,
      pathParameters: AppRouter.newNoteParameters(noteId),
    );
    debugPrint('Should refresh: $shouldRefresh');
    if (shouldRefresh == true) {
      await _onRefresh();
    }
  }

  void _onNoteTap(BuildContext context, int noteId) async {
    final shouldRefresh = await context.pushNamed(
      NoteDetailsScreen.name,
      pathParameters: AppRouter.noteDetailsParameters(noteId),
    );
    debugPrint('Should refresh: $shouldRefresh');
    if (shouldRefresh == true) {
      await _onRefresh();
    }
  }

  void _onNoteDismiss(BuildContext context, Note note) async {
    await ref.read(notesListViewModelProvider.notifier).delete(note.id ?? -1);
  }
}

class _NotesList extends StatelessWidget {
  _NotesList({
    super.key,
    required this.notes,
    required this.onRefresh,
    required this.onNoteTap,
    required this.onNoteEdit,
    required this.onNoteDismiss,
  });

  final List<Note> notes;
  final Future<void> Function() onRefresh;
  final Function(Note) onNoteTap;
  final Function(Note) onNoteEdit;
  final Function(Note) onNoteDismiss;

  final List<Color> _tileColors = [
    Colors.yellow[100]!,
    Colors.orange[100]!,
    Colors.red[100]!,
    Colors.green[100]!,
    Colors.blue[100]!,
    Colors.purple[100]!,
  ];

  @override
  Widget build(BuildContext context) {
    // TODO - Replace this with the AnimatedList widget, and update Notifier logic
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return NoteItem(
            note: note,
            onTap: () => onNoteTap(note),
            onEdit: () => onNoteEdit(note),
            onDismiss: () => onNoteDismiss(note),
            backgroundColor: _tileColors[index % _tileColors.length],
          );
        },
      ),
    );
  }
}
