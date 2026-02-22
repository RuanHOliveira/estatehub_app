import 'package:estatehub_app/src/config/l10n/gen/app_localizations.dart';
import 'package:estatehub_app/src/data/local/local_storage.dart';
import 'package:estatehub_app/src/routing/routes.dart';
import 'package:estatehub_app/src/ui/core/themes/app_text_styles.dart';
import 'package:estatehub_app/src/ui/features/home/home_screen.dart';
import 'package:estatehub_app/src/ui/features/main/ui/main_viewmodel.dart';
import 'package:estatehub_app/src/ui/features/settings/ui/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MainNavigation extends StatefulWidget {
  final MainViewModel mainViewmodel;
  final bool refreshHomeOnInit;

  const MainNavigation({
    super.key,
    required this.mainViewmodel,
    this.refreshHomeOnInit = true,
  });

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  void changeScreen(int selectedIndex) {
    widget.mainViewmodel.screenSelect(selectedIndex);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;

    return ListenableBuilder(
      listenable: widget.mainViewmodel,
      builder: (BuildContext context, Widget? child) {
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: cs.surface,
          drawer: _AppDrawer(
            currentIndex: widget.mainViewmodel.selectedIndex,
            onItemSelected: changeScreen,
          ),
          floatingActionButton: widget.mainViewmodel.selectedIndex == 0
              ? FloatingActionButton(
                  onPressed: () => context.go(Routes.createPropertyAd),
                  backgroundColor: cs.inversePrimary,
                  tooltip: loc.createAdTitle,
                  child: Icon(Icons.add_rounded, color: cs.secondary),
                )
              : null,
          body: IndexedStack(
            index: widget.mainViewmodel.selectedIndex,
            children: [
              HomeScreen(
                homeViewModel: widget.mainViewmodel.homeViewModel,
                refreshOnInit: widget.refreshHomeOnInit,
              ),
              SettingsScreen(),
            ],
          ),
        );
      },
    );
  }
}

class _AppDrawer extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onItemSelected;

  const _AppDrawer({required this.currentIndex, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final padding = MediaQuery.of(context).padding;
    final loc = AppLocalizations.of(context)!;

    return Drawer(
      backgroundColor: cs.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      width: 280,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(28, padding.top + 32, 28, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: cs.inversePrimary,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: cs.shadow.withValues(alpha: 0.2),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.home_work_rounded,
                    size: 38,
                    color: cs.secondary,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'EstateHub',
                  style: AppTextStyles.textBold24.copyWith(letterSpacing: 1),
                ),
              ],
            ),
          ),

          // Navigation Items
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(color: cs.secondary),
                  const SizedBox(height: 8),
                  _DrawerItem(
                    index: 0,
                    label: loc.home,
                    icon: Icons.home_rounded,
                    isSelected: currentIndex == 0,
                    onTap: onItemSelected,
                  ),
                  _DrawerItem(
                    index: 1,
                    label: loc.settings,
                    icon: Icons.settings_rounded,
                    isSelected: currentIndex == 1,
                    onTap: onItemSelected,
                  ),
                  const Spacer(),
                  _DrawerActionItem(
                    label: loc.logout,
                    icon: Icons.logout,
                    onTap: () async {
                      final localStorage = context.read<LocalStorage>();
                      final mainViewModel = context.read<MainViewModel>();
                      mainViewModel.reset();
                      await localStorage.clear();

                      if (context.mounted) {
                        context.go(Routes.login);
                      }
                    },
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final int index;
  final String label;
  final IconData icon;
  final bool isSelected;
  final ValueChanged<int> onTap;

  const _DrawerItem({
    required this.index,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onTap(index),
          borderRadius: BorderRadius.circular(16),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: isSelected ? cs.secondary : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isSelected ? cs.inversePrimary : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    size: 20,
                    color: isSelected ? cs.secondary : cs.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected
                        ? cs.inversePrimary
                        : cs.inversePrimary.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DrawerActionItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _DrawerActionItem({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            HapticFeedback.lightImpact();
            onTap();
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Icon(icon, size: 20, color: cs.primary),
                ),
                const SizedBox(width: 16),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: cs.inversePrimary.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
