import 'package:flutter/material.dart';

class FlutterRoundedButtonAction extends StatelessWidget {
  final String? textButtonNegative;
  final String? textButtonPositive;
  final String? textActionButton;
  final VoidCallback? onTapButtonNegative; // Default is "Cancel" button.
  final VoidCallback? onTapButtonPositive; // Default is "OK" button.
  final VoidCallback?
      onTapButtonAction; // Default is "Action" button which will be on the left.
  final TextStyle? textStyleButtonAction;
  final TextStyle? textStyleButtonPositive;
  final TextStyle? textStyleButtonNegative;
  final MaterialLocalizations localizations;
  final double borderRadius;
  final EdgeInsets? paddingActionBar;
  final Color? background;

  const FlutterRoundedButtonAction(
      {Key? key,
      required this.localizations,
      this.textButtonNegative,
      this.textButtonPositive,
      this.textActionButton,
      this.onTapButtonAction,
      this.onTapButtonPositive,
      this.onTapButtonNegative,
      this.textStyleButtonPositive,
      this.textStyleButtonNegative,
      this.textStyleButtonAction,
      required this.borderRadius,
      this.paddingActionBar,
      this.background})
      : super(key: key);

  List<Widget> _buildActionsButton() {
    final Widget negativeButton = FlatButton(
      child: Text(
        textButtonNegative ?? localizations.cancelButtonLabel,
        style: textStyleButtonNegative,
      ),
      onPressed: onTapButtonNegative,
    );

    final Widget positiveButton = FlatButton(
      child: Text(
        textButtonPositive ?? localizations.okButtonLabel,
        style: textStyleButtonPositive,
      ),
      onPressed: onTapButtonPositive,
    );

    if (textActionButton != null) {
      final Widget leftButton = FlatButton(
        child: Text(textActionButton!, style: textStyleButtonAction),
        onPressed: onTapButtonAction,
      );
      return [
        leftButton,
        Row(children: <Widget>[negativeButton, positiveButton])
      ];
    }

    return [negativeButton, positiveButton];
  }

  Widget buildButtonBar(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            onPressed: onTapButtonNegative,
            icon: Icon(Icons.arrow_back),
          ),
          FloatingActionButton.extended(
            onPressed: onTapButtonPositive,
            icon: Icon(Icons.done),
            label: Text(textButtonPositive ?? localizations.okButtonLabel),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      padding: paddingActionBar,
      decoration: BoxDecoration(
          color: background,
          borderRadius: orientation == Orientation.landscape
              ? BorderRadius.only(bottomRight: Radius.circular(borderRadius))
              : BorderRadius.vertical(bottom: Radius.circular(borderRadius))),
      child: buildButtonBar(context),
    );
  }
}
