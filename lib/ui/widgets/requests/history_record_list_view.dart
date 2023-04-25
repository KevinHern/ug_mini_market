// Basic Imports
import 'package:flutter/material.dart';

// Widgets
import 'history_record_tile_view.dart';

// Models
import '../../../domain/models/app_notification.dart';

// Utils
import 'package:ug_mini_market/utils/constants.dart';

class HistoryListView extends StatelessWidget {
  final List<AppNotification> notifications;

  const HistoryListView({required this.notifications});

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
        return HistoryRecordTileView(appNotification: notifications[index]);
      },
    );
  }
}
