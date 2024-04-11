// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgets_app/config/menu/menu_items.dart';

class DrawerMenu extends StatefulWidget {
  final GlobalKey<ScaffoldState> scafoldKey;
  const DrawerMenu({super.key, required this.scafoldKey});

  @override
  State<DrawerMenu> createState() => _DraweMenuState();
}

class _DraweMenuState extends State<DrawerMenu> {
  int selectedScreen = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      selectedIndex: selectedScreen,
      onDestinationSelected: (value) {
        setState(() {
          selectedScreen = value;
        });
        context.push(menuItems[value].link);
        widget.scafoldKey.currentState?.closeDrawer();
      },
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 10, 28, 5),
          child: Text('Main', style: Theme.of(context).textTheme.titleMedium),
        ),
        ...menuItems.sublist(0, 3).map((item) => NavigationDrawerDestination(
              icon: Icon(item.icon),
              label: Text(item.title),
            )),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 10, 28, 5),
          child: Divider(),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 10, 28, 5),
          child: Text('More options',
              style: Theme.of(context).textTheme.titleMedium),
        ),
        ...menuItems.sublist(3).map((item) => NavigationDrawerDestination(
              icon: Icon(item.icon),
              label: Text(item.title),
            )),
      ],
    );
  }
}
