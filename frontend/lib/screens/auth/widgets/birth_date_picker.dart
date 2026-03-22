import 'package:flutter/material.dart';

class BirthDatePicker extends StatelessWidget {
  final int selectedDay;
  final String selectedMonth;
  final int selectedYear;
  final List<int> days;
  final List<String> months;
  final List<int> years;
  final Function(int) onDayChanged;
  final Function(String) onMonthChanged;
  final Function(int) onYearChanged;

  const BirthDatePicker({
    super.key,
    required this.selectedDay,
    required this.selectedMonth,
    required this.selectedYear,
    required this.days,
    required this.months,
    required this.years,
    required this.onDayChanged,
    required this.onMonthChanged,
    required this.onYearChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildWheelPicker<int>(
          label: 'Day',
          items: days,
          initialItem: days.indexOf(selectedDay),
          onChanged: onDayChanged,
          width: 70,
        ),
        _buildWheelPicker<String>(
          label: 'Month',
          items: months,
          initialItem: months.indexOf(selectedMonth),
          onChanged: onMonthChanged,
          width: 140,
        ),
        _buildWheelPicker<int>(
          label: 'Year',
          items: years,
          initialItem: years.indexOf(selectedYear),
          onChanged: onYearChanged,
          width: 80,
        ),
      ],
    );
  }

  Widget _buildWheelPicker<T>({
    required String label,
    required List<T> items,
    required int initialItem,
    required ValueChanged<T> onChanged,
    required double width,
  }) {
    return Column(
      children: [
        Container(
          width: width,
          height: 60,
          decoration: ShapeDecoration(
            color: const Color(0xFFE8EDF2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x26000000),
                blurRadius: 20,
                offset: Offset(0, 4),
                spreadRadius: 0,
              ),
            ],
          ),
          child: ListWheelScrollView.useDelegate(
            itemExtent: 30,
            perspective: 0.005,
            diameterRatio: 1.2,
            physics: const FixedExtentScrollPhysics(),
            controller: FixedExtentScrollController(initialItem: initialItem),
            onSelectedItemChanged: (index) => onChanged(items[index]),
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: items.length,
              builder: (context, index) {
                return Center(
                  child: Text(
                    items[index].toString(),
                    style: const TextStyle(
                      color: Color(0xFF4F7A93),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF4F7A93),
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
