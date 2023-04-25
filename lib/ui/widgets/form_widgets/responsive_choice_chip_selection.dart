// Basic Imports
import 'package:flutter/material.dart';

// Utils
import 'package:ug_mini_market/utils/constants.dart';

class ResponsiveChoiceChipSelection extends StatefulWidget {
  final ChoiceChipModel choiceChipModel;
  final bool mandatoryField;

  const ResponsiveChoiceChipSelection(
      {required this.choiceChipModel, required this.mandatoryField});

  @override
  ResponsiveChoiceChipSelectionState createState() =>
      ResponsiveChoiceChipSelectionState();
}

class ResponsiveChoiceChipSelectionState
    extends State<ResponsiveChoiceChipSelection> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.spaceEvenly,
      children: List<Widget>.generate(
        widget.choiceChipModel.labels.length,
        (index) => ChoiceChip(
          label: Text(widget.choiceChipModel.labels[index]),
          selected: widget.choiceChipModel.selectedLabel == index,
          onSelected: (bool value) => setState(
            () {
              if (widget.mandatoryField) {
                widget.choiceChipModel.selectedLabel = index;
              } else {
                widget.choiceChipModel.selectedLabel = value ? index : null;
              }
            },
          ),
        ),
      ),
    );
  }
}
