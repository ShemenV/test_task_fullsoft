import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final bool isLoading;
  const BaseButton({
    super.key,
    required this.onTap,
    required this.text,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 100),
      child: FilledButton(
        onPressed: onTap,

        child: isLoading
            ? SizedBox(
                width: 14,
                height: 14,
                child: CircularProgressIndicator(),
              )
            : Text(text),
      ),
    );
  }
}
