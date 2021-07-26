//Basic Imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum ProgressDialogIndicator { CIRCULAR, BAR }

class ProgressDialogModel extends ChangeNotifier {
  String _text;
  String? _title, _legend;
  int _currentProgress;
  final int? _maxProgress;

  ProgressDialogModel({
    required String text,
    String? title,
    String? legend,
    int? maxProgress,
  })  : this._title = title,
        this._text = text,
        this._legend = legend,
        this._maxProgress = maxProgress,
        this._currentProgress = 0;

  String? get title => this._title;
  String get text => this._text;
  String? get legend => this._legend;
  int get currentProgress => this._currentProgress;
  int? get maxProgress => this._maxProgress;

  set title(String? value) {
    this._title = value;
    notifyListeners();
  }

  set text(String value) {
    this._text = value;
    notifyListeners();
  }

  set legend(String? value) {
    this._legend = value;
    notifyListeners();
  }

  set currentProgress(int value) {
    this._currentProgress = value;
    notifyListeners();
  }
}

class ProgressDialog {
  // Functionality Properties
  final ProgressDialogModel _pdm;
  bool _isShowing = false;
  final bool _isDismissible, _showPercentage;

  // Style Properties
  final double _progressDialogWidth;
  final ProgressDialogIndicator _progressDialogIndicator;
  late final _progressIndicatorWidget;

  // Getters
  bool get isShowing => _isShowing;
  bool get isDismissible => _isDismissible;

  ProgressDialog({
    required String text,
    required ProgressDialogIndicator progressDialogIndicator,
    bool showPercentage = false,
    bool isDismissible = false,
    double progressDialogWidth = 0.7,
    String title = "",
    String legend = "",
    int? maxProgress,
  })  : assert(progressDialogWidth >= 0),
        assert(
            ProgressDialogIndicator.values.contains(progressDialogIndicator)),
        this._pdm = ProgressDialogModel(
          text: text,
          legend: legend,
          title: title,
          maxProgress: maxProgress,
        ),
        this._isDismissible = isDismissible,
        this._progressDialogWidth = progressDialogWidth,
        this._progressDialogIndicator = progressDialogIndicator,
        this._showPercentage = showPercentage;

  void setProgressIndicatorStyle({
    double width = 4.0,
    Color? backgroundColor,
    Animation<Color>? valueColor,
  }) {
    if (this._progressDialogIndicator == ProgressDialogIndicator.CIRCULAR) {
      this._progressIndicatorWidget = CircularProgressIndicator(
        value: null,
        valueColor: valueColor,
        backgroundColor: backgroundColor,
        strokeWidth: width,
      );
    } else
      this._progressIndicatorWidget = LinearProgressIndicator(
        value: null,
        valueColor: valueColor,
        backgroundColor: backgroundColor,
        minHeight: width,
      );
  }

  void update({String? text, int? currentProgress}) {
    if (text != null) this._pdm.text = text;
    if (currentProgress != null) {
      assert(this._pdm.maxProgress != null &&
          currentProgress <= this._pdm.maxProgress!);
      this._pdm.currentProgress = currentProgress;
    }
  }

  void showProgressDialog({required BuildContext context}) async {
    this._isShowing = true;
    await showDialog(
      context: context,
      barrierDismissible: this._isDismissible,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            switch (this._isDismissible) {
              case true:
                this._isShowing = false;
                return true;
              default:
                return false;
            }
          },
          child: AlertDialog(
            contentPadding: const EdgeInsets.all(10.0),
            content: Container(
              width: (this._progressDialogWidth == 0)
                  ? null
                  : ((this._progressDialogWidth > 1)
                      ? this._progressDialogWidth
                      : MediaQuery.of(context).size.width *
                          this._progressDialogWidth),
              child: ChangeNotifierProvider<ProgressDialogModel>(
                create: (context) => this._pdm,
                child: Consumer<ProgressDialogModel>(
                  builder: (_, __, ___) {
                    return (this._progressDialogIndicator ==
                            ProgressDialogIndicator.CIRCULAR)
                        ? CircularProgressIndicatorDialog(
                            pdm: this._pdm,
                            cpi: this._progressIndicatorWidget,
                            showPercentage: this._showPercentage)
                        : LinearProgressIndicatorDialog(
                            pdm: this._pdm,
                            lpi: this._progressIndicatorWidget,
                            showPercentage: this._showPercentage);
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void dismiss({required BuildContext context}) {
    if (this._isShowing) {
      this._isShowing = false;
      Navigator.of(context).pop();
    }
  }
}

/*---------------------------------------*/

abstract class ProgressIndicatorDialog extends StatelessWidget {
  late final ProgressDialogModel pdm;
  late final bool showPercentage;
  late final Widget progressIndicatorWidget;

  ProgressIndicatorDialog(
      {required this.pdm,
      required this.showPercentage,
      required this.progressIndicatorWidget});
}

class CircularProgressIndicatorDialog extends ProgressIndicatorDialog {
  CircularProgressIndicatorDialog(
      {required ProgressDialogModel pdm,
      required CircularProgressIndicator cpi,
      required bool showPercentage})
      : super(
          pdm: pdm,
          progressIndicatorWidget: cpi,
          showPercentage: showPercentage,
        );

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: super.progressIndicatorWidget,
      title: Text(
        super.pdm.text,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      subtitle: (super.pdm.maxProgress == null)
          ? null
          : Text(
              'Progress: ' +
                  ((super.showPercentage)
                      ? '${(100.00 * super.pdm.currentProgress.toDouble() / super.pdm.maxProgress!).toStringAsFixed(0)}%'
                      : '${super.pdm._currentProgress} / ${super.pdm.maxProgress!}'),
              style: TextStyle(
                fontStyle: Theme.of(context).textTheme.bodyText1!.fontStyle,
                fontSize: Theme.of(context).textTheme.bodyText1!.fontSize! - 4,
              ),
              textAlign: TextAlign.right,
            ),
    );
  }
}

class LinearProgressIndicatorDialog extends ProgressIndicatorDialog {
  LinearProgressIndicatorDialog(
      {required ProgressDialogModel pdm,
      required LinearProgressIndicator lpi,
      required bool showPercentage})
      : super(
          pdm: pdm,
          progressIndicatorWidget: lpi,
          showPercentage: showPercentage,
        );

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: super.progressIndicatorWidget,
      subtitle: ListView(
        shrinkWrap: true,
        children: [
          (super.pdm.maxProgress == null)
              ? SizedBox(
                  height: 0,
                )
              : Text(
                  'Progress: ' +
                      ((super.showPercentage)
                          ? '${(100.00 * super.pdm.currentProgress.toDouble() / super.pdm.maxProgress!).toStringAsFixed(0)}%'
                          : '${super.pdm._currentProgress} / ${super.pdm.maxProgress!}'),
                  style: TextStyle(
                    fontStyle: Theme.of(context).textTheme.bodyText1!.fontStyle,
                    fontSize:
                        Theme.of(context).textTheme.bodyText1!.fontSize! - 4,
                  ),
                  textAlign: TextAlign.center,
                ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              super.pdm.text,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ],
      ),
    );
  }
}
