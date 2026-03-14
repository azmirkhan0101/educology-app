import 'package:dr_dina_educology/data/models/document/documents_model.dart';
import 'package:dr_dina_educology/modules/content_details/widgets/document_item_widget.dart';
import 'package:flutter/material.dart';

class DocumentsList extends StatelessWidget {

  final List<DocumentsModel> documents;
  const DocumentsList({super.key, required this.documents});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        itemCount: documents.length,
        itemBuilder: (context, index) {

          final String pdfUrl = documents[index].url;


          return DocumentItemWidget(pdfUrl: pdfUrl);
        },
      ),
    );
  }
}
