// Basic Imports
import 'package:flutter/material.dart';
import 'package:ug_mini_market/models/ug_user.dart';
import 'package:provider/provider.dart';
import 'package:animated_widgets/animated_widgets.dart';

// Models
import 'package:ug_mini_market/models/navigation_model.dart';

// Routes
import 'package:ug_mini_market/screens/my_products/my_products_screen.dart';
import 'package:ug_mini_market/screens/profile.dart';
import 'package:ug_mini_market/screens/rating.dart';
import 'package:ug_mini_market/screens/feedback.dart';
import 'package:ug_mini_market/screens/market/market.dart';
import 'package:ug_mini_market/screens/market/product.dart';
import 'package:ug_mini_market/screens/my_products/transactions.dart';
import 'package:ug_mini_market/screens/my_products/product_form.dart';
import 'package:ug_mini_market/templates/dialog_template.dart';

// Templates
import 'package:ug_mini_market/templates/progress_dialog.dart';

// Backend
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainScreen extends StatelessWidget {
  final UGUser user;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  MainScreen({
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<NavigationModel>(
            create: (context) => NavigationModel(
                currentScreen: '/market', arguments: [this.user]),
          ),
          ChangeNotifierProvider<ValueNotifier<int>>(
            create: (context) => ValueNotifier<int>(4),
          ),
        ],
        child: Scaffold(
          key: this._scaffoldKey,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Text(
              'UG Market',
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          drawer: NavDrawer(
            user: this.user,
            scaffoldKey: this._scaffoldKey,
          ),
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Consumer<NavigationModel>(
              builder: (_, navigationModel, __) {
                return WillPopScope(
                  onWillPop: () async {
                    if (navigationModel.currentLevel > 1) {
                      navigationModel.popRoute();
                      return false;
                    } else {
                      bool logOut = await showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return BinaryAlert(
                                message: '¿Estás seguro que quieres salir?',
                                title: 'Aviso');
                          }).catchError((error) {
                        print('Error on Log Out dialog: ${error.toString()}');
                        return false;
                      });
                      if (logOut) {
                        ProgressDialog pd = ProgressDialog(
                          text: 'Cerrando sesión...',
                          progressDialogIndicator:
                              ProgressDialogIndicator.CIRCULAR,
                        );
                        pd.setProgressIndicatorStyle(width: 6.0);
                        pd.showProgressDialog(context: context);
                        await FirebaseAuth.instance.signOut();
                        pd.dismiss(context: context);

                        Navigator.popUntil(context, ModalRoute.withName('/'));
                        return true;
                      } else
                        return false;
                    }
                  },
                  child: SwitchScreen(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  /*@override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: PersistentTabView(
          context,
          controller: this._controller,
          screens: this._buildScreens(),
          items: this._navBarsItems(),
          confineInSafeArea: true,
          backgroundColor: Colors.white, // Default is Colors.white.
          handleAndroidBackButtonPress: true, // Default is true.
          resizeToAvoidBottomInset: true,
          hideNavigationBarWhenKeyboardShows: true,
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(10.0),
            colorBehindNavBar: Colors.white,
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: ItemAnimationProperties(
            // Navigation Bar's items animation properties.
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: ScreenTransitionAnimation(
            // Screen transition animation on change of selected tab.
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle
              .style9, // Choose the nav bar style with this property.
        ),
      ),
    );
  }*/
}

class NavDrawer extends StatelessWidget {
  final UGUser user;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final greyOpacity = 0.5;
  NavDrawer({required this.user, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0.0),
        children: [
          DrawerHeader(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Bienvenido',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.green,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/u_galileo.jpg'),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              color: Theme.of(context).primaryColorDark,
            ),
            title: Text(
              'Perfil',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            onTap: () {
              Navigator.of(context).pop();
              Provider.of<ValueNotifier<int>>(context, listen: false).value = 1;
              Provider.of<NavigationModel>(context, listen: false)
                  .clearThenPush(
                      route: NavigationModel.screens[0], arguments: null);
            },
            tileColor: (Provider.of<ValueNotifier<int>>(context, listen: false)
                        .value ==
                    1)
                ? Theme.of(context).primaryColorLight.withOpacity(greyOpacity)
                : null,
          ),
          ListTile(
            leading: Icon(
              Icons.inbox,
              color: Theme.of(context).primaryColorDark,
            ),
            title: Text('Inbox'),
            onTap: () {
              Navigator.of(context).pop();
              Provider.of<ValueNotifier<int>>(context, listen: false).value = 2;
              Provider.of<NavigationModel>(context, listen: false)
                  .clearThenPush(
                      route: NavigationModel.screens[1], arguments: null);
            },
            tileColor: (Provider.of<ValueNotifier<int>>(context, listen: false)
                        .value ==
                    2)
                ? Theme.of(context).primaryColorLight.withOpacity(greyOpacity)
                : null,
          ),
          ListTile(
            leading: Icon(
              Icons.shopping_bag,
              color: Theme.of(context).primaryColorDark,
            ),
            title: Text('Mis Productos'),
            onTap: () {
              Navigator.of(context).pop();
              Provider.of<ValueNotifier<int>>(context, listen: false).value = 3;
              Provider.of<NavigationModel>(context, listen: false)
                  .clearThenPush(
                      route: NavigationModel.screens[2], arguments: null);
            },
            tileColor: (Provider.of<ValueNotifier<int>>(context, listen: false)
                        .value ==
                    3)
                ? Theme.of(context).primaryColorLight.withOpacity(greyOpacity)
                : null,
          ),
          ListTile(
            leading: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).primaryColorDark,
            ),
            title: Text('Mercado'),
            onTap: () {
              Navigator.of(context).pop();
              Provider.of<ValueNotifier<int>>(context, listen: false).value = 4;
              Provider.of<NavigationModel>(context, listen: false)
                  .clearThenPush(
                      route: NavigationModel.screens[3], arguments: null);
            },
            tileColor: (Provider.of<ValueNotifier<int>>(context, listen: false)
                        .value ==
                    4)
                ? Theme.of(context).primaryColorLight.withOpacity(greyOpacity)
                : null,
          ),
          ListTile(
            leading: Icon(
              Icons.star,
              color: Theme.of(context).primaryColorDark,
            ),
            title: Text('Calificar'),
            onTap: () {
              Navigator.of(context).pop();
              Provider.of<ValueNotifier<int>>(context, listen: false).value = 5;
              Provider.of<NavigationModel>(context, listen: false)
                  .clearThenPush(
                      route: NavigationModel.screens[7], arguments: null);
            },
            tileColor: (Provider.of<ValueNotifier<int>>(context, listen: false)
                        .value ==
                    5)
                ? Theme.of(context).primaryColorLight.withOpacity(greyOpacity)
                : null,
          ),
          ListTile(
            leading: Icon(
              Icons.email,
              color: Theme.of(context).primaryColorDark,
            ),
            title: Text('Feedback'),
            onTap: () {
              Navigator.of(context).pop();
              Provider.of<ValueNotifier<int>>(context, listen: false).value = 6;
              Provider.of<NavigationModel>(context, listen: false)
                  .clearThenPush(
                      route: NavigationModel.screens[4], arguments: null);
            },
            tileColor: (Provider.of<ValueNotifier<int>>(context, listen: false)
                        .value ==
                    6)
                ? Theme.of(context).primaryColorLight.withOpacity(greyOpacity)
                : null,
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Theme.of(context).primaryColorDark,
            ),
            title: Text('Logout'),
            onTap: () async {
              bool logOut = await showDialog(
                  context: context,
                  builder: (dialogContext) {
                    return BinaryAlert(
                        message: '¿Estás seguro que quieres salir?',
                        title: 'Aviso');
                  }).catchError((error) {
                print('Error on Log Out dialog: ${error.toString()}');
                return false;
              });
              if (logOut) {
                ProgressDialog pd = ProgressDialog(
                  text: 'Cerrando sesión...',
                  progressDialogIndicator: ProgressDialogIndicator.CIRCULAR,
                );
                pd.setProgressIndicatorStyle(width: 6.0);
                pd.showProgressDialog(context: context);
                await FirebaseAuth.instance.signOut();
                pd.dismiss(context: context);

                Navigator.popUntil(context, ModalRoute.withName('/'));
              }
            },
          ),
        ],
      ),
    );
  }
}

class SwitchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationModel>(builder: (_, navigationModel, __) {
      switch (navigationModel.currentScreen) {
        case '/profile':
          return TranslationAnimatedWidget.tween(
            enabled: true,
            translationDisabled: Offset(200, 0),
            translationEnabled: Offset(0, 0),
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInCubic,
            child: OpacityAnimatedWidget.tween(
              enabled: true,
              opacityDisabled: 0,
              opacityEnabled: 1,
              child: UserInformationScreen(
                user: navigationModel.arguments[0] as UGUser,
              ),
            ),
          );
        case '/inbox':
          return TranslationAnimatedWidget.tween(
            enabled: true,
            translationDisabled: Offset(200, 0),
            translationEnabled: Offset(0, 0),
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInCubic,
            child: OpacityAnimatedWidget.tween(
              enabled: true,
              opacityDisabled: 0,
              opacityEnabled: 1,
              child: TransactionsScreen(
                user: navigationModel.arguments[0] as UGUser,
              ),
            ),
          );
        case '/products':
          return TranslationAnimatedWidget.tween(
            enabled: true,
            translationDisabled: Offset(200, 0),
            translationEnabled: Offset(0, 0),
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInCubic,
            child: OpacityAnimatedWidget.tween(
              enabled: true,
              opacityDisabled: 0,
              opacityEnabled: 1,
              child: MyProductsScreen(
                user: navigationModel.arguments[0] as UGUser,
              ),
            ),
          );
        case '/myproduct':
          return TranslationAnimatedWidget.tween(
            enabled: true,
            translationDisabled: Offset(200, 0),
            translationEnabled: Offset(0, 0),
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInCubic,
            child: OpacityAnimatedWidget.tween(
              enabled: true,
              opacityDisabled: 0,
              opacityEnabled: 1,
              child: ProductScreen(
                user: navigationModel.arguments[0] as UGUser,
                isCreating: navigationModel.arguments[1] as bool,
                myProduct: navigationModel.arguments[2] as DocumentSnapshot?,
              ),
            ),
          );
        case '/market':
          return TranslationAnimatedWidget.tween(
            enabled: true,
            translationDisabled: Offset(200, 0),
            translationEnabled: Offset(0, 0),
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInCubic,
            child: OpacityAnimatedWidget.tween(
              enabled: true,
              opacityDisabled: 0,
              opacityEnabled: 1,
              child: UGMarket(
                user: navigationModel.arguments[0] as UGUser,
              ),
            ),
          );
        case '/product':
          return TranslationAnimatedWidget.tween(
            enabled: true,
            translationDisabled: Offset(200, 0),
            translationEnabled: Offset(0, 0),
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInCubic,
            child: OpacityAnimatedWidget.tween(
              enabled: true,
              opacityDisabled: 0,
              opacityEnabled: 1,
              child: ProductInformationScreen(
                user: navigationModel.arguments[0] as UGUser,
                product: navigationModel.arguments[1] as DocumentSnapshot,
              ),
            ),
          );
        case '/rating':
          return TranslationAnimatedWidget.tween(
            enabled: true,
            translationDisabled: Offset(200, 0),
            translationEnabled: Offset(0, 0),
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInCubic,
            child: OpacityAnimatedWidget.tween(
              enabled: true,
              opacityDisabled: 0,
              opacityEnabled: 1,
              child: RatingScreen(
                user: navigationModel.arguments[0] as UGUser,
              ),
            ),
          );
        case '/feedback':
          return FeedbackScreen(
            user: navigationModel.arguments[0] as UGUser,
          );
        default:
          throw Exception('Unreachable State');
      }
    });
  }
}
