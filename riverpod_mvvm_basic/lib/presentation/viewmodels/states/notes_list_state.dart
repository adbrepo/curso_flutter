part of '../notifiers/notes_list_notifier.dart';

class NotesListState extends Equatable {
  final BaseScreenState screenState;
  final String? error;
  final List<Note> notes;
  final SortOrder sortOrder;

  const NotesListState({
    this.screenState = BaseScreenState.idle,
    this.error,
    this.notes = const [],
    this.sortOrder = SortOrder.descending,
  });

  NotesListState copyWith({
    BaseScreenState? screenState,
    String? error,
    List<Note>? notes,
    SortOrder? sortOrder,
  }) {
    return NotesListState(
      screenState: screenState ?? this.screenState,
      error: error ?? this.error,
      notes: notes ?? this.notes,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  List<Object?> get props => [screenState, error, notes, sortOrder];
}

enum SortOrder { ascending, descending }

