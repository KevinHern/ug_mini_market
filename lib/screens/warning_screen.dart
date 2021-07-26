// Basic imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WarningScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ChangeNotifierProvider<ValueNotifier<bool>>(
            create: (context) => ValueNotifier<bool>(false),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.40,
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyText1,
                          children: [
                            TextSpan(
                                text: 'AVISO IMPORTANTE:\n\n',
                                style: Theme.of(context).textTheme.headline3),
                            TextSpan(
                              text:
                                  'Al utilizar esta aplicación, usted está consciente que cualquier intento de venta o compra de algún'
                                  'proyecto o tarea será penalizado con el respectivo director de su carrera o con el decano de facultad.\n'
                                  'Adicionalmente, si realiza negocios de cualquier índole fuera del objetivo de la aplicación, usted estará sujeto'
                                  'ya sea a una suspensión o incluso expulsión de la institución educativa.\n\n'
                                  'No se aceptarán cualquier tipo de excusas una vez se haya detectado y comprobado su participación en alguna actividad no autorizada.'
                                  ' Y, debe de proporcionar los datos de la otra persona con quien iba realizar la venta o compra.',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Consumer<ValueNotifier<bool>>(
                    builder: (_, agreement, __) {
                      return CheckboxListTile(
                          contentPadding: const EdgeInsets.all(0.0),
                          title: Text(
                            'Yo he leído las condiciones de uso de la aplicación y estoy de acuerdo que si participo en cualquier tipo de negocio, '
                            'compra o venta no autorizada tendrá sus respectivas consecuencias. Las autoridades podrán proceder como ellos vean necesario.',
                            textAlign: TextAlign.justify,
                          ),
                          value: agreement.value,
                          onChanged: (changedValue) =>
                              agreement.value = changedValue!);
                    },
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Consumer<ValueNotifier<bool>>(
                    builder: (_, agreement, __) {
                      return ElevatedButton(
                        onPressed: (!agreement.value)
                            ? null
                            : () => Navigator.pushNamed(context, '/login'),
                        child: Text(
                          'Continuar',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 10.0,
                          primary: Theme.of(context).primaryColor,
                          onPrimary: Theme.of(context).primaryColorLight,
                          shadowColor: Colors.black54,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
