import 'package:flutter/material.dart';

const cards = <Map<String, dynamic>>[
  {'elevation': 0.0, 'label': 'elevation 0'},
  {'elevation': 1.0, 'label': 'elevation 1'},
  {'elevation': 2.0, 'label': 'elevation 2'},
  {'elevation': 3.0, 'label': 'elevation 3'},
  {'elevation': 4.0, 'label': 'elevation 4'},
  {'elevation': 5.0, 'label': 'elevation 5'},
];

class CardsScreen extends StatelessWidget {
  static const name = 'cards_screen';
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cards'),
      ),
      body: const _CardsView(),
    );
  }
}

class _CardsView extends StatelessWidget {
  const _CardsView();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...cards.map((card) =>
              CardType1(elevation: card['elevation'], label: card['label'])),
          ...cards.map((card) =>
              CardType2(elevation: card['elevation'], label: card['label'])),
          const SizedBox(height: 50),
          ...cards.map((card) =>
              CardType3(elevation: card['elevation'], label: card['label'])),
          ...cards.map((card) =>
              CardType4(elevation: card['elevation'], label: card['label'])),
          const SizedBox(height: 50)
        ],
      ),
    );
  }
}

class CardType1 extends StatelessWidget {
  final double elevation;
  final String label;

  const CardType1({
    super.key,
    required this.elevation,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
        child: Column(
          children: [
            Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.more_vert_outlined),
                  onPressed: () {},
                )),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}

class CardType2 extends StatelessWidget {
  final double elevation;
  final String label;

  const CardType2({
    super.key,
    required this.elevation,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: colors.outline,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: elevation,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
        child: Column(
          children: [
            Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.more_vert_outlined),
                  onPressed: () {},
                )),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text('$label - outlined '),
            ),
          ],
        ),
      ),
    );
  }
}

class CardType3 extends StatelessWidget {
  final double elevation;
  final String label;

  const CardType3({
    super.key,
    required this.elevation,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      color: colors.surfaceVariant,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: colors.outline,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: elevation,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
        child: Column(
          children: [
            Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.more_vert_outlined),
                  onPressed: () {},
                )),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text('$label - filled '),
            ),
          ],
        ),
      ),
    );
  }
}

class CardType4 extends StatelessWidget {
  final double elevation;
  final String label;

  const CardType4({
    super.key,
    required this.elevation,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: elevation,
      child: Stack(
        children: [
          Image.network(
            'https://picsum.photos/id/${elevation.toInt()}/600/350',
            height: 350,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(12))),
              child: IconButton(
                icon: const Icon(Icons.more_vert_outlined),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
