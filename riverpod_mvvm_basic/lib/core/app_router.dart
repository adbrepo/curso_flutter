import 'package:go_router/go_router.dart';

import '../presentation/screens/note_details.dart';
import '../presentation/screens/notes_list.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: NotesListScreen.name,
      builder: (context, state) => const NotesListScreen(),
    ),
    GoRoute(
      path: '/note/:id',
      name: NoteDetailsScreen.name,
      builder: (context, state) => NoteDetailsScreen(
        noteId: int.tryParse(state.pathParameters['id'] ?? '') ?? -1,
      ),
    ),
  ],
);

class AppRouter {
  // Path parameters for the NoteDetailsScreen route.
  // The noteId is required to fetch the note details.
  static Map<String, String> noteDetailsParameters(int noteId) {
    return {'id': noteId.toString()};
  }
}
