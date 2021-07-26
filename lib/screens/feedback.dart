// Basic Imports
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:ug_mini_market/models/ug_user.dart';

// Templates
import 'package:ug_mini_market/templates/common_assets_template.dart';
import 'package:ug_mini_market/templates/dialog_template.dart';
import 'package:ug_mini_market/templates/progress_dialog.dart';
import 'package:ug_mini_market/templates/form_template.dart';

class FeedbackScreen extends StatefulWidget {
  final UGUser user;
  FeedbackScreen({required this.user});

  FeedbackScreenState createState() => FeedbackScreenState(
        user: this.user,
      );
}

class FeedbackScreenState extends State<FeedbackScreen> {
  final messageController = TextEditingController();
  final UGUser user;
  FeedbackScreenState({required this.user});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12.0),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: FitText(text: 'Feedback', fitTextStyle: FitTextStyle.H1),
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InputMultiText(
                caption: 'Mensaje (se enviará un correo)',
                icon: Icons.email,
                controller: messageController),
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              child: AccentButton(
                  icon: Icons.delete,
                  text: 'Borrar',
                  onPressed: () => this.messageController.text = ''),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              child: AccentButton(
                  icon: Icons.send,
                  text: 'Enviar',
                  onPressed: () async {
                    ProgressDialog pd = ProgressDialog(
                        text: 'Enviando...',
                        progressDialogIndicator:
                            ProgressDialogIndicator.CIRCULAR,
                        isDismissible: true);
                    pd.setProgressIndicatorStyle(width: 6.0);
                    pd.showProgressDialog(context: context);

                    String feedbackMessage = messageController.text;
                    String message = '';
                    // Send Email
                    final Email email = Email(
                      body: feedbackMessage,
                      subject: 'UG-Market: Feedback',
                      recipients: ['hernandez.kevin@galileo.edu'],
                      cc: [this.user.email],
                      isHTML: false,
                    );

                    await FlutterEmailSender.send(email).then((value) {
                      message =
                          '¡Muchas gracias por tu feedback!\nSe tomará en consideración.';
                      this.messageController.text = '';
                    }).catchError((error) => message =
                        'Ocurrió un error, por favor intenta de nuevo.');

                    pd.dismiss(context: context);
                    DialogTemplate.showMessage(
                        context: context, message: message);
                  }),
            ),
          ],
        ),
      ],
    );
  }
}
