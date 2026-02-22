import 'package:estatehub_app/src/config/l10n/gen/app_localizations.dart';
import 'package:estatehub_app/src/ui/core/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExchangeRateDialogContent extends StatelessWidget {
  final TextEditingController controller;
  final ValueNotifier<String?> errorNotifier;

  const ExchangeRateDialogContent({
    super.key,
    required this.controller,
    required this.errorNotifier,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;

    return ValueListenableBuilder<String?>(
      valueListenable: errorNotifier,
      builder: (context, error, _) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: cs.secondary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    loc.exchangeRateFieldLabel,
                    style: AppTextStyles.text12.copyWith(
                      color: cs.primary.withValues(alpha: 0.6),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      _ExchangeRateFormatter(),
                    ],
                    style: AppTextStyles.textBold24.copyWith(
                      color: cs.inversePrimary,
                    ),
                    decoration: InputDecoration(
                      hintText: loc.exchangeRateFieldHint,
                      hintStyle: AppTextStyles.textBold24.copyWith(
                        color: cs.primary.withValues(alpha: 0.25),
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ),
            if (error != null) ...[
              const SizedBox(height: 8),
              Text(
                error,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: cs.error),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _ExchangeRateFormatter extends TextInputFormatter {
  static const int _maxDigits = 5;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    if (digits.isEmpty) {
      return newValue.copyWith(text: '');
    }

    if (digits.length > _maxDigits) {
      final formatted = _format(
        oldValue.text.replaceAll(RegExp(r'[^\d]'), ''),
      );
      return oldValue.copyWith(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }

    final formatted = _format(digits);
    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  String _format(String digits) {
    if (digits.isEmpty) return '';
    final padded = digits.padLeft(3, '0');
    final intPart = padded.substring(0, padded.length - 2);
    final decPart = padded.substring(padded.length - 2);
    final intTrimmed = intPart.replaceFirst(RegExp(r'^0+(?=\d)'), '');
    final intDisplay = intTrimmed.isEmpty ? '0' : intTrimmed;
    return '$intDisplay,$decPart';
  }
}
