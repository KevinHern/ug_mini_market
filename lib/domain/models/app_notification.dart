// Utils
import 'package:intl/intl.dart';
import '../../utils/constants.dart';

abstract class AppNotification {
  final String _notificationTitle, _description;
  final int _timestamp;
  bool _read;
  String? _firestoreId;

  final NotificationType _notificationType;
  AppNotification(
      {required NotificationType notificationType,
      required String notificationTitle,
      required String description,
      required int timestamp,
      required bool read,
      String? firestoreId})
      : _notificationType = notificationType,
        _notificationTitle = notificationTitle,
        _description = description,
        _timestamp = timestamp,
        _read = read,
        _firestoreId = firestoreId;

  // Setters
  set read(value) => _read = read;

  // Getters
  String get title => _notificationTitle;
  String get description => _description;
  int get timestamp => _timestamp;
  bool get read => _read;

  // Complex Getters
  String get date => DateFormat('dd/MM/yyyy').format(DateTime.now());
  String get icon;
}

class InfoNotification extends AppNotification {
  InfoNotification(
      {required super.notificationTitle,
      required super.description,
      required super.timestamp,
      required super.read,
      super.firestoreId})
      : super(notificationType: NotificationType.INFO);

  @override
  String get icon => "info_40p.png";
}

class ImportantNotification extends AppNotification {
  ImportantNotification(
      {required super.notificationTitle,
      required super.description,
      required super.timestamp,
      required super.read,
      super.firestoreId})
      : super(notificationType: NotificationType.IMPORTANT);

  @override
  String get icon => "important_40p.png";
}

class ConfirmNotification extends AppNotification {
  ConfirmNotification(
      {required super.notificationTitle,
      required super.description,
      required super.timestamp,
      required super.read,
      super.firestoreId})
      : super(notificationType: NotificationType.CONFIRM);

  @override
  String get icon => "confirm_40p.png";
}

class RejectNotification extends AppNotification {
  RejectNotification(
      {required super.notificationTitle,
      required super.description,
      required super.timestamp,
      required super.read,
      super.firestoreId})
      : super(notificationType: NotificationType.CANCEL);

  @override
  String get icon => "cancel_40p.png";
}
