import 'package:dr_dina_educology/modules/content_details/widgets/document_item_widget.dart';
import 'package:flutter/material.dart';

class DocumentsList extends StatelessWidget {
  final List<String> documents;
  final Function(int index)? onDelete; // Added callback parameter

  const DocumentsList({
    super.key,
    required this.documents,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        itemCount: documents.length,
        itemBuilder: (context, index) {
          final String pdfUrl = documents[index];

          return DocumentItemWidget(
            pdfUrl: pdfUrl,
            onDelete: () {
              if (onDelete != null) {
                onDelete!(index);
              }
            },
          );
        },
      ),
    );
  }
}