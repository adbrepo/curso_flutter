import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entities/note.dart';

class NewNoteState {
  final AsyncValue<Note?> note;
  final bool isLoading;
  final String? error;
  final bool titleError;
  final bool contentError;
  final bool isEditing;
  // Used as an event flag to notify the user that the note was created
  final bool wasCreated;

  NewNoteState({
    this.note = const AsyncValue.data(null),
    this.isLoading = false,
    this.error,
    this.titleError = false,
    this.contentError = false,
    this.isEditing = false,
    this.wasCreated = false,
  });

  NewNoteState copyWith({
    AsyncValue<Note?>? note,
    bool? isLoading,
    String? error,
    bool? titleError,
    bool? contentError,
    bool? isEditing,
    bool? wasCreated,
  }) {
    return NewNoteState(
      note: note ?? this.note,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      titleError: titleError ?? this.titleError,
      contentError: contentError ?? this.contentError,
      isEditing: isEditing ?? this.isEditing,
      wasCreated: wasCreated ?? this.wasCreated,
    );
  }
}
