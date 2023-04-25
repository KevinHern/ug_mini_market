// Basic Imports
import 'package:flutter/material.dart';
import 'package:ug_mini_market/domain/models/app_request.dart';

// Widgets
import 'request_tile_view.dart';

// Models
import '../../../domain/models/app_notification.dart';

// Utils
import 'package:ug_mini_market/utils/constants.dart';

class RequestListView extends StatelessWidget {
  final List<AppRequest> requests;

  const RequestListView({required this.requests});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: requests.length,
      separatorBuilder: (context, index) => Divider(
        indent: dividerIndentPadding * dividerIndentListViewPaddingMultiplier,
        endIndent:
            dividerIndentPadding * dividerIndentListViewPaddingMultiplier,
      ),
      itemBuilder: (context, index) {
        return RequestTileView(appRequest: requests[index]);
      },
    );
  }
}
