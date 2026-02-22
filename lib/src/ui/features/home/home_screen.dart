import 'package:estatehub_app/src/config/l10n/gen/app_localizations.dart';
import 'package:estatehub_app/src/ui/core/widgets/navigation/custom_sliver_app_bar.dart';
import 'package:estatehub_app/src/ui/features/home/home_viewmodel.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final HomeViewModel _homeViewModel;

  const HomeScreen({super.key, required HomeViewModel homeViewModel})
    : _homeViewModel = homeViewModel;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        CustomSliverAppBar(
          title: loc.home,
          showDrawerButton: true,
          showBackButton: false,
        ),
        SliverFillRemaining(),
      ],
    );
  }
}
