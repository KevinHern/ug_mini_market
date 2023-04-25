// Models
import 'package:flutter/material.dart';

// Utils
import 'package:ug_mini_market/utils/constants.dart';

class ResponsiveMultiFilterChips extends StatefulWidget {
  final FilterChipModel filterChip;
  final bool mandatoryField;
  const ResponsiveMultiFilterChips({
    required this.filterChip,
    required this.mandatoryField,
  });

  @override
  ResponsiveMultiFilterChipsState createState() =>
      ResponsiveMultiFilterChipsState();
}

class ResponsiveMultiFilterChipsState
    extends State<ResponsiveMultiFilterChips> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.center,
      spacing: padding *
          filterChipMultiSelectionPaddingMultiplier, // gap between adjacent chips
      runSpacing: padding * filterChipMultiSelectionPaddingMultiplier,
      children: List<Widget>.generate(
        widget.filterChip.labels.length,
        (index) => ChoiceChip(
          label: Text(widget.filterChip.labels[index]),
          selected: widget.filterChip.selectedValues[index],
          onSelected: (bool value) => setState(
            () {
              if (widget.mandatoryField) {
                widget.filterChip.selectedValues[index] =
                    value || widget.filterChip.onlyOneOptionRemaining;
              } else {
                widget.filterChip.selectedValues[index] = value;
              }
            },
          ),
        ),
      ),
    );
  }
}
