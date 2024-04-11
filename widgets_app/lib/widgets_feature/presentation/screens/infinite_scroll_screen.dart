import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class InfiniteScrollScreen extends StatefulWidget {
  static const name = 'infinite_scroll_screen';
  const InfiniteScrollScreen({super.key});

  @override
  State<InfiniteScrollScreen> createState() => _InfiniteScrollScreenState();
}

class _InfiniteScrollScreenState extends State<InfiniteScrollScreen> {
  List<int> imagesIds = [1, 2, 3, 4, 5];
  final ScrollController _scrollController = ScrollController();

  bool isLoading = false;
  bool isMounted = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 500) {
        loadNextPage();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    isMounted = false;
    super.dispose();
  }

  void addFiveImages() {
    final lastId = imagesIds.last;
    imagesIds.addAll([1, 2, 3, 4, 5].map((e) => e + lastId).toList());
  }

  Future loadNextPage() async {
    if (isLoading) return;
    isLoading = true;
    setState(() {});

    await Future.delayed(const Duration(seconds: 2));
    addFiveImages();
    isLoading = false;
    setState(() {});
    scrollToBottom();
  }

  Future<void> onRefresh() async {
    isLoading = true;
    if (!isMounted) return;
    setState(() {});
    await Future.delayed(const Duration(seconds: 2));
    final lastId = imagesIds.last;
    imagesIds.clear();
    imagesIds.addAll([1, 2, 3, 4, 5].map((e) => e + lastId).toList());
    isLoading = false;
    setState(() {});
  }

  void scrollToBottom() {
    if (_scrollController.position.pixels <=
        _scrollController.position.maxScrollExtent - 100) return;
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 120,
      duration: const Duration(milliseconds: 250),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: RefreshIndicator(
        edgeOffset: 30,
        onRefresh: onRefresh,
        child: _InfiniteScrollView(
          imagesIds: imagesIds,
          scrollController: _scrollController,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!isLoading) Navigator.pop(context);
        },
        child: !isLoading
            ? const Icon(Icons.arrow_back)
            : SpinPerfect(
                infinite: true,
                child: const Icon(Icons.refresh_rounded),
              ),
      ),
    );
  }
}

// ignore: must_be_immutable
class _InfiniteScrollView extends StatelessWidget {
  _InfiniteScrollView(
      {required this.imagesIds, required this.scrollController});

  List<int> imagesIds;
  ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      child: ListView.builder(
        controller: scrollController,
        itemCount: imagesIds.length,
        itemBuilder: (context, index) {
          return _ListItem(imagesIds: imagesIds, index: index);
        },
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  const _ListItem({
    required this.imagesIds,
    required this.index,
  });

  final List<int> imagesIds;
  final int index;

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      fit: BoxFit.cover,
      width: double.infinity,
      height: 300,
      placeholder: const AssetImage('assets/images/jar-loading.gif'),
      image: NetworkImage(
          'https://picsum.photos/id/${imagesIds[index].toString()}/500/300/'),
    );
  }
}
