import 'package:flutter/material.dart';

class StudentsReportScreen extends StatelessWidget {
  const StudentsReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text(
          'Students Report',
          style: TextStyle(color: Color(0xFF4A6572), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.file_download_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by name',
                prefixIcon: const Icon(Icons.search, color: Color(0xFF4A6572)),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Table Header
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _HeaderCell(label: 'Student Name', flex: 2),
                _HeaderCell(label: 'Attendance', flex: 2),
                _HeaderCell(label: 'H.w. Completed', flex: 2),
                _HeaderCell(label: 'H.w. Pending', flex: 2),
                _HeaderCell(label: 'Exam Grade', flex: 2),
              ],
            ),
          ),
          const Divider(thickness: 1),
          // Scrollable List
          Expanded(
            child: ListView.separated(
              itemCount: 20, // Number of students
              separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFEEEEEE)),
              itemBuilder: (context, index) {
                return const _StudentRow();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String label;
  final int flex;
  const _HeaderCell({required this.label, required this.flex});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Color(0xFF4A6572),
        ),
      ),
    );
  }
}

class _StudentRow extends StatelessWidget {
  const _StudentRow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
      child: Row(
        children: const [
          _DataCell(text: 'Rakibul Hasan', flex: 2, isName: true),
          _DataCell(text: '09/10 (90%)', flex: 2),
          _DataCell(text: '09/10', flex: 2),
          _DataCell(text: '01', flex: 2),
          _DataCell(text: '88%', flex: 2),
        ],
      ),
    );
  }
}

class _DataCell extends StatelessWidget {
  final String text;
  final int flex;
  final bool isName;
  const _DataCell({required this.text, required this.flex, this.isName = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 11,
          color: isName ? Colors.black87 : Colors.grey[600],
          fontWeight: isName ? FontWeight.w500 : FontWeight.normal,
        ),
      ),
    );
  }
}