import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/extensions.dart';

class CopyLinkWidget extends StatelessWidget {

  final String link;
  final bool isClassLink;

  const CopyLinkWidget({
    super.key,
    required this.link,
    required this.isClassLink
  });

  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.grey, fontSize: isTab ? 9.sp : 14),
                children: [
                  TextSpan(text: isClassLink ? 'Module link: ' : 'Recording link: '),
                  TextSpan(
                    text: link,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            constraints: const BoxConstraints(),
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.copy, size: 20, color: Colors.blueGrey),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: link ));

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Link copied to clipboard!'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
