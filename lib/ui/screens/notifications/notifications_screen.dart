// Basic Imports
import 'package:flutter/material.dart';

// Models
import '../../../domain/models/app_notification.dart';

// Widgets
import '../../widgets/requests/notification_list_view.dart';
import 'package:ug_mini_market/ui/widgets/top_action_bars/notifications_top_action_bar.dart';
import '../../widgets/screen/scrollable_screen_top_action_bar.dart';

class InboxNotificationsScreen extends StatelessWidget {
  final List<AppNotification> appNotifications;

  const InboxNotificationsScreen({required this.appNotifications});

  @override
  Widget build(BuildContext context) {
    return ScrollableScreenWithTopActionBar(
      topActionBar: const NotificationsTopActionBar(),
      body: Expanded(
        child: NotificationListView(
          notifications: appNotifications,
        ),
      ),
    );
  }
}
