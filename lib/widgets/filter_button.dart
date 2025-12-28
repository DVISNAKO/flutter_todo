import 'package:flutter/material.dart';

enum TodoFilter {
  all,
  completed,
  active,
}


class FilterButton extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const FilterButton({
    super.key,
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: isActive ? Colors.blue : Colors.grey,
      ),
      child: Text(title),
    );
  }
}
