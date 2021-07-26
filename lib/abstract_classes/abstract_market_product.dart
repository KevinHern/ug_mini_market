// Basic Imports
import 'package:flutter/material.dart';

// Models
import 'package:ug_mini_market/models/ug_user.dart';

// Backend
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class MarketProductWidget extends StatelessWidget {
  // REPLACE THIS with a DocumentSnapshot!
  final DocumentSnapshot? product;
  final UGUser user;
  MarketProductWidget({required this.user, @required this.product});
}
