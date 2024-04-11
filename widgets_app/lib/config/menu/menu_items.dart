import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final String link;

  const MenuItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.link,
  });
}

const List<MenuItem> menuItems = [
  MenuItem(
      title: 'Counter',
      subtitle: 'Riverpod counter',
      icon: Icons.add_circle_outline_outlined,
      link: '/counter'),
  MenuItem(
      title: 'Buttons',
      subtitle: 'Different types of buttons',
      icon: Icons.smart_button_outlined,
      link: '/buttons'),
  MenuItem(
      title: 'Cards',
      subtitle: 'Different types of cards',
      icon: Icons.credit_card_off_outlined,
      link: '/cards'),
  MenuItem(
      title: 'Progress indicators',
      subtitle: 'Generals and controlled',
      icon: Icons.refresh_outlined,
      link: '/progress'),
  MenuItem(
      title: 'SnackBars & Dialogs',
      subtitle: 'Different types of snackbars and dialogs',
      icon: Icons.info_outline_rounded,
      link: '/snackbar'),
  MenuItem(
      title: 'Animated Container',
      subtitle: 'Different types of animations',
      icon: Icons.animation_outlined,
      link: '/animated'),
  MenuItem(
      title: 'Ui Controls',
      subtitle: 'Different types of animations',
      icon: Icons.car_rental_outlined,
      link: '/ui-controls'),
  MenuItem(
      title: 'Tutorial',
      subtitle: 'Different types of animations',
      icon: Icons.help_center_outlined,
      link: '/tutorial'),
  MenuItem(
      title: 'InfiniteScroll & Pull',
      subtitle: 'Infinite scroll and pull to refresh',
      icon: Icons.list_alt_outlined,
      link: '/infinite-scroll'),
  MenuItem(
      title: 'Theme selections',
      subtitle: 'Choose your theme',
      icon: Icons.color_lens_outlined,
      link: '/theme-selection'),
];
