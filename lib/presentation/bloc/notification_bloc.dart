import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:push_noptification/domain/entities/push_message.dart';

part 'notification_state.dart';
part 'notification_event.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationBloc() : super(NotificationState()) {
    on<NotificationStatusChanged>(_notificationStatusChanged);
    on<NotificationReceived>(_onPushMessageReceived);
    _initialStatusCheck();
    _onForegroundMessage();
  }

  void _notificationStatusChanged(
      NotificationStatusChanged event, Emitter<NotificationState> emmit) {
    emit(state.copyWith(status: event.status));
    _getFCMToken();
  }

  void _onPushMessageReceived(
      NotificationReceived event, Emitter<NotificationState> emmit) {
    emit(
        state.copyWith(notifications: [event.message, ...state.notifications]));
  }

  void _initialStatusCheck() async {
    final settings = await messaging.getNotificationSettings();
    add(NotificationStatusChanged(settings.authorizationStatus));
  }

  void _getFCMToken() async {
    if (state.status != AuthorizationStatus.authorized) return;
    final token = await messaging.getToken();
    //print(token);
  }

  void _handleRemoteMessages(RemoteMessage message) {
    if (message.notification == null) return;
    final notificacion = PushMessage(
        messageID:
            message.messageId?.replaceAll(':', '').replaceAll('%', '') ?? '',
        tittle: message.notification!.title ?? '',
        body: message.notification!.body ?? '',
        sentDate: message.sentTime ?? DateTime.now(),
        data: message.data,
        imageURL: Platform.isAndroid
            ? message.notification!.android?.imageUrl
            : message.notification!.apple?.imageUrl);

    add(NotificationReceived(notificacion));
  }

  void _onForegroundMessage() {
    FirebaseMessaging.onMessage.listen(_handleRemoteMessages);
  }

  void requestAuthorization() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    add(NotificationStatusChanged(settings.authorizationStatus));
  }
}
