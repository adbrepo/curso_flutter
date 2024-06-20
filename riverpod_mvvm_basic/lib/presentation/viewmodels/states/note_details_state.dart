import 'package:equatable/equatable.dart';

import '../../../domain/note.dart';
import '../../utils/base_screen_state.dart';

class NoteDetailsState extends Equatable {
  final BaseScreenState screenState;
  final String? error;
  final Note? note;

  const NoteDetailsState({
    this.screenState = BaseScreenState.idle,
    this.error,
    this.note,
  });

  NoteDetailsState copyWith({
    BaseScreenState? screenState,
    String? error,
    Note? note,
  }) {
    return NoteDetailsState(
      screenState: screenState ?? this.screenState,
      error: error ?? this.error,
      note: note ?? this.note,
    );
  }

  @override
  List<Object?> get props => [screenState, error, note];
}
