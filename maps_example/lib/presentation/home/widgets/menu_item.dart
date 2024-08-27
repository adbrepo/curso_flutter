import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maps_example/presentation/home/models/menu_item.dart';

class MenuItemWidget extends StatelessWidget {
  const MenuItemWidget({
    super.key,
    required this.item,
  });

  final MenuItem item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.title),
      subtitle: Text(item.subtitle),
      leading: Icon(item.icon),
      onTap: () => context.push(item.route),
    );
  }
}
