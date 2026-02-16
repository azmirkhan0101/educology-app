import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/assets_gen/assets.gen.dart';

// --- Controller for state management ---
class SignupController extends GetxController {
  var isObscurePassword = true.obs;
  var isObscureConfirmPassword = true.obs;
  var isAgreed = false.obs;

  void togglePassword() => isObscurePassword.toggle();
  void toggleConfirmPassword() => isObscureConfirmPassword.toggle();
  void toggleAgreement(bool? value) => isAgreed.value = value ?? false;
}

// --- Main Screen ---
class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final SignupController controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            // Logo Section
            SvgPicture.asset(
              Assets.icons.appLogo, // Ensure path is correct
              height: 120,
            ),
            const SizedBox(height: 32),

            const Text(
              'Create An Account',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D5669), // Match the dark teal
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Fill in your information.',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 32),

            // Form Fields
            _buildTextField(label: 'Name', hint: 'Enter your name'),
            const SizedBox(height: 16),
            _buildTextField(label: 'Email', hint: 'Enter your email'),
            const SizedBox(height: 16),
            _buildTextField(label: 'Phone', hint: 'Enter your phone number'), // Fixed hint from image
            const SizedBox(height: 16),

            // Password Field
            Obx(() => _buildTextField(
              label: 'New Password',
              hint: 'Enter your Password',
              isPassword: true,
              obscureText: controller.isObscurePassword.value,
              onToggle: controller.togglePassword,
            )),
            const SizedBox(height: 16),

            // Confirm Password Field
            Obx(() => _buildTextField(
              label: 'Confirm Password',
              hint: 'Enter your Password',
              isPassword: true,
              obscureText: controller.isObscureConfirmPassword.value,
              onToggle: controller.toggleConfirmPassword,
            )),
            const SizedBox(height: 20),

            // Terms and Privacy Checkbox
            Obx(() => Row(
              children: [
                Checkbox(
                  value: controller.isAgreed.value,
                  onChanged: controller.toggleAgreement,
                  activeColor: const Color(0xFF2D5669),
                ),
                const Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: 'I agree with this ',
                      children: [
                        TextSpan(
                          text: 'Terms of Use',
                          style: TextStyle(color: Color(0xFF2D5669), fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(color: Color(0xFF2D5669), fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            )),
            const SizedBox(height: 32),

            // Sign Up Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD4A762), // Muted gold/brown
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Sign In Footer
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account? '),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                      color: Color(0xFF2D5669),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // Helper method for text fields to keep code clean
  Widget _buildTextField({
    required String label,
    required String hint,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onToggle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black87),
        ),
        const SizedBox(height: 8),
        TextField(
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            filled: true,
            fillColor: const Color(0xFFF9F9F9),
            suffixIcon: isPassword
                ? IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                color: Colors.grey,
              ),
              onPressed: onToggle,
            )
                : null,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
          ),
        ),
      ],
    );
  }
}