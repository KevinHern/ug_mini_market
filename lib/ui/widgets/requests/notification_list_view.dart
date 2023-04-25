// Basic Imports
import 'package:flutter/material.dart';

// Widgets
import 'notification_tile_view.dart';

// Models
import '../../../domain/models/app_notification.dart';

// Utils
import 'package:ug_mini_market/utils/constants.dart';

class NotificationListView extends StatelessWidget {
  final List<AppNotification> notifications;

  const NotificationListView({required this.notifications});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: notifications.length,
      separatorBuilder: (context, index) => Divider(
        indent: dividerIndentPadding * dividerIndentListViewPaddingMultiplier,
        endIndent:
            dividerIndentPadding * dividerIndentListViewPaddingMultiplier,
      ),
      itemBuilder: (context, index) {
        return NotificationTileView(appNotification: notifications[index]);
      },
    );
  }
}
