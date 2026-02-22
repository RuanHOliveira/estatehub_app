import 'package:flutter/material.dart';

enum LoadingStyle { spinnerOnConfirmButton, replaceButtons, disableConfirmOnly }

typedef ConfirmAsyncBool = Future<bool> Function();

Future<T?> showCustomGeneralDialog<T>(
  BuildContext context, {
  required String title,
  required String message,
  String? subMessage,

  VoidCallback? onConfirm,
  ConfirmAsyncBool? onConfirmAsync,

  Widget? content,

  IconData? icon,
  Color? iconColor,
  Color? iconBackgroundColor,

  VoidCallback? onCancel,

  String cancelText = 'Cancel',
  String confirmText = 'Confirm',
  Color? cancelColor,
  Color? cancelTextColor,
  Color? confirmColor,
  Color? confirmTextColor,

  LoadingStyle loadingStyle = LoadingStyle.spinnerOnConfirmButton,
  String loadingText = 'Loading...',
  bool blockBackWhenLoading = true,

  bool barrierDismissible = true,
  Duration transitionDuration = const Duration(milliseconds: 300),

  bool closeOnConfirmSync = true,
  bool closeOnConfirmAsyncOnSuccess = true,
}) {
  assert(onConfirm != null || onConfirmAsync != null);

  final cs = Theme.of(context).colorScheme;

  final Color resolvedCancelColor =
      cancelColor ?? cs.primary.withValues(alpha: 0.10);
  final Color resolvedCancelTextColor = cancelTextColor ?? cs.primary;

  final Color resolvedConfirmColor = confirmColor ?? Colors.red;
  final Color resolvedConfirmTextColor = confirmTextColor ?? Colors.white;

  final Color resolvedIconColor = iconColor ?? resolvedConfirmColor;
  final Color resolvedIconBgColor =
      iconBackgroundColor ?? resolvedConfirmColor.withValues(alpha: 0.10);

  final loading = ValueNotifier<bool>(false);

  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierLabel: 'Dismiss',
    barrierColor: Colors.black.withValues(alpha: 0.4),
    transitionDuration: transitionDuration,
    pageBuilder: (dialogContext, animation, secondaryAnimation) {
      Future<void> handleCancel(bool isLoading) async {
        if (isLoading && loadingStyle != LoadingStyle.disableConfirmOnly) {
          return;
        }

        if (onCancel != null) {
          onCancel();
        } else {
          Navigator.of(dialogContext).pop();
        }
      }

      Future<void> handleConfirm(bool isLoading) async {
        if (isLoading) return;

        if (onConfirmAsync != null) {
          loading.value = true;

          bool ok = false;
          try {
            ok = await onConfirmAsync();
          } catch (_) {
            ok = false;
          }

          loading.value = false;

          if (!dialogContext.mounted) return;

          if (ok && closeOnConfirmAsyncOnSuccess) {
            Navigator.of(dialogContext).pop();
          }
          return;
        }

        if (closeOnConfirmSync) {
          Navigator.of(dialogContext).pop();
        }
        onConfirm?.call();
      }

      final bottomInset = MediaQuery.of(dialogContext).viewInsets.bottom;

      return ValueListenableBuilder<bool>(
        valueListenable: loading,
        builder: (context, isLoading, _) {
          final effectiveBarrierDismissible = isLoading
              ? false
              : barrierDismissible;

          bool canTapCancel() {
            if (!isLoading) return true;
            return loadingStyle == LoadingStyle.disableConfirmOnly;
          }

          bool canTapConfirm() => !isLoading;

          Widget actionsArea() {
            if (isLoading && loadingStyle == LoadingStyle.replaceButtons) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 26,
                      width: 26,
                      child: CircularProgressIndicator(strokeWidth: 2.5),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      loadingText,
                      style: TextStyle(fontSize: 14, color: cs.primary),
                    ),
                  ],
                ),
              );
            }

            return Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: canTapCancel()
                        ? () => handleCancel(isLoading)
                        : null,
                    child: Opacity(
                      opacity: canTapCancel() ? 1.0 : 0.55,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: resolvedCancelColor,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(
                          child: Text(
                            cancelText,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: resolvedCancelTextColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: canTapConfirm()
                        ? () => handleConfirm(isLoading)
                        : null,
                    child: Opacity(
                      opacity: canTapConfirm() ? 1.0 : 0.75,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: resolvedConfirmColor,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(
                          child:
                              (isLoading &&
                                  loadingStyle ==
                                      LoadingStyle.spinnerOnConfirmButton)
                              ? const SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : Text(
                                  confirmText,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: resolvedConfirmTextColor,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          Widget dialogBody = SafeArea(
            child: Center(
              child: AnimatedPadding(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOut,
                padding: EdgeInsets.only(
                  left: 24,
                  right: 24,
                  bottom: bottomInset > 0 ? bottomInset : 0,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: cs.surface,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.10),
                          blurRadius: 30,
                          offset: const Offset(0, 15),
                        ),
                      ],
                    ),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 520),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (icon != null) ...[
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: resolvedIconBgColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Icon(
                                  icon,
                                  color: resolvedIconColor,
                                  size: 32,
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: cs.inversePrimary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              message,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 15, color: cs.primary),
                            ),
                            if (content != null) ...[
                              const SizedBox(height: 18),
                              content,
                            ],
                            if (subMessage != null) ...[
                              const SizedBox(height: 18),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.info_outline_rounded, size: 20),
                                  const SizedBox(width: 5),
                                  Flexible(
                                    child: Text(
                                      subMessage,
                                      textAlign: TextAlign.center,
                                      softWrap: true,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: cs.primary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            const SizedBox(height: 28),
                            actionsArea(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );

          if (isLoading && blockBackWhenLoading) {
            dialogBody = PopScope(canPop: false, child: dialogBody);
          }

          if (isLoading && effectiveBarrierDismissible) {
            dialogBody = IgnorePointer(ignoring: true, child: dialogBody);
          }

          return dialogBody;
        },
      );
    },
    transitionBuilder: (context, anim, secondaryAnim, child) {
      return FadeTransition(
        opacity: CurvedAnimation(parent: anim, curve: Curves.easeOut),
        child: ScaleTransition(
          scale: Tween(
            begin: 0.9,
            end: 1.0,
          ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOutCubic)),
          child: child,
        ),
      );
    },
  );
}
