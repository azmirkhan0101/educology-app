import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/assets_gen/assets.gen.dart';
import '../../../core/utils/extensions.dart';
import '../screens/view_document_screen.dart';

class DocumentItemWidget extends StatelessWidget {
  final String pdfUrl;
  final VoidCallback? onDelete; // Added optional callback

  const DocumentItemWidget({
    super.key,
    required this.pdfUrl,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    bool isTab = context.isTab;
    final Uri uri = Uri.parse(pdfUrl);
    final String pdfFileName =
    uri.pathSegments.isNotEmpty ? uri.pathSegments.last : pdfUrl;

    // Check if the URL is a remote web URL
    final bool isNetworkPdf =
        uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');

    return GestureDetector(
      onTap: () {
        // Ignore tap if it's a local file
        if (!isNetworkPdf) return;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ViewDocumentScreen(url: pdfUrl);
            },
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
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
            style: TextStyle(
              fontSize: isTab ? 10.sp : null,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: !isNetworkPdf
              ? IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: onDelete,
          )
              : null,
        ),
      ),
    );
  }
}