import 'package:go_router/go_router.dart';
import 'package:push_noptification/presentation/screens/home_screen.dart';

final AppRoutes = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const HomeScreen(),
  )
]);
