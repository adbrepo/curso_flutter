import '../../../entities/note.dart';
import '../../utils/base_screen_state.dart';

class NewNoteState {
  final BaseScreenState screenState;
  final Note? note;
  final bool titleError;
  final bool contentError;
  final bool isEditing;
  // Used as an event flag to notify the user that the note was created
  final bool wasCreated;

  NewNoteState({
    this.screenState = const BaseScreenState.idle(),
    this.note,
    this.titleError = false,
    this.contentError = false,
    this.isEditing = false,
    this.wasCreated = false,
  });

  NewNoteState copyWith({
    BaseScreenState? screenState,
    Note? note,
    bool? titleError,
    bool? contentError,
    bool? isEditing,
    bool? wasCreated,
  }) {
    return NewNoteState(
      screenState: screenState ?? this.screenState,
      note: note ?? this.note,
      titleError: titleError ?? this.titleError,
      contentError: contentError ?? this.contentError,
      isEditing: isEditing ?? this.isEditing,
      wasCreated: wasCreated ?? this.wasCreated,
    );
  }
}
