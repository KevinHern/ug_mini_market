// Basic Imports
import 'package:flutter/material.dart';

// Models
import 'package:ug_mini_market/models/ug_user.dart';

// Templates
import 'package:ug_mini_market/templates/common_assets_template.dart';
import 'package:ug_mini_market/templates/dialog_template.dart';

// Backend
import 'package:cloud_firestore/cloud_firestore.dart';

class RatingScreen extends StatelessWidget {
  final UGUser user;
  RatingScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12.0),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: FitText(text: 'Calificar', fitTextStyle: FitTextStyle.H1),
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Card(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(this.user.uid)
                  .collection('ratings')
                  .where('status', isEqualTo: false)
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshots) {
                if (!snapshots.hasData) {
                  return const Center(
                    child: const CircularProgressIndicator(),
                  );
                } else {
                  if (snapshots.data != null &&
                      snapshots.data!.docs.length > 0) {
                    return ListView.builder(
                      itemCount: snapshots.data!.docs.length,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 0),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: RatingInformationCard(
                            userToRate: snapshots.data.docs[index],
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: SingleChildScrollView(
                        child: AlertTextTemplate(
                          title: "Aviso",
                          message: "No hay usuarios pendientes de calificar.",
                          showAction: false,
                        ),
                      ),
                    );
                  }
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}

class RatingInformationCard extends StatelessWidget {
  final DocumentSnapshot userToRate;
  RatingInformationCard({required this.userToRate});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      child: ListTile(
        title: Text(
          userToRate['name'],
          style: Theme.of(context).textTheme.headline3,
        ),
        subtitle: Text(
          '${DateTime.fromMillisecondsSinceEpoch(int.parse(userToRate.id)).day}/${DateTime.fromMillisecondsSinceEpoch(int.parse(userToRate.id)).month}/${DateTime.fromMillisecondsSinceEpoch(int.parse(userToRate.id)).year}\n\n',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        trailing: AccentButton(
            icon: Icons.star,
            onPressed: () async {
              await DialogTemplate.showSelectOptions(
                context: context,
                title: 'Califica',
                options: const [0, 1, 2, 3, 4],
                captions: const [
                  '1 Estrella',
                  '2 Estrellas',
                  '3 Estrellas',
                  '4 Estrellas',
                  '5 Estrellas'
                ],
                aftermath: (value) async {
                  print(value);
                  if (value >= 0) {
                    WriteBatch batch = FirebaseFirestore.instance.batch();
                    batch.update(this.userToRate.reference, {
                      'status': true,
                    });
                    String message = "";
                    batch.update(
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(this.userToRate['uid']),
                        {
                          'rating': FieldValue.increment(value + 1),
                          'noRatings': FieldValue.increment(1),
                        });

                    await batch
                        .commit()
                        .then((value) =>
                            message = 'Su calificación ha sido registrada.')
                        .catchError(
                      (error) {
                        message =
                            'Ocurrió un error, por favor intente de nuevo.';
                        print('Error on Submiting Rating: ${error.toString()}');
                      },
                    );
                  }
                },
                areRoutingOptions: false,
              );
            }),
      ),
    );
  }
}
