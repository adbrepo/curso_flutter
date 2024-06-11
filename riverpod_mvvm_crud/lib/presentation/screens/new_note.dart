import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../utils/base_screen_state.dart';
import '../viewmodels/providers.dart';

class NewNoteScreen extends ConsumerStatefulWidget {
  static const name = 'NewNoteScreen';

  const NewNoteScreen({super.key, this.noteId});

  final int? noteId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends ConsumerState<NewNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  bool _titleHasError = false;
  bool _contentHasError = false;

  @override
  void dispose() {
    super.dispose();

    _titleController.dispose();
    _contentController.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (widget.noteId != null) {
      ref.read(newNoteViewModelProvider.notifier).fetchNote(widget.noteId!);
    }

    // Clear the text fields when the user taps in
    _titleController.addListener(() {
      if (_titleHasError) setState(() => _titleHasError = false);
    });
    _contentController.addListener(() {
      if (_contentHasError) setState(() => _contentHasError = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    _setupStateListener();

    final state = ref.watch(newNoteViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(state.isEditing ? 'Edit note' : 'New note'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveNote,
          ),
        ],
      ),
      body: Stack(
        children: [
          _buildForm(),
          if (state.screenState.isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  // Some fields inside the state are events, so we need to listen to them
  // and act accordingly.
  // For example, if the note was saved successfully, we show a dialog and
  // navigate back to the previous screen.
  void _setupStateListener() {
    ref.listen(newNoteViewModelProvider, (_, state) {
      if (state.screenState.isError) {
        //_showDialog('Error', state.error.toString());
        setState(() {
          _titleHasError = state.titleError;
          _contentHasError = state.contentError;
        });
      }
      if (state.wasCreated) {
        _showDialog('Success', 'Note saved successfully', () {
          // Soft delay to allow the dialog to close first before navigating back
          Future.delayed(const Duration(milliseconds: 100), () {
            context.pop(true);
          });
        });
      }

      if (state.note != null) {
        // If the note is fetched, fill the text fields
        _titleController.text = state.note!.title;
        _contentController.text = state.note!.content;
      }
    });
  }

  Widget _buildForm() {
    // TODO - Refactor this to use the 'Form' widget
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              style: Theme.of(context).textTheme.titleLarge,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Title',
                hintStyle: Theme.of(context).textTheme.titleLarge,
                errorText: _titleHasError ? 'Please fill in the title' : null,
              ),
            ),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Type something...',
                errorText:
                    _contentHasError ? 'Please fill in the content' : null,
              ),
              minLines: 1,
              maxLines: null,
              keyboardType: TextInputType.multiline,
            ),
          ],
        ),
      ),
    );
  }

  void _saveNote() {
    // Hide the keyboard
    FocusManager.instance.primaryFocus?.unfocus();

    ref.read(newNoteViewModelProvider.notifier).createOrEditNote(
          _titleController.text,
          _contentController.text,
        );
  }

  void _showDialog(String title, String content, [Function? onPressed]) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                onPressed?.call();
                context.pop();
              },
            ),
          ],
        );
      },
    );
  }
}
