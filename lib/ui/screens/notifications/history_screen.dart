// Basic Imports
import 'package:flutter/material.dart';

// Models
import '../../../domain/models/app_notification.dart';

// Widgets
import '../../widgets/requests/history_record_list_view.dart';
import 'package:ug_mini_market/ui/widgets/top_action_bars/history_top_action_bar.dart';
import '../../widgets/screen/scrollable_screen_top_action_bar.dart';

class HistoryScreen extends StatelessWidget {
  final List<AppNotification> appNotifications;

  const HistoryScreen({required this.appNotifications});

  @override
  Widget build(BuildContext context) {
    return ScrollableScreenWithTopActionBar(
      topActionBar: const HistoryTopActionBar(),
      body: Expanded(
        child: HistoryListView(
          notifications: appNotifications,
        ),
      ),
    );
  }
}
