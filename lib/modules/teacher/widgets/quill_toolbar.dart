import 'package:dr_dina_educology/modules/teacher/widgets/custom_quill_color_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class CustomQuillToolbar extends StatelessWidget {
  final QuillController controller;

  const CustomQuillToolbar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [

          /// TOP ROW
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                QuillToolbarSelectHeaderStyleDropdownButton(
                  controller: controller,
                ),

                _divider(),

                QuillToolbarToggleStyleButton(
                  controller: controller,
                  attribute: Attribute.leftAlignment,
                  options: QuillToolbarToggleStyleButtonOptions(iconData: Icons.format_align_left),
                ),
                QuillToolbarToggleStyleButton(
                  controller: controller,
                  attribute: Attribute.centerAlignment,
                  options: QuillToolbarToggleStyleButtonOptions(iconData: Icons.format_align_center),
                ),
                QuillToolbarToggleStyleButton(
                  controller: controller,
                  attribute: Attribute.rightAlignment,
                  options: QuillToolbarToggleStyleButtonOptions(iconData: Icons.format_align_right),
                ),
                // QuillToolbarToggleStyleButton(
                //   controller: controller,
                //   attribute: Attribute.justifyAlignment,
                //   options: QuillToolbarToggleStyleButtonOptions(iconData: Icons.format_align_justify),
                // ),

                _divider(),

                QuillToolbarToggleStyleButton(
                  controller: controller,
                  attribute: Attribute.ol,
                  options: QuillToolbarToggleStyleButtonOptions(iconData: Icons.format_list_numbered),
                ),
                QuillToolbarToggleStyleButton(
                  controller: controller,
                  attribute: Attribute.ul,
                  options: QuillToolbarToggleStyleButtonOptions(iconData: Icons.format_list_bulleted),
                ),
              ],
            ),
          ),

          //const SizedBox(height: 8),

          /// BOTTOM ROW
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                QuillToolbarColorButton(
                  controller: controller,
                  isBackground: false,
                  options: QuillToolbarColorButtonOptions(
                    customOnPressedCallback: (controller, isBackground) async{
                      showDialog(
                          context: context,
                          builder: (context){
                            return CustomQuillColorDialog(
                                isBackground: isBackground,
                                onRequestChangeColor: (context, color) {
                                  String? hexCode;

                                  if (color != null) {
                                    // 1. Get the 8-character hex (AARRGGBB)
                                    String rawHex = color.value.toRadixString(16).padLeft(8, '0');

                                    // 2. Format it as #RRGGBBAA or #RRGGBB (Quill is happiest with #RRGGBB)
                                    // We take the last 6 characters to get the RGB and ignore the Alpha if it's causing issues
                                    hexCode = '#${rawHex.substring(2)}';
                                  }
                                  controller.formatSelection(
                                    isBackground
                                        ? BackgroundAttribute(hexCode)
                                        : ColorAttribute(hexCode),
                                  );
                                  //Navigator.pop(context);
                                },
                                isToggledColor: true,
                                selectionStyle: controller.getSelectionStyle()
                            );
                          }
                      );
                    }
                ),
                ),
                QuillToolbarColorButton(
                  controller: controller,
                  isBackground: true,
                  options: QuillToolbarColorButtonOptions(
                    customOnPressedCallback: (controller, isBackground) async{
                      showDialog(
                          context: context,
                          builder: (context){
                            return CustomQuillColorDialog(
                                isBackground: isBackground,
                                onRequestChangeColor: (context, color) {
                                  String? hexCode;

                                  if (color != null) {
                                    // 1. Get the 8-character hex (AARRGGBB)
                                    String rawHex = color.value.toRadixString(16).padLeft(8, '0');

                                    // 2. Format it as #RRGGBBAA or #RRGGBB (Quill is happiest with #RRGGBB)
                                    // We take the last 6 characters to get the RGB and ignore the Alpha if it's causing issues
                                    hexCode = '#${rawHex.substring(2)}';
                                  }
                                  controller.formatSelection(
                                    isBackground
                                        ? BackgroundAttribute(hexCode)
                                        : ColorAttribute(hexCode),
                                  );
                                  //Navigator.pop(context);
                                },
                                isToggledColor: true,
                                selectionStyle: controller.getSelectionStyle()
                            );
                          }
                      );
                    }
                  ),
                ),

                QuillToolbarToggleStyleButton(
                  controller: controller,
                  attribute: Attribute.bold,
                    options: QuillToolbarToggleStyleButtonOptions(iconData: Icons.format_bold)
                ),
                QuillToolbarToggleStyleButton(
                  controller: controller,
                  attribute: Attribute.italic,
                    options: QuillToolbarToggleStyleButtonOptions(iconData: Icons.format_italic)
                ),
                QuillToolbarToggleStyleButton(
                  controller: controller,
                  attribute: Attribute.underline,
                    options: QuillToolbarToggleStyleButtonOptions(iconData: Icons.format_underline)
                ),
                QuillToolbarToggleStyleButton(
                  controller: controller,
                  attribute: Attribute.strikeThrough,
                    options: QuillToolbarToggleStyleButtonOptions(iconData: Icons.format_strikethrough)
                ),

                _divider(),

                // IconButton(
                //   icon: const Icon(Icons.attach_file),
                //   onPressed: () {
                //     // your attachment logic
                //   },
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      height: 22,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      color: Colors.grey.shade300,
    );
  }
}