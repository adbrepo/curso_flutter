import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/app_router.dart';
import '../../domain/note.dart';
import '../utils/base_screen_state.dart';
import '../viewmodels/providers.dart';
import '../widgets/note_item.dart';
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

    // Fetch notes after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(notesListViewModelProvider.notifier).fetchNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(notesListViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My notes'),
      ),
      body: state.screenState.when(
        idle: () {
          return _NotesList(
            notes: state.notes,
            onRefresh: _onRefresh,
            onNoteTap: (note) => _onNoteTap(context, note.id ?? -1),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: () => Center(
          child: Text('Error: ${state.error ?? 'Unknown'}'),
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    await ref.read(notesListViewModelProvider.notifier).refresh();
  }

  void _onNoteTap(BuildContext context, int noteId) {
    context.pushNamed(
      NoteDetailsScreen.name,
      pathParameters: AppRouter.noteDetailsParameters(noteId),
    );
  }
}

class _NotesList extends StatelessWidget {
  _NotesList({
    super.key,
    required this.notes,
    required this.onRefresh,
    required this.onNoteTap,
  });

  final List<Note> notes;
  final Future<void> Function() onRefresh;
  final Function(Note) onNoteTap;

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
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return NoteItem(
            note: note,
            onTap: () => onNoteTap(note),
            backgroundColor: _tileColors[index % _tileColors.length],
          );
        },
      ),
    );
  }
}
