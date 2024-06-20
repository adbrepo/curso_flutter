import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final int? id;
  final String title;
  final String content;
  final DateTime createdAt;

  Note({
    this.id,
    required this.title,
    required this.content,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Note copyWith({
    int? id,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        createdAt: createdAt ?? this.createdAt,
      );

  @override
  String toString() {
    return 'Note{id: $id, title: $title, content: $content, createdAt: $createdAt}';
  }

  @override
  List<Object?> get props => [id, title, content, createdAt];
}

extension NoteValidator on Note {
  bool get isValid => isTitleValid && isContentValid;
  bool get isTitleValid => title.isNotEmpty;
  bool get isContentValid => content.isNotEmpty;
}
