import 'package:estatehub_app/src/ui/core/widgets/inputs/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class PasswordFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final AutovalidateMode? autovalidateMode;

  const PasswordFormField({
    super.key,
    this.controller,
    this.hintText,
    this.validator,
    this.onChanged,
    this.autovalidateMode,
  });

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  // Custom Password Form Field
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      autovalidateMode: widget.autovalidateMode,
      onChanged: widget.onChanged,
      obscureText: isHidden,
      controller: widget.controller,
      hintText: widget.hintText,
      validator: widget.validator,
      suffixIcon: InkWell(
        borderRadius: BorderRadius.circular(23.0),
        onTap: () {
          setState(() {
            isHidden = !isHidden;
          });
        },
        child: Icon(
          isHidden ? Icons.visibility : Icons.visibility_off,
          color: Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.6),
        ),
      ),
    );
  }
}
