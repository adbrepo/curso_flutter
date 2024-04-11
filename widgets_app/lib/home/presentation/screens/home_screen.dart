import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgets_app/config/menu/menu_items.dart';
import 'package:widgets_app/home/presentation/widgets/drawer-menu.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home_screen';
  final scafoldKey = GlobalKey<ScaffoldState>();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafoldKey,
      appBar: AppBar(
        title: const Text('Flutter + Material3'),
      ),
      body: const _HomeView(),
      drawer: DrawerMenu(
        scafoldKey: scafoldKey,
      ),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    const items = menuItems;

    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];
          return _CustomListTile(item: item);
        });
  }
}

class _CustomListTile extends StatelessWidget {
  final MenuItem item;

  const _CustomListTile({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(item.icon),
      trailing: const Icon(Icons.arrow_forward_ios),
      title: Text(item.title),
      subtitle: Text(item.subtitle),
      onTap: () {
        context.push(item.link);
      },
    );
  }
}
