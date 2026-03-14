import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/assets_gen/assets.gen.dart';
import '../screens/view_document_screen.dart';

class DocumentItemWidget extends StatelessWidget {

  final String pdfUrl;
  const DocumentItemWidget({super.key, required this.pdfUrl});

  @override
  Widget build(BuildContext context) {

    final Uri uri = Uri.parse(pdfUrl);
    final String pdfFileName = uri.pathSegments.last;

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
        margin: EdgeInsets.symmetric(vertical: 4),
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
          title: Text(
            pdfFileName,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle:Text(""),
        ),
      ),
    );
  }
}
