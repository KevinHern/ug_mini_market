// Basic Imports
import 'package:flutter/material.dart';

// Models
import '../../filter_models/requests_filter.dart';

// Widgets
import 'package:ug_mini_market/ui/widgets/form_widgets/form_buttons.dart';
import 'package:ug_mini_market/ui/widgets/form_widgets/responsive_choice_chip_selection.dart';
import '../../widgets/form_widgets/responsive_multi_filter_chips_selection.dart';
import '../../widgets/top_action_bars/go_back_action_bar.dart';
import '../../widgets/screen/scrollable_screen_top_action_bar.dart';

// Utils
import 'package:ug_mini_market/utils/constants.dart';

class RequestFilteringScreen extends StatelessWidget {
  final RequestsFilter requestsFilter;
  final FilterChipModel requestStatus;
  final ChoiceChipModel sortMode, myRole;

  RequestFilteringScreen({required this.requestsFilter})
      : requestStatus = FilterChipModel(
            labels: FilterChipModel.notificationTypesLabels,
            selectedLabels: requestsFilter.requestTypes),
        myRole = ChoiceChipModel(
            labels: ChoiceChipModel.myRoleLabels,
            selectedLabel: requestsFilter.role),
        sortMode = ChoiceChipModel(
            labels: ChoiceChipModel.requestSortModeLabels,
            selectedLabel: requestsFilter.sortNewestInt);

  @override
  Widget build(BuildContext context) {
    return ScrollableScreenWithTopActionBar(
      topActionBar:
          const GoBackTopActionBar(message: "Filtrar solicitudes por..."),
      children: [
        const Text("Mi Rol en la Solicitud"),
        const SizedBox(height: padding * listTextPaddingMultiplier),
        ResponsiveChoiceChipSelection(
          choiceChipModel: myRole,
          mandatoryField: true,
        ),
        const SizedBox(height: padding * listTextPaddingMultiplier),
        const Text("Status de solicitud"),
        const SizedBox(height: padding * listTextPaddingMultiplier),
        ResponsiveMultiFilterChips(
          filterChip: requestStatus,
          mandatoryField: true,
        ),
        const SizedBox(height: padding * listTextPaddingMultiplier),
        const Text("Forma de Ordenamiento"),
        const SizedBox(height: padding * listTextPaddingMultiplier),
        ResponsiveChoiceChipSelection(
          choiceChipModel: sortMode,
          mandatoryField: true,
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
