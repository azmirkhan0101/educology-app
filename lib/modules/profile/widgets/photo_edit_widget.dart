import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/assets_gen/assets.gen.dart';
import '../../../core/utils/app_colors.dart';

class PhotoEditWidget extends StatelessWidget {
  final String? imageUrl;
  final Rxn<File> profileImage = Rxn<File>();
  final Function(File file)? onImagePicked;

  PhotoEditWidget({super.key, this.imageUrl, this.onImagePicked});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            padding: EdgeInsets.all(2),
            height: 120.h,
            width: 120.w,
            decoration: BoxDecoration(
              color: AppColors.primaryGold,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Obx(() {
                return _buildProfileImage();
              }),
            ),
          ),

          // The Edit Icon Button
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            bottom: 0,
            child: _EditIcon(size: 34.r, iconSize: 18.r, onTap: _pickImage),
          ),
        ],
      ),
    );
  }

  // Logic to decide whether to show File, Network URL, or Placeholder
  Widget _buildProfileImage() {
    if (profileImage.value != null) {
      return Image.file(profileImage.value!, fit: BoxFit.cover);
    } else if (imageUrl != null && imageUrl!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: imageUrl!,
        fit: BoxFit.cover,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(color: Colors.white),
        ),
        errorWidget: (context, url, error) => Center(
          child: Icon(Icons.person, size: 70.r, color: Colors.white),
        ),
      );
    }
    //return Icon(Icons.person, size: 50.r, color: Colors.grey);
    return Icon(Icons.person, size: 70.r, color: Colors.white);
  }

  // Image Picker Logic
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      final file = File(picked.path);
      profileImage.value = file;

      if (onImagePicked != null) {
        onImagePicked!(file);
      }
    }
  }
}

// Reusable Edit Icon Widget
class _EditIcon extends StatelessWidget {
  final VoidCallback onTap;
  final double size;
  final double iconSize;

  const _EditIcon({
    required this.onTap,
    required this.size,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: AppColors.black40Percent,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: GestureDetector(
          onTap: () {
            onTap.call();
            print("Edit Photo");
          },
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.white,
            ),
            child: SvgPicture.asset(Assets.icons.editPhoto),
          ),
        ),
      ),
    );
  }
}
