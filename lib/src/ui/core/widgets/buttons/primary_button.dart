import 'package:estatehub_app/src/ui/core/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final bool disable;
  final bool? isLoading;
  final String text;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.disable,
    this.isLoading = false,
    this.onPressed,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;

    final Color backgroundColor = widget.disable
        ? cs.secondary.withValues(alpha: 0.4)
        : cs.secondary;

    final Color textColor = widget.disable
        ? cs.onSecondary.withValues(alpha: 0.7)
        : cs.onSecondary;

    return Material(
      color: Colors.transparent,
      child: Ink(
        height: 54.0,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          onTap: !widget.disable ? widget.onPressed : null,
          splashColor: cs.onSecondary.withValues(alpha: 0.1),
          highlightColor: Colors.transparent,
          child: Center(
            child: widget.isLoading!
                ? CircularProgressIndicator(
                    color: cs.inversePrimary,
                    strokeWidth: 2.5,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.text,
                        style: AppTextStyles.text18.copyWith(color: textColor),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
