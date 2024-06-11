import 'package:equatable/equatable.dart';

import '../../../domain/note.dart';
import '../../utils/base_screen_state.dart';

class NoteDetailsState extends Equatable {
  final BaseScreenState screenState;
  final Note? note;

  const NoteDetailsState({
    this.screenState = const BaseScreenState.idle(),
    this.note,
  });

  NoteDetailsState copyWith({
    BaseScreenState? screenState,
    Note? note,
  }) {
    return NoteDetailsState(
      screenState: screenState ?? this.screenState,
      note: note ?? this.note,
    );
  }

  @override
  List<Object?> get props => [screenState, note];
}
