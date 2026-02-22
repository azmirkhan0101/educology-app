import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart' as color_picker
    show ColorPicker, MaterialPicker, colorToHex;
import 'package:flutter_quill/flutter_quill.dart';

enum _PickerType {
  material,
  color,
}

class CustomQuillColorDialog extends StatefulWidget {
  const CustomQuillColorDialog({
    required this.isBackground,
    required this.onRequestChangeColor,
    required this.isToggledColor,
    required this.selectionStyle,
    super.key,
  });
  final bool isBackground;

  final bool isToggledColor;
  final Function(BuildContext context, Color? color) onRequestChangeColor;
  final Style selectionStyle;

  @override
  State<CustomQuillColorDialog> createState() => CustomQuillColorDialogState();
}

class CustomQuillColorDialogState extends State<CustomQuillColorDialog> {
  var pickerType = _PickerType.material;
  var selectedColor = Colors.black;

  late final TextEditingController hexController;
  late void Function(void Function()) colorBoxSetState;

  @override
  void initState() {
    super.initState();
    if (widget.isToggledColor) {
      selectedColor = widget.isBackground
          ? hexToColor(widget.selectionStyle.attributes['background']?.value)
          : hexToColor(widget.selectionStyle.attributes['color']?.value);
    }
    hexController =
        TextEditingController(text: color_picker.colorToHex(selectedColor));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Select Color"),
      actions: [
        TextButton(
            onPressed: () {
              widget.onRequestChangeColor(context, selectedColor);
              Navigator.of(context).pop();
            },
            child: Text("Ok")),
      ],
      backgroundColor: Theme.of(context).canvasColor,
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        pickerType = _PickerType.material;
                      });
                    },
                    child: Text("Material"),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        pickerType = _PickerType.color;
                      });
                    },
                    child: Text("Color"),
                  ),
                  TextButton(
                    onPressed: () {
                      widget.onRequestChangeColor(context, null);
                      Navigator.of(context).pop();
                    },
                    child: Text("Clear"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Column(
              children: [
                if (pickerType == _PickerType.material)
                  color_picker.MaterialPicker(
                    pickerColor: selectedColor,
                    onColorChanged: (color) {
                      widget.onRequestChangeColor(context, color);
                      Navigator.of(context).pop();
                    },
                  ),
                if (pickerType == _PickerType.color)
                  color_picker.ColorPicker(
                    pickerColor: selectedColor,
                    onColorChanged: (color) {
                      widget.onRequestChangeColor(context, color);
                      hexController.text = color_picker.colorToHex(color);
                      selectedColor = color;
                      colorBoxSetState(() {});
                    },
                  ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      height: 60,
                      child: TextFormField(
                        controller: hexController,
                        onChanged: (value) {
                          selectedColor = hexToColor(value);
                          colorBoxSetState(() {});
                        },
                        decoration: InputDecoration(
                          labelText: "HEX",
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    StatefulBuilder(
                      builder: (context, mcolorBoxSetState) {
                        colorBoxSetState = mcolorBoxSetState;
                        return Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black45,
                            ),
                            color: selectedColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Color hexToColor(String? hexString) {
    if (hexString == null) {
      return Colors.black;
    }
    final hexRegex = RegExp(r'([0-9A-Fa-f]{3}|[0-9A-Fa-f]{6})$');

    hexString = hexString.replaceAll('#', '');
    if (!hexRegex.hasMatch(hexString)) {
      return Colors.black;
    }

    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString);
    return Color(int.tryParse(buffer.toString(), radix: 16) ?? 0xFF000000);
  }
}
