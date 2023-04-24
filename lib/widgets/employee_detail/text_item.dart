import 'package:employ_info/extension/string_extensions.dart';
import 'package:flutter/material.dart';

class TextItem extends StatefulWidget {
  late TextEditingController textCtrl;
  late String label;
  late String defValue;
  late TextInputType inputType = TextInputType.text;
  late bool isEditModeOn = false;
  final ValueChanged<String>? onTextValueChange;

  TextItem({
    Key? key,
    required this.textCtrl,
    required this.label,
    required this.onTextValueChange,
    required this.defValue,
    required bool isEditMode,
    TextInputType? inputTypeValue,
  }) : super(key: key) {
    if (inputTypeValue != null) {
      inputType = inputTypeValue;
    }
    isEditModeOn = isEditMode;
  }

  @override
  State<TextItem> createState() => _TextItemState();
}

class _TextItemState extends State<TextItem> {


  @override
  void initState() {
    widget.textCtrl.text = widget.defValue.toCapitalized();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(right: 24),
              child: Text(widget.label,
                  style: Theme.of(context).textTheme.titleLarge),
            ),
          ),
          Expanded(
              flex: 2,
              child: TextFormField(
                maxLines: 1,
                autocorrect: false,
                enableSuggestions: false,
                keyboardType: widget.inputType,
                textAlign: TextAlign.left,
                enabled: widget.isEditModeOn,
                onChanged: (text) {
                  widget.onTextValueChange?.call(text);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some value';
                  }
                  return null;
                },
                style: Theme.of(context).textTheme.headlineSmall,
                textInputAction: TextInputAction.done,
                controller: widget.textCtrl,
              )),
        ],
      ),
    );
  }
}
