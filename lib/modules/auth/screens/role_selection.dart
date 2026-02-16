import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/core/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/assets_gen/assets.gen.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  _RoleSelectionScreenState createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  // Track which role is selected
  String? _selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // Logo Section
              SvgPicture.asset( Assets.icons.appLogo, height: 120),
              const SizedBox(height: 12),

              // Header Text
              const Text(
                AppStrings.welcomeToEducology,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A6D65), // Deep teal/green
                ),
              ),
              const SizedBox(height: 8),
              const Text( AppStrings.manageYourClasses,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 32),

              const Text(
                AppStrings.selectYourRole,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4A6D65),
                ),
              ),
              const SizedBox(height: 20),

              // Role Options List
              Expanded(
                child: ListView(
                  children: [
                    _buildRoleCard('a Student', Assets.icons.student),
                    _buildRoleCard('a Parent', Assets.icons.parents),
                    _buildRoleCard('a Teacher', Assets.icons.teacher),
                    _buildRoleCard('an Assistant', Assets.icons.assistant),
                  ],
                ),
              ),

              // Next Button
              ButtonWidget(
                  label: AppStrings.next,
                gradient: AppColors.primaryButtonGradient,
              ),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _selectedRole == null ? null : () {
                    //Navigate to next screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC9A66B), // Golden tan color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard(String title, String assetPath) {
    bool isSelected = _selectedRole == title;

    return GestureDetector(
      onTap: () => setState(() => _selectedRole = title),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : const Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF4A6D65) : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            // Icon Container
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: SvgPicture.asset(assetPath, fit: BoxFit.contain),
            ),
            const SizedBox(width: 16),
            // Text Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "I'm $title",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? const Color(0xFF4A6D65) : Colors.grey[700],
                    ),
                  ),
                  Text(
                    'Sign in / Sign up as $title',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}