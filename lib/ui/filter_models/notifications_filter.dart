// Basic Imports
import 'package:flutter/material.dart';

class NotificationsFilter {
  final List<String> notificationTypes;
  int role, status;

  NotificationsFilter(
      {this.notificationTypes = const [], this.role = 2, this.status = 2});
}
