// Basic Imports
import 'package:flutter/material.dart';

// Models
import '../../filter_models/notifications_filter.dart';

// Widgets
import 'package:ug_mini_market/ui/widgets/form_widgets/form_buttons.dart';
import '../../widgets/form_widgets/responsive_multi_filter_chips_selection.dart';
import '../../widgets/screen/scrollable_screen_top_action_bar.dart';
import '../../widgets/text/text_label_edit.dart';
import '../../widgets/top_action_bars/go_back_action_bar.dart';
import 'package:ug_mini_market/ui/widgets/form_widgets/responsive_choice_chip_selection.dart';

// Utils
import 'package:ug_mini_market/utils/constants.dart';

class NotificationFilteringScreen extends StatelessWidget {
  final NotificationsFilter notificationsFilter;
  final FilterChipModel notificationType;
  final ChoiceChipModel notificationStatus, myRole;

  NotificationFilteringScreen({required this.notificationsFilter})
      : notificationType = FilterChipModel(
            labels: FilterChipModel.notificationTypesLabels,
            selectedLabels: notificationsFilter.notificationTypes),
        notificationStatus = ChoiceChipModel(
            labels: ChoiceChipModel.notificationStatusLabels,
            selectedLabel: notificationsFilter.status),
        myRole = ChoiceChipModel(
            labels: ChoiceChipModel.myRoleLabels,
            selectedLabel: notificationsFilter.role);

  @override
  Widget build(BuildContext context) {
    return ScrollableScreenWithTopActionBar(
      topActionBar:
          const GoBackTopActionBar(message: "Filtrar notificaciones por..."),
      children: [
        const Text("Tipo de notificación"),
        const SizedBox(height: padding * listTextPaddingMultiplier),
        ResponsiveMultiFilterChips(
          filterChip: notificationType,
          mandatoryField: true,
        ),
        const SizedBox(height: padding * listTextPaddingMultiplier),
        const Text("Status"),
        const SizedBox(height: padding * listTextPaddingMultiplier),
        ResponsiveChoiceChipSelection(
          choiceChipModel: notificationStatus,
          mandatoryField: true,
        ),
        const SizedBox(height: padding * listTextPaddingMultiplier),
        const Text("Mi Rol"),
        const SizedBox(height: padding * listTextPaddingMultiplier),
        ResponsiveChoiceChipSelection(
          choiceChipModel: myRole,
          mandatoryField: true,
        ),
        const SizedBox(height: padding * listTextPaddingMultiplier),
        const Text("Fecha"),
        const SizedBox(height: padding * listTextPaddingMultiplier),
        TextLabelEdit(
          label: "Inicio",
          value: "dd/mm/yyyy",
          onPressed: () {},
        ),
        const SizedBox(height: padding * listTextPaddingMultiplier),
        TextLabelEdit(
          label: "Fin",
          value: "dd/mm/yyyy",
          onPressed: () {},
        ),
        FormButtons(
          buttons: [
            FilledButton.icon(
              icon: Icon(Icons.check_circle_rounded),
              label: Text("Aplicar"),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
