import 'package:estatehub_app/src/config/l10n/gen/app_localizations.dart';
import 'package:estatehub_app/src/ui/core/themes/app_text_styles.dart';
import 'package:estatehub_app/src/ui/core/widgets/navigation/custom_sliver_app_bar.dart';
import 'package:estatehub_app/src/ui/core/widgets/useful/custom_toast.dart';
import 'package:estatehub_app/src/ui/features/home/home_viewmodel.dart';
import 'package:estatehub_app/src/ui/features/home/widgets/property_ad_card.dart';
import 'package:estatehub_app/src/utils/error_mapper.dart';
import 'package:estatehub_app/src/utils/result.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final HomeViewModel _homeViewModel;
  final bool refreshOnInit;

  const HomeScreen({
    super.key,
    required HomeViewModel homeViewModel,
    this.refreshOnInit = true,
  }) : _homeViewModel = homeViewModel;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final CustomToast _customToast = CustomToast();

  @override
  void initState() {
    super.initState();
    widget._homeViewModel.loadAds.addListener(_onLoadAdsResult);
    if (widget.refreshOnInit) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget._homeViewModel.loadAds.execute();
      });
    }
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget._homeViewModel.loadAds.removeListener(_onLoadAdsResult);
    widget._homeViewModel.loadAds.addListener(_onLoadAdsResult);
  }

  @override
  void dispose() {
    widget._homeViewModel.loadAds.removeListener(_onLoadAdsResult);
    _searchController.dispose();
    super.dispose();
  }

  void _onLoadAdsResult() {
    final loc = AppLocalizations.of(context)!;
    if (widget._homeViewModel.loadAds.result case Error(error: final e)) {
      _customToast.showToast(
        context,
        message: ErrorMapper.map(e.errorCode, loc),
        toastType: 'error',
      );
      widget._homeViewModel.loadAds.clearResult();
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return ListenableBuilder(
      listenable: Listenable.merge([
        widget._homeViewModel,
        widget._homeViewModel.loadAds,
      ]),
      builder: (context, _) {
        final vm = widget._homeViewModel;
        final isLoading = vm.loadAds.running;
        final hasError = vm.loadAds.error;
        final ads = vm.filteredAds;

        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            CustomSliverAppBar(
              title: loc.home,
              showDrawerButton: true,
              showBackButton: false,
              actions: [
                _RefreshButton(
                  isLoading: isLoading,
                  onTap: () => vm.loadAds.execute(),
                ),
                const SizedBox(width: 8),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: Column(
                  children: [
                    _SearchBar(
                      controller: _searchController,
                      hintText: loc.homeSearchHint,
                      onChanged: vm.setSearchText,
                    ),
                    const SizedBox(height: 12),
                    _FilterChipBar(
                      activeFilter: vm.activeFilter,
                      onFilterSelected: vm.setFilter,
                      loc: loc,
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            if (isLoading)
              const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              )
            else if (hasError && ads.isEmpty)
              SliverFillRemaining(
                child: _ErrorState(
                  message: loc.homeLoadError,
                  onRetry: () => vm.loadAds.execute(),
                ),
              )
            else if (ads.isEmpty)
              SliverFillRemaining(
                child: _EmptyState(
                  title: loc.homeEmptyTitle,
                  description: loc.homeEmptyDescription,
                ),
              )
            else
              SliverLayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.crossAxisExtent;
                  final crossAxisCount =
                      width < 500 ? 1 : width < 800 ? 2 : width < 1200 ? 3 : 4;
                  const spacing = 12.0;
                  final cardWidth =
                      (width - 32 - (crossAxisCount - 1) * spacing) /
                      crossAxisCount;
                  final mainAxisExtent = cardWidth * 9 / 16 + 140.0;

                  return SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: spacing,
                        mainAxisSpacing: spacing,
                        mainAxisExtent: mainAxisExtent,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final ad = ads[index];
                          return PropertyAdCard(
                            ad: ad,
                            onTap: () {
                              // TODO: navigate to property ad detail
                              print('Tap: ${ad.id}');
                            },
                          );
                        },
                        childCount: ads.length,
                      ),
                    ),
                  );
                },
              ),
          ],
        );
      },
    );
  }
}

class _RefreshButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onTap;

  const _RefreshButton({required this.isLoading, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: cs.inversePrimary,
                ),
              )
            : Icon(
                Icons.refresh_rounded,
                color: cs.inversePrimary,
                size: 20,
              ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String> onChanged;

  const _SearchBar({
    required this.controller,
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: cs.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: AppTextStyles.text14.copyWith(color: cs.inversePrimary),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyles.text14.copyWith(
            color: cs.primary.withValues(alpha: 0.5),
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: cs.primary.withValues(alpha: 0.5),
            size: 20,
          ),
          suffixIcon: controller.text.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    controller.clear();
                    onChanged('');
                  },
                  child: Icon(
                    Icons.close_rounded,
                    color: cs.primary.withValues(alpha: 0.5),
                    size: 18,
                  ),
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}

class _FilterChipBar extends StatelessWidget {
  final PropertyAdFilter activeFilter;
  final ValueChanged<PropertyAdFilter> onFilterSelected;
  final AppLocalizations loc;

  const _FilterChipBar({
    required this.activeFilter,
    required this.onFilterSelected,
    required this.loc,
  });

  @override
  Widget build(BuildContext context) {
    final filters = [
      (PropertyAdFilter.all, loc.homeFilterAll),
      (PropertyAdFilter.myAds, loc.homeFilterMyAds),
      (PropertyAdFilter.rent, loc.homeFilterRent),
      (PropertyAdFilter.sale, loc.homeFilterSale),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((entry) {
          final (filter, label) = entry;
          final isSelected = activeFilter == filter;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: _FilterChip(
              label: label,
              isSelected: isSelected,
              onTap: () => onFilterSelected(filter),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? cs.inversePrimary : cs.secondary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? cs.secondary : cs.inversePrimary,
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String title;
  final String description;

  const _EmptyState({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 56,
              color: cs.primary.withValues(alpha: 0.3),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: AppTextStyles.textBold16.copyWith(
                color: cs.inversePrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: AppTextStyles.text14.copyWith(
                color: cs.primary.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final loc = AppLocalizations.of(context)!;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.wifi_off_rounded,
              size: 56,
              color: cs.primary.withValues(alpha: 0.3),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: AppTextStyles.textBold16.copyWith(
                color: cs.inversePrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: onRetry,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: cs.secondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  loc.homeRetry,
                  style: AppTextStyles.textBold14.copyWith(
                    color: cs.inversePrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
