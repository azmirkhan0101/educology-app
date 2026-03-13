import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTimePicker extends FormField<String> {
  final String? label;
  final Function(String?) onTimeSelected;
  final String? initialValue;
  final Color backgroundColor;

  CustomTimePicker({
    super.key,
    required this.label,
    required this.onTimeSelected,
    this.initialValue,
    super.validator,
    this.backgroundColor = const Color(0xFFF9F9F9),
  }) : super(
    initialValue: initialValue,
    builder: (FormFieldState<String> state) {
      return _CustomTimePickerView(
        state: state,
        label: label,
        onTimeSelected: onTimeSelected,
        backgroundColor: backgroundColor,
      );
    },
  );
}

class _CustomTimePickerView extends StatelessWidget {
  final FormFieldState<String> state;
  final String? label;
  final Function(String?) onTimeSelected;
  final Color backgroundColor;

  const _CustomTimePickerView({
    required this.state,
    required this.label,
    required this.onTimeSelected,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label!,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        if (label != null) const SizedBox(height: 8),
        Card(
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
            side: BorderSide(
              width: 1,
              color: state.hasError ? Colors.red : const Color(0xFFE0E0E0),
            ),
          ),
          elevation: 0,
          child: Padding(
            padding: EdgeInsets.only(left: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  state.value ?? "Select Time",
                  style: TextStyle(
                    color: state.value == null ? Colors.grey : Colors.black,
                    fontSize: 14,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.access_time, color: Colors.grey),
                  onPressed: () => _pickTime(context),
                ),
              ],
            ),
          ),
        ),
        if (state.hasError)
          Padding(
            padding: EdgeInsets.only(left: 12.w, top: 5.h),
            child: Text(
              state.errorText ?? '',
              style: TextStyle(color: Colors.red.shade700, fontSize: 12.sp),
            ),
          ),
      ],
    );
  }

  Future<void> _pickTime(BuildContext context) async {
    // Standard Material Time Picker (You can style this via Theme)
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.green, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black, // Body text color
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      // 1. Convert TimeOfDay to the String format you want: "10:00 AM"
      final String formattedTime = picked.format(context);

      // 2. Update FormField state so validation/UI updates
      state.didChange(formattedTime);

      // 3. Trigger the callback
      onTimeSelected(formattedTime);
    }
  }
}