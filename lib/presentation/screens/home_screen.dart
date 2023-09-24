import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return ListView.builder(
      itemCount: 0,
      itemBuilder: (context, index) {
        return const ListTile();
      },
    );
  }
}
