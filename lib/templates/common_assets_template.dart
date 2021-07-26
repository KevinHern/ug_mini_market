// Basic Imports
import 'package:flutter/material.dart';

enum FitTextStyle { H1, H2, H3, H4, H5, H6, S1, S2, B1, B2 }

class CommonFunctions {
  static double setContainerWidth({required BuildContext context}) {
    final double width = MediaQuery.of(context).size.width;

    // Media Query x-large & large devices breakpoint
    if (width >= 1200) {
      return width * 0.6;
    } else if (width >= 992) {
      return width * 0.7;
    } else if (width >= 768) {
      return width * 0.8;
    } else {
      return width;
    }
  }

  static double setContainerHeight({required BuildContext context}) {
    final double height = MediaQuery.of(context).size.width;

    // Media Query x-large & large devices breakpoint
    if (height >= 1200) {
      return height * 0.6;
    } else if (height >= 992) {
      return height * 0.7;
    } else if (height >= 768) {
      return height * 0.8;
    } else {
      return height;
    }
  }
}

class WrapText extends StatelessWidget {
  final String text;
  final TextAlign textAlignment;
  final FitTextStyle fitTextStyle;
  const WrapText(
      {required this.text,
      required this.fitTextStyle,
      this.textAlignment = TextAlign.left});

  TextStyle _getTheme(BuildContext context) {
    switch (this.fitTextStyle) {
      case FitTextStyle.H1:
        return Theme.of(context).textTheme.headline1!;
      case FitTextStyle.H2:
        return Theme.of(context).textTheme.headline2!;
      case FitTextStyle.H3:
        return Theme.of(context).textTheme.headline3!;
      case FitTextStyle.B1:
        return Theme.of(context).textTheme.bodyText1!;
      case FitTextStyle.S1:
        return Theme.of(context).textTheme.subtitle1!;
      case FitTextStyle.B2:
        return Theme.of(context).textTheme.bodyText2!;
      case FitTextStyle.S2:
        return Theme.of(context).textTheme.subtitle2!;
      case FitTextStyle.H4:
        return Theme.of(context).textTheme.headline4!;
      case FitTextStyle.H5:
        return Theme.of(context).textTheme.headline5!;
      case FitTextStyle.H6:
        return Theme.of(context).textTheme.headline6!;
      default:
        throw Exception('Unreachable State');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          child: Text(
            this.text,
            style: this._getTheme(context),
            textAlign: this.textAlignment,
          ),
        ),
      ],
    );
  }
}

class FitText extends StatelessWidget {
  final String text;
  final TextAlign textAlignment;
  final Alignment fitAlignment;
  final FitTextStyle fitTextStyle;
  const FitText(
      {required this.text,
      required this.fitTextStyle,
      this.textAlignment = TextAlign.center,
      this.fitAlignment = Alignment.center});

  TextStyle _getTheme(BuildContext context) {
    switch (this.fitTextStyle) {
      case FitTextStyle.H1:
        return Theme.of(context).textTheme.headline1!;
      case FitTextStyle.H2:
        return Theme.of(context).textTheme.headline2!;
      case FitTextStyle.H3:
        return Theme.of(context).textTheme.headline3!;
      case FitTextStyle.B1:
        return Theme.of(context).textTheme.bodyText1!;
      case FitTextStyle.S1:
        return Theme.of(context).textTheme.subtitle1!;
      case FitTextStyle.B2:
        return Theme.of(context).textTheme.bodyText2!;
      case FitTextStyle.S2:
        return Theme.of(context).textTheme.subtitle2!;
      case FitTextStyle.H4:
        return Theme.of(context).textTheme.headline4!;
      case FitTextStyle.H5:
        return Theme.of(context).textTheme.headline5!;
      case FitTextStyle.H6:
        return Theme.of(context).textTheme.headline6!;
      default:
        throw Exception('Unreachable State');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      alignment: this.fitAlignment,
      fit: BoxFit.scaleDown,
      child: Text(
        this.text,
        style: this._getTheme(context),
        textAlign: this.textAlignment,
      ),
    );
  }
}

class AccentButton extends StatelessWidget {
  final String? text;
  final IconData icon;
  final Function onPressed;
  final Color? buttonColor;
  const AccentButton({
    required this.icon,
    this.text,
    this.buttonColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return (this.text == null)
        ? ElevatedButton(
            onPressed: () => this.onPressed(),
            child: Icon(
              this.icon,
              color: Colors.white.withOpacity(0.8),
            ),
            style: (this.buttonColor == null)
                ? null
                : ElevatedButton.styleFrom(
                    primary: this.buttonColor,
                    shadowColor: Colors.grey,
                  ),
          )
        : ElevatedButton.icon(
            onPressed: () => this.onPressed(),
            icon: Icon(
              this.icon,
              color: Colors.white.withOpacity(0.8),
            ),
            label: Text(
              this.text!,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          );
  }
}

class FormattedListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Alignment titleAlign;
  final TextAlign titleTextAlign;
  final IconData? leadingIcon, buttonIcon;
  final Color? buttonColor;
  final EdgeInsets? padding;
  final Function? onPressed, tileOnTap;
  const FormattedListTile(
      {required this.title,
      this.titleAlign = Alignment.centerLeft,
      this.titleTextAlign = TextAlign.left,
      this.subtitle,
      this.leadingIcon,
      this.buttonIcon,
      this.buttonColor,
      this.padding,
      this.onPressed,
      this.tileOnTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: this.padding,
      leading: (this.leadingIcon == null)
          ? null
          : Container(
              height: double.infinity,
              child: Icon(
                this.leadingIcon,
                color: Theme.of(context).accentColor,
                size: 40,
              ),
            ),
      title: FitText(
        text: this.title,
        fitTextStyle: FitTextStyle.H3,
        fitAlignment: this.titleAlign,
        textAlignment: this.titleTextAlign,
      ),
      onTap: () => this.tileOnTap,
      subtitle: (this.subtitle == null)
          ? null
          : FitText(
              text: this.subtitle!,
              fitTextStyle: FitTextStyle.B1,
              fitAlignment: Alignment.centerLeft,
              textAlignment: TextAlign.left,
            ),
      trailing: (this.buttonIcon == null)
          ? null
          : ElevatedButton(
              child: Icon(
                this.buttonIcon,
                color: this.buttonColor,
              ),
              onPressed: () => this.onPressed,
            ),
    );
  }
}

class DecorativeTile extends StatelessWidget {
  const DecorativeTile({
    Key? key,
    required this.child,
    this.borderRadius = 16.0,
    this.padding = 10.0,
  }) : super(key: key);

  final Widget child;
  final double borderRadius, padding;

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(borderRadius),
        shadowColor: Colors.grey.withOpacity(0.5),
        child: InkWell(
          child: Padding(
            padding: EdgeInsets.all(this.padding),
            child: child,
          ),
          customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius)),
        ));
  }
}

class InteractiveTile extends StatelessWidget {
  const InteractiveTile({
    Key? key,
    required this.child,
    required this.onTap,
  }) : super(key: key);

  final Widget child;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Colors.grey.withOpacity(0.5),
        child: InkWell(
          child: child,
          customBorder:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          onTap: () => this.onTap(),
        ));
  }
}

class CustomTransitions {
  static Route sidewaysPageTransition({required Widget toTransition}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => toTransition,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
