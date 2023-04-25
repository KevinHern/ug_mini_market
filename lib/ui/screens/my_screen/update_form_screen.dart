// Basic Imports
import 'package:flutter/material.dart';

// Models
import 'package:ug_mini_market/domain/models/ug_user.dart';

// Widgets
import '../../widgets/form_widgets/dropdown_field.dart';
import '../../widgets/form_widgets/form_buttons.dart';
import '../../widgets/form_widgets/input_fields.dart';
import '../../widgets/screen/scrollable_screen_top_action_bar.dart';
import '../../widgets/top_action_bars/go_back_action_bar.dart';

// Utils
import 'package:ug_mini_market/utils/constants.dart';

class MyProfileUpdateFormScreen extends StatefulWidget {
  final UGUser ugUser;
  const MyProfileUpdateFormScreen({required this.ugUser});

  @override
  State<StatefulWidget> createState() => MyProfileUpdateFormState();
}

class MyProfileUpdateFormState extends State<MyProfileUpdateFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers
  late final TextEditingController nameController,
      lastNameController,
      idController,
      emailController,
      facultyController;

  @override
  void initState() {
    super.initState();

    // Initializing controllers
    nameController = TextEditingController(text: widget.ugUser.names);
    lastNameController = TextEditingController(text: widget.ugUser.lastNames);
    idController = TextEditingController(text: widget.ugUser.id.toString());
    emailController = TextEditingController(text: widget.ugUser.email);
    facultyController = TextEditingController(text: widget.ugUser.faculty);
  }

  @override
  Widget build(BuildContext context) {
    return ScrollableScreenWithTopActionBar(
      topActionBar:
          const GoBackTopActionBar(message: 'Última actualización: dd/mm/yyyy'),
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              NameInputField(
                controller: nameController,
                textInputAction: TextInputAction.next,
                labelText: "Nombres",
              ),
              const SizedBox(height: padding * formPaddingMultiplier),
              NameInputField(
                controller: lastNameController,
                textInputAction: TextInputAction.next,
                labelText: "Apellidos",
              ),
              const SizedBox(height: padding * formPaddingMultiplier),
              IntegerInputField(
                controller: idController,
                textInputAction: TextInputAction.next,
                validator: (String? value) => null,
                optionalField: true,
                labelText: "Carnet",
                prefixIcon: Icon(Icons.credit_card_rounded),
                readOnly: true,
              ),
              const SizedBox(height: padding * formPaddingMultiplier),
              EmailInputField(
                controller: emailController,
                textInputAction: TextInputAction.done,
                validator: (String? value) => null,
                readOnly: true,
              ),
              const SizedBox(height: padding * formPaddingMultiplier),
              DropdownInputField<String>(
                controller: facultyController,
                items: UGFaculties.faculties,
                labelText: "Faculty",
                prefixIcon: Icon(Icons.other_houses_rounded),
              ),
            ],
          ),
        ),
        const SizedBox(height: padding * formPaddingMultiplier),
        FormButtons(
          buttons: [
            FilledButton.tonalIcon(
              icon: Icon(Icons.cancel_rounded),
              label: Text("Reset"),
              onPressed: () {},
            ),
            FilledButton.icon(
              icon: Icon(Icons.save),
              label: Text("Actualizar"),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
