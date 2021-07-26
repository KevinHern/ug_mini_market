// Basic Imports
import 'package:flutter/material.dart';

// Backend
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class MyProductWidget extends StatelessWidget {
  // REPLACE THIS with a DocumentSnapshot!
  late final DocumentSnapshot? myProduct;
  MyProductWidget({@required this.myProduct});
}
