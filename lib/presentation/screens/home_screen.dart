import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:push_noptification/presentation/bloc/notification_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context
            .select((NotificationBloc bloc) => Text('${bloc.state.status}')),
        actions: [
          IconButton.outlined(
            onPressed: () {
              context.read<NotificationBloc>().requestAuthorization();
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notifications = context.watch<NotificationBloc>().state.notifications;
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return ListTile(
          title: Text(notification.tittle),
          subtitle: Text(notification.body),
          leading: notification.imageURL != null
              ? Image.network(notification.imageURL!)
              : null,
          onTap: () {
            context.push('/push-notificacion/${notification.messageID}');
          },
        );
      },
    );
  }
}
