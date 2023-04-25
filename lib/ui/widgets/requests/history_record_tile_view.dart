// Basic Imports
import 'package:flutter/material.dart';

// Models
import 'package:ug_mini_market/domain/models/app_notification.dart';

class HistoryRecordTileView extends StatelessWidget {
  final AppNotification appNotification;

  const HistoryRecordTileView({required this.appNotification});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset("assets/${appNotification.icon}"),
      title: Text("${appNotification.title} (${appNotification.date})"),
      subtitle: Text(appNotification.description),
    );
  }
}
