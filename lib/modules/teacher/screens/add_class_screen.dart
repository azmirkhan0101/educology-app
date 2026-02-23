import 'package:dr_dina_educology/modules/teacher/widgets/quill_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class AddClassScreen extends StatefulWidget {
  const AddClassScreen({super.key});

  @override
  State<AddClassScreen> createState() => _AddClassScreenState();
}

class _AddClassScreenState extends State<AddClassScreen> {
  final quill.QuillController _controller = quill.QuillController.basic();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
          title: const Text("Add Class Details", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),)),
      body: Column(
        children: [
          /// Toolbar
          // quill.QuillSimpleToolbar(
          //   controller: _controller,
          //   config: const quill.QuillSimpleToolbarConfig(
          //     showFontFamily: false,
          //     showFontSize: false,
          //     showSearchButton: false,
          //     showSubscript: false,
          //     showSuperscript: false,
          //     showColorButton: true, // The 'A' icon
          //     showBackgroundColorButton: true, // The highlighter icon
          //     showListBullets: true,
          //     showListNumbers: true,
          //     showAlignmentButtons: true,
          //     showLink: true, // The paperclip icon
          //     // Customizing the header dropdown to look like "Paragraph"
          //     headerStyleType: quill.HeaderStyleType.original,
          //   ),
          // ),

          Row(
            children: [
              Expanded(child: CustomQuillToolbar(controller: _controller)),
            ],
          ),

          /// Editor
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: quill.QuillEditor.basic(
                controller: _controller,
                config: const quill.QuillEditorConfig(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

