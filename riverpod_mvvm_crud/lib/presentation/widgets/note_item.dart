import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../domain/note.dart';
import '../utils/formatter.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({
    super.key,
    required this.note,
    this.onTap,
    this.onEdit,
    this.onDismiss,
    this.backgroundColor,
  });

  final Note note;
  final Function? onTap;
  final Function? onEdit;
  final Function? onDismiss;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    // Based on this package: https://pub.dev/packages/flutter_slidable
    return Card(
      color: backgroundColor,
      child: Slidable(
        key: ValueKey(note.id),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (_) => onEdit?.call(),
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
            SlidableAction(
              onPressed: _showDismissConfirmation,
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
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
                UIFormatter.formatDate(note.updatedAt ?? note.createdAt),
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => onTap?.call(),
        ),
      ),
    );
  }

  Future<bool?> _showDismissConfirmation(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Are you sure you want to delete?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
                onDismiss?.call();
              },
              child: const Text('Yes'),
            )
          ],
        );
      },
    );
  }
}

/// ----------------------------------------------------------------------------
/// Previous implementation with built-in Dismissible widget

class NoteItem2 extends StatelessWidget {
  const NoteItem2({
    super.key,
    required this.note,
    this.onTap,
    this.onDismiss,
  });

  final Note note;
  final Function? onTap;
  final Function? onDismiss;

  @override
  Widget build(BuildContext context) {
    // Based on this tutorial: https://dartling.dev/swipe-actions-flutter-dismissible-widget
    return Dismissible(
      key: ValueKey(note.id),
      direction: DismissDirection.endToStart,
      background: _getDismissBackground(context),
      confirmDismiss: (DismissDirection direction) async {
        if (direction == DismissDirection.endToStart) {
          return await _showDismissConfirmation(context);
        } else {
          return false;
        }
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          onDismiss?.call();
        }
      },
      child: ListTile(
        title: Text(note.title),
        subtitle: Text(
          note.content,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () => onTap?.call(),
      ),
    );
  }

  Widget _getDismissBackground(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.error,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      margin: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 15,
      ),
      child: const Icon(
        Icons.delete,
        color: Colors.white,
        size: 40,
      ),
    );
  }

  Future<bool?> _showDismissConfirmation(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Are you sure you want to delete?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Yes'),
            )
          ],
        );
      },
    );
  }
}
