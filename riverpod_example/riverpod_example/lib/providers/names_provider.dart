import 'package:flutter_riverpod/flutter_riverpod.dart';

StateProvider<List<String>> namesProvider = StateProvider((ref) => [
      'John',
    ]);
