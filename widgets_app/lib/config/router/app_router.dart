import 'package:go_router/go_router.dart';
import 'package:widgets_app/config/theme/presentation/screens/theme_selection_screen.dart';
import 'package:widgets_app/counter/presentation/screens/counter_screen.dart';
import 'package:widgets_app/home/presentation/screens/home_screen.dart';
import 'package:widgets_app/widgets_feature/presentation/screens/animated_screens.dart';
import 'package:widgets_app/widgets_feature/presentation/screens/app_tutorial_scree.dart';
import 'package:widgets_app/widgets_feature/presentation/screens/buttons_screen.dart';
import 'package:widgets_app/widgets_feature/presentation/screens/cards_screen.dart';
import 'package:widgets_app/widgets_feature/presentation/screens/infinite_scroll_screen.dart';
import 'package:widgets_app/widgets_feature/presentation/screens/progress_screen.dart';
import 'package:widgets_app/widgets_feature/presentation/screens/snackbar_screen.dart';
import 'package:widgets_app/widgets_feature/presentation/screens/ui_controls_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: HomeScreen.name,
      path: '/',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      name: ButtonsScreen.name,
      path: '/buttons',
      builder: (context, state) => const ButtonsScreen(),
    ),
    GoRoute(
      name: CardsScreen.name,
      path: '/cards',
      builder: (context, state) => const CardsScreen(),
    ),
    GoRoute(
      name: ProgresScreen.name,
      path: '/progress',
      builder: (context, state) => const ProgresScreen(),
    ),
    GoRoute(
      name: SnackbarScreen.name,
      path: '/snackbar',
      builder: (context, state) => const SnackbarScreen(),
    ),
    GoRoute(
      name: AnimatedScreen.name,
      path: '/animated',
      builder: (context, state) => const AnimatedScreen(),
    ),
    GoRoute(
      name: UiControlsScreen.name,
      path: '/ui-controls',
      builder: (context, state) => const UiControlsScreen(),
    ),
    GoRoute(
      name: AppTutorialScreen.name,
      path: '/tutorial',
      builder: (context, state) => const AppTutorialScreen(),
    ),
    GoRoute(
      name: InfiniteScrollScreen.name,
      path: '/infinite-scroll',
      builder: (context, state) => const InfiniteScrollScreen(),
    ),
    GoRoute(
      name: CounterScreen.name,
      path: '/counter',
      builder: (context, state) => const CounterScreen(),
    ),
    GoRoute(
      name: ThemeSelectionScreen.name,
      path: '/theme-selection',
      builder: (context, state) => const ThemeSelectionScreen(),
    ),
  ],
);
