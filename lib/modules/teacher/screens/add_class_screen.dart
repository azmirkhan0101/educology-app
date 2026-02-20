// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// class AddClassScreen extends StatefulWidget {
//   const AddClassScreen({super.key});
//
//   @override
//   State<AddClassScreen> createState() => _AddClassScreenState();
// }
//
// class _AddClassScreenState extends State<AddClassScreen> {
//   // Controllers
//   final QuillController _quillController = QuillController.basic();
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _dateController = TextEditingController();
//   final TextEditingController _timeController = TextEditingController();
//
//   // Date/Time Pickers
//   Future<void> _selectDate() async {
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//     );
//     if (picked != null) {
//       setState(() => _dateController.text = DateFormat('dd-MM-yyyy').format(picked));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         leading: const Icon(Icons.arrow_back, color: Colors.black),
//         title: const Text("Add Class", style: TextStyle(color: Color(0xFF334E68))),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildLabel("Title"),
//             TextField(
//               controller: _titleController,
//               decoration: _inputDecoration("Enter Class Name"),
//             ),
//             const SizedBox(height: 20),
//
//             _buildLabel("Expected Live Class starting Date & Time"),
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _dateController,
//                     readOnly: true,
//                     onTap: _selectDate,
//                     decoration: _inputDecoration("DD-MM-YYYY", suffixIcon: Icons.calendar_month_outlined),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: TextField(
//                     controller: _timeController,
//                     readOnly: true,
//                     decoration: _inputDecoration("-- : -- AM", suffixIcon: Icons.access_time),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//
//             _buildLabel("Add Class Details"),
//             _buildRichTextEditor(),
//             const SizedBox(height: 20),
//
//             _buildLabel("Attached Document (Optional)"),
//             _buildUploadSection(),
//             const SizedBox(height: 30),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // --- UI Components ---
//
//   Widget _buildLabel(String text) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0),
//       child: Text(text, style: const TextStyle(color: Colors.grey, fontSize: 14)),
//     );
//   }
//
//   InputDecoration _inputDecoration(String hint, {IconData? suffixIcon}) {
//     return InputDecoration(
//       hintText: hint,
//       hintStyle: const TextStyle(color: Colors.black26, fontSize: 14),
//       filled: true,
//       fillColor: const Color(0xFFF7F8FA),
//       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       suffixIcon: suffixIcon != null ? Icon(suffixIcon, color: Colors.black87) : null,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: BorderSide.none,
//       ),
//     );
//   }
//
//   Widget _buildRichTextEditor() {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.black12),
//         borderRadius: BorderRadius.circular(8),
//         color: const Color(0xFFF7F8FA),
//       ),
//       child: Column(
//         children: [
//           // Toolbar
//           QuillSimpleToolbar(
//             controller: _quillController,
//             configurations: const QuillSimpleToolbarConfigurations(
//               showSearchButton: false,
//               showFontFamily: false,
//               showFontSize: false,
//               showCodeBlock: false,
//               showInlineCode: false,
//               showSubscript: false,
//               showSuperscript: false,
//               multiRowsDisplay: true,
//             ),
//           ),
//           const Divider(height: 1, thickness: 1),
//           // Editor Area
//           SizedBox(
//             height: 200,
//             child: QuillEditor.basic(
//               controller: _quillController,
//               configurations: const QuillEditorConfigurations(
//                 placeholder: 'Type here...',
//                 padding: EdgeInsets.all(10),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildUploadSection() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(vertical: 20),
//       decoration: BoxDecoration(
//         color: const Color(0xFFF7F8FA),
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: Colors.black12),
//       ),
//       child: Column(
//         children: [
//           const Icon(Icons.cloud_upload_outlined, size: 32, color: Colors.black87),
//           const SizedBox(height: 10),
//           ElevatedButton(
//             onPressed: () {},
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF334E68),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//               padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
//             ),
//             child: const Text("Upload File", style: TextStyle(color: Colors.white)),
//           ),
//         ],
//       ),
//     );
//   }
// }