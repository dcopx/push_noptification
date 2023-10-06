import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:push_noptification/domain/entities/push_message.dart';
import 'package:push_noptification/presentation/bloc/notification_bloc.dart';

class DetailScreen extends StatelessWidget {
  final String messageID;
  const DetailScreen({super.key, required this.messageID});

  @override
  Widget build(BuildContext context) {
    final PushMessage? message =
        context.watch<NotificationBloc>().getMessageByID(messageID);
    return Scaffold(
      body: message != null
          ? _DetailView(pushMessage: message)
          : const Center(
              child: Text('No existe notificación'),
            ),
    );
  }
}

class _DetailView extends StatelessWidget {
  PushMessage pushMessage;
  _DetailView({required this.pushMessage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          if (pushMessage.imageURL != null)
            Image.network(pushMessage.imageURL!),
          Text(pushMessage.tittle)
        ],
      ),
    );
  }
}
