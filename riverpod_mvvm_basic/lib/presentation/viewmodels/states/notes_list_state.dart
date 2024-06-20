import 'package:equatable/equatable.dart';

import '../../../domain/note.dart';
import '../../utils/base_screen_state.dart';

class NotesListState extends Equatable {
  final BaseScreenState screenState;
  final String? error;
  final List<Note> notes;

  const NotesListState({
    this.screenState = BaseScreenState.idle,
    this.error,
    this.notes = const [],
  });

  NotesListState copyWith({
    BaseScreenState? screenState,
    String? error,
    List<Note>? notes,
  }) {
    return NotesListState(
      screenState: screenState ?? this.screenState,
      error: error ?? this.error,
      notes: notes ?? this.notes,
    );
  }

  @override
  List<Object?> get props => [screenState, error, notes];
}
