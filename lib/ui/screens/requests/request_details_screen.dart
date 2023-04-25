// Basic Imports
import 'package:flutter/material.dart';

// Models
import 'package:ug_mini_market/domain/models/app_request.dart';

// Widgets
import 'package:ug_mini_market/ui/widgets/form_widgets/form_buttons.dart';
import '../../widgets/form_widgets/input_fields.dart';
import '../../widgets/screen/scrollable_screen_top_action_bar.dart';
import '../../widgets/text/text_label_edit.dart';
import '../../widgets/top_action_bars/go_back_action_bar.dart';

// Utils
import 'package:ug_mini_market/utils/constants.dart';

class RequestDetailsScreen extends StatefulWidget {
  final AppRequest appRequest;

  const RequestDetailsScreen({required this.appRequest});

  @override
  RequestDetailsScreenState createState() => RequestDetailsScreenState();
}

class RequestDetailsScreenState extends State<RequestDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers
  late final TextEditingController placeController;

  @override
  void initState() {
    super.initState();

    // Initializing controllers
    placeController = TextEditingController(text: widget.appRequest.place);
  }

  @override
  Widget build(BuildContext context) {
    return ScrollableScreenWithTopActionBar(
      topActionBar:
          const GoBackTopActionBar(message: "Solicitud de tipo: Compra/Venta}"),
      children: [
        const Text("Vendedor/Comprador: <Placeholder Name>"),
        const SizedBox(height: padding * formPaddingMultiplier),
        const Text("Objeto de interés: <Placeholder Name>"),
        const SizedBox(height: padding * formPaddingMultiplier),
        Form(
          key: _formKey,
          child: MultiLineInputField(
            controller: placeController,
            labelText: "Lugar de encuentro",
            prefixIcon: Icon(Icons.place),
            optionalField: true,
          ),
        ),
        const SizedBox(height: padding * formPaddingMultiplier),
        TextLabelEdit(
          label: "Hora",
          value: "XX:YY AM/PM",
          onPressed: () {},
        ),
        const SizedBox(height: padding * formPaddingMultiplier),
        TextLabelEdit(
          label: "Fecha",
          value: "dd/mm/yyyy",
          onPressed: () {},
        ),
        FormButtons(
          buttons: [
            FilledButton.icon(
              icon: Icon(Icons.send),
              label: Text("Mandar Solicitud"),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
