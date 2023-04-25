// Basic Imports
import 'package:flutter/material.dart';

// Models
import 'package:ug_mini_market/domain/models/app_notification.dart';
import 'package:ug_mini_market/domain/models/app_request.dart';

class RequestTileView extends StatelessWidget {
  final AppRequest appRequest;

  const RequestTileView({required this.appRequest});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset("assets/${appRequest.icon}"),
      title: Text("${appRequest.title} (${appRequest.lastModification})"),
      subtitle: Text(
          "${appRequest.description}\n\nStatus: ${appRequest.requestStatus}"),
      trailing: Icon(Icons.warning),
      onTap: () {},
    );
  }
}
