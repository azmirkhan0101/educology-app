import 'package:dr_dina_educology/modules/content_details/screens/view_document_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/assets_gen/assets.gen.dart';

class DocumentsList extends StatelessWidget {

  final List<String> documents;
  const DocumentsList({super.key, required this.documents});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        itemCount: documents.length,
        itemBuilder: (context, index) {

          final String pdfUrl = documents[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context){
                    return ViewDocumentScreen(url: pdfUrl);
                  },
                ));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 0,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey.shade100),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: SvgPicture.asset(Assets.icons.document),
                title: const Text(
                  'exam.pdf',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text('2 MB'),
              ),
            ),
          );
        },
      ),
    );
  }
}
