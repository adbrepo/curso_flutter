import 'package:flutter/material.dart';

import '../../domain/note.dart';
import '../utils/formatter.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({
    super.key,
    required this.note,
    this.onTap,
    this.backgroundColor,
  });

  final Note note;
  final Function? onTap;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      child: ListTile(
        title: Text(note.title),
        subtitle: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.content,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              UIFormatter.formatDate(note.createdAt),
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () => onTap?.call(),
      ),
    );
  }
}
