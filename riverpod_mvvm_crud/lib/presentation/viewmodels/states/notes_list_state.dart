import 'package:equatable/equatable.dart';

import '../../../entities/note.dart';
import '../../utils/base_screen_state.dart';

class NotesListState extends Equatable {
  final BaseScreenState screenState;
  final List<Note> notes;

  const NotesListState({
    this.screenState = const BaseScreenState.idle(),
    this.notes = const [],
  });

  NotesListState copyWith({
    BaseScreenState? screenState,
    List<Note>? notes,
  }) {
    return NotesListState(
      screenState: screenState ?? this.screenState,
      notes: notes ?? this.notes,
    );
  }

  @override
  List<Object?> get props => [screenState, notes];
}
