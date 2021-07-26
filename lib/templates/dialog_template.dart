// Basic Imports
import 'package:flutter/material.dart';
import 'package:ug_mini_market/templates/common_assets_template.dart';

enum DialogAction { OK, CANCEL }

class DialogTemplate {
  static Future showMessage(
      {required BuildContext context,
      required String message,
      String title = 'Aviso',
      Function? aftermath}) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertTextTemplate(
              title: title, message: message, showAction: true);
        }).then((value) {
      try {
        if (value && aftermath != null) aftermath();
      } catch (error) {
        print(error);
      }
    });
  }

  static Future showSelectOptions(
      {required BuildContext context,
      required String title,
      required List<int> options,
      required List<dynamic> captions,
      required aftermath(int option),
      bool areRoutingOptions = true}) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertTemplate(
            title: title,
            content: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Column(
                children: options.map(
                  (index) {
                    return Card(
                      child: ListTile(
                        title: FitText(
                          text: captions[index],
                          fitTextStyle: FitTextStyle.B1,
                        ),
                        trailing: Icon((areRoutingOptions)
                            ? Icons.subdirectory_arrow_right
                            : Icons.check),
                        onTap: () {
                          Navigator.of(context).pop(index);
                        },
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
                child: AssetButton(action: DialogAction.CANCEL),
              ),
            ]);
      },
    ).then(
      (value) {
        try {
          aftermath(value);
        } catch (error) {
          print('Error in Show Selection Options: ' + error.toString());
        }
      },
    );
  }
}

class AssetButton extends StatelessWidget {
  const AssetButton({
    Key? key,
    required this.action,
  }) : super(key: key);

  final DialogAction action;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 40,
        width: 40,
        child: (this.action == DialogAction.OK)
            ? Image.asset('assets/confirm.png')
            : Image.asset('assets/cancel.png'),
      ),
      onTap: () => (this.action == DialogAction.OK)
          ? Navigator.of(context).pop(true)
          : Navigator.of(context).pop(false),
    );
  }
}

class AlertTemplate extends StatelessWidget {
  const AlertTemplate({
    Key? key,
    required this.title,
    required this.content,
    required this.actions,
  }) : super(key: key);

  final String title;
  final Widget content;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 45,
            width: 45,
            child: Image.asset('assets/info.png'),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              this.title,
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      content: this.content,
      actions: this.actions,
    );
  }
}

class AlertTextTemplate extends StatelessWidget {
  const AlertTextTemplate({
    Key? key,
    required this.title,
    required this.message,
    required this.showAction,
  }) : super(key: key);

  final String title;
  final String message;
  final bool showAction;

  @override
  Widget build(BuildContext context) {
    // Add button actions if needed
    List<Widget> actions = [];
    if (showAction) {
      actions.add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: AssetButton(action: DialogAction.OK),
        ),
      );
    }

    return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 45,
              width: 45,
              child: Image.asset('assets/info.png'),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        content: SingleChildScrollView(
          child: Text(
            message,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        actions: actions);
  }
}

class BinaryAlert extends StatelessWidget {
  const BinaryAlert({
    Key? key,
    required this.message,
    required this.title,
  }) : super(key: key);

  final String message;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AlertTemplate(
        title: this.title,
        content: Text(
          this.message,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: AssetButton(action: DialogAction.OK),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: AssetButton(action: DialogAction.CANCEL),
          )
        ]);
  }
}
