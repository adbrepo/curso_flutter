import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/note.dart';
import '../utils/base_screen_state.dart';
import '../viewmodels/providers.dart';
import '../utils/formatter.dart';

class NoteDetailsScreen extends ConsumerStatefulWidget {
  static const name = 'NoteDetailsScreen';
  const NoteDetailsScreen({super.key, required this.noteId});

  final int noteId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends ConsumerState<NoteDetailsScreen> {
  @override
  void initState() {
    super.initState();

    // Fetch the note details after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(noteDetailsViewModelProvider.notifier).fetchNote(widget.noteId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(noteDetailsViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Note details'),
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
        error: () => Center(
          child: Text('Error fetching notes: ${state.error ?? 'Unknown'}'),
        ),
      ),
    );
  }
}

class _NoteDetails extends StatelessWidget {
  const _NoteDetails({
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
              UIFormatter.formatDate(note.createdAt),
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
