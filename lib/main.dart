import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:push_noptification/config/app_routes.dart';
import 'package:push_noptification/config/app_theme.dart';
import 'package:push_noptification/domain/interaction/handle_interaction.dart';
import 'package:push_noptification/firebase_options.dart';
import 'package:push_noptification/presentation/bloc/notification_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiBlocProvider(
      providers: [BlocProvider(create: (_) => NotificationBloc())],
      child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme().getTheme(),
      routerConfig: AppRoutes,
      builder: (context, child) => HandleNotificationInteraction(child: child!),
    );
  }
}
