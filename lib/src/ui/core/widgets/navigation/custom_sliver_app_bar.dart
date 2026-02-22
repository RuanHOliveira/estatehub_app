import 'package:estatehub_app/src/routing/routes.dart';
import 'package:estatehub_app/src/ui/core/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomSliverAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String? title;
  final bool showDrawerButton;
  final bool showBackButton;
  final String? route;
  final List<Widget>? actions;

  const CustomSliverAppBar({
    super.key,
    this.title,
    this.actions,
    required this.showDrawerButton,
    required this.showBackButton,
    this.route,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SliverAppBar(
      pinned: true,
      backgroundColor: cs.secondary,
      surfaceTintColor: Colors.transparent,
      shape: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(16),
      ),
      automaticallyImplyLeading: false,
      title: Text(
        title ?? '',
        style: AppTextStyles.textBold22.copyWith(
          color: cs.inversePrimary,
          letterSpacing: -0.5,
        ),
      ),
      leading: showDrawerButton
          ? Row(
              children: [
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: cs.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.menu_rounded,
                      color: cs.inversePrimary,
                      size: 20,
                    ),
                  ),
                ),
              ],
            )
          : showBackButton
          ? Row(
              children: [
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => context.go(route ?? Routes.mainNavigation),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: cs.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.arrow_back_rounded,
                      color: cs.inversePrimary,
                      size: 20,
                    ),
                  ),
                ),
              ],
            )
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
