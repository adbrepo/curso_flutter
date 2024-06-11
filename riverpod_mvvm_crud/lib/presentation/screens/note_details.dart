import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/app_router.dart';
import '../../entities/note.dart';
import '../utils/base_screen_state.dart';
import '../viewmodels/providers.dart';
import '../utils/formatter.dart';
import 'new_note.dart';

class NoteDetailsScreen extends ConsumerStatefulWidget {
  static const name = 'NoteDetailsScreen';
  const NoteDetailsScreen({super.key, required this.noteId});

  final int noteId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends ConsumerState<NoteDetailsScreen> {
  final _fabKey = GlobalKey<ExpandableFabState>();

  @override
  void initState() {
    super.initState();

    ref
        .read(noteDetailsViewModelProvider(widget.noteId).notifier)
        .fetchNote(widget.noteId);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(noteDetailsViewModelProvider(widget.noteId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Note details'),
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        key: _fabKey,
        type: ExpandableFabType.up,
        overlayStyle: ExpandableFabOverlayStyle(
          color: Colors.grey.withOpacity(0.5),
        ),
        distance: 60,
        children: [
          FloatingActionButton.small(
            heroTag: null,
            onPressed: _onEditPressed,
            child: const Icon(Icons.edit),
          ),
          FloatingActionButton.small(
            heroTag: null,
            onPressed: _onDeletePressed,
            child: const Icon(Icons.delete),
          ),
        ],
      ),
      body: state.screenState.when(
        idle: () {
          if (state.note == null) {
            return const Center(
              child: Text('Note not found'),
            );
          }
          return _NoteDetails(note: state.note!);
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

  Future<void> _onDeletePressed() async {
    // Close the expandable FAB after pressing delete
    _fabKey.currentState?.toggle();

    await ref
        .read(noteDetailsViewModelProvider(widget.noteId).notifier)
        .delete(widget.noteId);

    if (context.mounted) {
      // ignore: use_build_context_synchronously
      context.pop(true);
    }
  }

  void _onEditPressed() async {
    // Close the expandable FAB after pressing edit
    _fabKey.currentState?.toggle();

    // Navigate to the new note screen with the note ID to edit it
    final shouldRefresh = await context.pushNamed(
      NewNoteScreen.name,
      pathParameters: AppRouter.newNoteParameters(widget.noteId),
    );

    if (shouldRefresh == true && context.mounted) {
      // ignore: use_build_context_synchronously
      context.pop(true);
    }
  }
}

class _NoteDetails extends StatelessWidget {
  const _NoteDetails({
    super.key,
    required this.note,
  });

  final Note note;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              UIFormatter.formatDate(note.updatedAt ?? note.createdAt),
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const SizedBox(height: 8),
            Text(note.content),
          ],
        ),
      ),
    );
  }
}
