// Basic Imports
import 'package:flutter/material.dart';

// UI Models
import '../../../domain/models/app_request.dart';

// Widgets
import '../../widgets/screen/scrollable_screen_top_action_bar.dart';
import '../../widgets/form_widgets/search_bar.dart';
import '../../widgets/requests/request_list_view.dart';

// Utils
import 'package:ug_mini_market/utils/constants.dart';

class RequestsListScreen extends StatefulWidget {
  final List<AppRequest> requests;

  const RequestsListScreen({required this.requests});

  @override
  RequestsListScreenState createState() => RequestsListScreenState();
}

class RequestsListScreenState extends State<RequestsListScreen> {
  @override
  Widget build(BuildContext context) {
    return ScrollableScreenWithTopActionBar(
      topActionBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            flex: 3,
            child: SearchBar(
              controller: TextEditingController(),
            ),
          ),
          Flexible(
            flex: 1,
            child: FloatingActionButton.extended(
              label: Text("Filtrar"),
              icon: Icon(Icons.filter_alt_rounded),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Expanded(
        child: RequestListView(
          requests: widget.requests,
        ),
      ),
    );
  }
}
