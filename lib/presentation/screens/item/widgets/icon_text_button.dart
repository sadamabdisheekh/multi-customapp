import 'package:flutter/material.dart';

class IconTextButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const IconTextButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          if (text.isNotEmpty) ...[
            const SizedBox(width: 4), // Add spacing only if text is not empty
            Text(
              text,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
