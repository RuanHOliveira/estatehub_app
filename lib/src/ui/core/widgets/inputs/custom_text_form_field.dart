import 'package:estatehub_app/src/ui/core/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Widget? suffixIcon;
  final bool? obscureText;
  final FormFieldValidator<String>? validator;
  final EdgeInsets? padding;
  final ValueChanged<String>? onChanged;
  final AutovalidateMode? autovalidateMode;
  final double borderRadius;
  final int? minLines;
  final int? maxLines;
  final Color? fillColor;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.hintText,
    this.suffixIcon,
    this.obscureText,
    this.validator,
    this.padding,
    this.onChanged,
    this.autovalidateMode,
    this.borderRadius = 12,
    this.maxLines = 1,
    this.fillColor,
    this.minLines,
    this.keyboardType,
    this.inputFormatters,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  OutlineInputBorder _outline(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding:
          widget.padding ??
          const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      child: TextFormField(
        autovalidateMode: widget.autovalidateMode,
        onChanged: widget.onChanged,
        textInputAction: TextInputAction.next,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        onEditingComplete: () {
          final isMultiline = (widget.maxLines != null && widget.maxLines! > 1);
          if (isMultiline) return;
          FocusScope.of(context).nextFocus();
        },
        onTapOutside: (_) {
          if (FocusScope.of(context).hasFocus) {
            FocusScope.of(context).unfocus();
          }
        },
        enabled: true,
        controller: widget.controller,
        validator: widget.validator,
        style: AppTextStyles.text14.copyWith(color: cs.primary),
        keyboardType: widget.keyboardType ??
            ((widget.maxLines != null && widget.maxLines! > 1)
                ? TextInputType.multiline
                : TextInputType.text),
        inputFormatters: widget.inputFormatters,
        obscureText: widget.obscureText ?? false,
        cursorColor: cs.primary,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),
          filled: true,
          fillColor: widget.fillColor ?? cs.secondary,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: cs.primary),
          labelStyle: TextStyle(
            color: cs.primary,
            letterSpacing: 0.6,
            fontWeight: FontWeight.w600,
          ),
          border: _outline(Colors.transparent),
          enabledBorder: _outline(Colors.transparent),
          disabledBorder: _outline(Colors.transparent),

          focusedBorder: _outline(cs.primary, width: 1),
          errorBorder: _outline(cs.error),
          focusedErrorBorder: _outline(cs.error, width: 1),
          suffixIcon: widget.suffixIcon,
        ),
      ),
    );
  }
}
