import 'package:go_router/go_router.dart';
import 'package:push_noptification/presentation/screens/detail_screed.dart';
import 'package:push_noptification/presentation/screens/home_screen.dart';

final AppRoutes = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    path: '/push-notificacion/:messageID',
    builder: (context, state) =>
        DetailScreen(messageID: state.pathParameters['messageID'] ?? ''),
  )
]);
