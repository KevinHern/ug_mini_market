// Basic Imports
import 'package:flutter/material.dart';

// Widgets
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

// Utils
import 'package:ug_mini_market/utils/constants.dart';

// Screens
import '../../screens/notifications/history_screen.dart';
import '../../screens/notifications/notifications_filter_screen.dart';
import '../../screens/notifications/notifications_screen.dart';
import '../../screens/market/product_details_screen.dart';
import '../../screens/market/product_filter_screen.dart';
import '../../screens/market/products_screen.dart';
import '../../screens/market/product_request_creation_screen.dart';
import '../../screens/my_products/add_new_product_screen.dart';
import '../../screens/my_products/my_products_screen.dart';
import '../../screens/my_products/update_product_screen.dart';
import '../../screens/my_screen/my_profile_screen.dart';
import '../../screens/my_screen/update_form_screen.dart';
import '../../screens/profile/profile_screen.dart';
import '../../screens/requests/request_details_screen.dart';
import '../../screens/requests/request_filter_screen.dart';
import '../../screens/requests/requests_screen.dart';

class ScreenLayout extends StatefulWidget {
  @override
  ScreenLayoutState createState() => ScreenLayoutState();
}

class ScreenLayoutState extends State<ScreenLayout> {
  int selectedNavigation = 0;

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      // An option to override the default breakpoints used for small, medium,
      // and large.
      appBar: AppBar(
        title: Text("UG Market"),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: IconButton(
                onPressed: () => {}, icon: Icon(Icons.account_circle_rounded)),
          ),
        ],
      ),
      useDrawer: true,
      selectedIndex: selectedNavigation,
      onSelectedIndexChange: (int index) {
        setState(() {
          selectedNavigation = index;
        });
      },
      destinations: menuOptions
          .map((e) => NavigationDestination(
                icon: Icon(e[1]),
                label: e[0],
              ))
          .toList(),
      body: (_) => Padding(
        padding: EdgeInsets.all(screenPadding),
        // child: MyProfileScreen(
        //   ugUser: dummyUGUser,
        // ),
        child: RequestFilteringScreen(
          requestsFilter: dummyRequestsFilter,
        ),
      ),
      //smallBody: (_) => Container(),
      // Define a default secondaryBody.
      // secondaryBody: (_) => Container(
      //   color: const Color.fromARGB(255, 234, 158, 192),
      // ),
      // Override the default secondaryBody during the smallBreakpoint to be
      // empty. Must use AdaptiveScaffold.emptyBuilder to ensure it is properly
      // overridden.
      smallSecondaryBody: AdaptiveScaffold.emptyBuilder,
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return AdaptiveLayout(
  //     primaryNavigation: SlotLayout(
  //       config: <Breakpoint, SlotLayoutConfig>{
  //         Breakpoints.medium: SlotLayout.from(
  //           inAnimation: AdaptiveScaffold.leftOutIn,
  //           key: const Key('Primary Navigation Medium'),
  //           builder: (_) => AdaptiveScaffold.standardNavigationRail(
  //             selectedIndex: selectedNavigation,
  //             onDestinationSelected: (int newIndex) {
  //               setState(() {
  //                 selectedNavigation = newIndex;
  //               });
  //             },
  //             destinations: menuOptions
  //                 .map((e) => NavigationDestination(
  //                       icon: Icon(e[1]),
  //                       label: e[0],
  //                     ))
  //                 .map((_) => AdaptiveScaffold.toRailDestination(_))
  //                 .toList(),
  //             // backgroundColor: navRailTheme.backgroundColor,
  //             // selectedIconTheme: navRailTheme.selectedIconTheme,
  //             // unselectedIconTheme: navRailTheme.unselectedIconTheme,
  //             // selectedLabelTextStyle: navRailTheme.selectedLabelTextStyle,
  //             // unSelectedLabelTextStyle: navRailTheme.unselectedLabelTextStyle,
  //           ),
  //         ),
  //         Breakpoints.large: SlotLayout.from(
  //           key: const Key('Primary Navigation Large'),
  //           inAnimation: AdaptiveScaffold.leftOutIn,
  //           builder: (_) => AdaptiveScaffold.standardNavigationRail(
  //             selectedIndex: selectedNavigation,
  //             onDestinationSelected: (int newIndex) {
  //               setState(() {
  //                 selectedNavigation = newIndex;
  //               });
  //             },
  //             extended: true,
  //             leading: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
  //               children: const <Widget>[
  //                 Text(
  //                   'MENU',
  //                   style: TextStyle(color: Color.fromARGB(255, 255, 201, 197)),
  //                 ),
  //                 Icon(Icons.menu_open)
  //               ],
  //             ),
  //             destinations: menuOptions
  //                 .map((e) => NavigationDestination(
  //                       icon: Icon(e[1]),
  //                       label: e[0],
  //                     ))
  //                 .map((_) => AdaptiveScaffold.toRailDestination(_))
  //                 .toList(),
  //             // trailing: trailingNavRail,
  //             // backgroundColor: navRailTheme.backgroundColor,
  //             // selectedIconTheme: navRailTheme.selectedIconTheme,
  //             // unselectedIconTheme: navRailTheme.unselectedIconTheme,
  //             // selectedLabelTextStyle: navRailTheme.selectedLabelTextStyle,
  //             // unSelectedLabelTextStyle: navRailTheme.unselectedLabelTextStyle,
  //           ),
  //         ),
  //       },
  //     ),
  //     body: MyProfile(),
  //   );
  // }
}
