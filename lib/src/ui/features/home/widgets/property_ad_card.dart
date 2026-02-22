import 'dart:convert';

import 'package:estatehub_app/src/config/l10n/gen/app_localizations.dart';
import 'package:estatehub_app/src/data/models/property_ad_model.dart';
import 'package:estatehub_app/src/ui/core/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PropertyAdCard extends StatelessWidget {
  final PropertyAdModel ad;
  final VoidCallback? onTap;

  const PropertyAdCard({super.key, required this.ad, this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final brlFormatter = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$ ',
      decimalDigits: 0,
    );
    final usdFormatter = NumberFormat.currency(
      locale: 'en_US',
      symbol: 'USD \$ ',
      decimalDigits: 0,
    );

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: cs.secondary,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: cs.shadow,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _PropertyImage(imageData: ad.imageData),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _TypeBadge(type: ad.type),
                      const Spacer(),
                      Text(
                        brlFormatter.format(ad.priceBrl),
                        style: AppTextStyles.textBold16.copyWith(
                          color: cs.inversePrimary,
                        ),
                      ),
                    ],
                  ),
                  if (ad.priceUsd != null) ...[
                    const SizedBox(height: 2),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        usdFormatter.format(ad.priceUsd),
                        style: AppTextStyles.text12.copyWith(
                          color: cs.primary.withValues(alpha: 0.6),
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 8),
                  Text(
                    '${ad.street}, ${ad.number}',
                    style: AppTextStyles.textBold14.copyWith(
                      color: cs.inversePrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${ad.neighborhood}, ${ad.city} - ${ad.state}',
                    style: AppTextStyles.text12.copyWith(
                      color: cs.primary.withValues(alpha: 0.7),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 12,
                        color: cs.primary.withValues(alpha: 0.5),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        ad.zipCode,
                        style: AppTextStyles.text12.copyWith(
                          color: cs.primary.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PropertyImage extends StatelessWidget {
  final String? imageData;

  const _PropertyImage({this.imageData});

  @override
  Widget build(BuildContext context) {
    if (imageData != null && imageData!.contains(',')) {
      try {
        final bytes = base64Decode(imageData!.split(',').last);
        return AspectRatio(
          aspectRatio: 16 / 9,
          child: Image.memory(bytes, fit: BoxFit.cover),
        );
      } catch (_) {}
    }

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Image.asset(
        'assets/images/jpg/standart_image.jpg',
        fit: BoxFit.cover,
      ),
    );
  }
}

class _TypeBadge extends StatelessWidget {
  final String type;

  const _TypeBadge({required this.type});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final loc = AppLocalizations.of(context)!;
    final isSale = type == 'SALE';
    final badgeColor = isSale
        ? cs.tertiary.withValues(alpha: 0.15)
        : cs.inversePrimary.withValues(alpha: 0.1);
    final textColor = isSale ? cs.tertiary : cs.inversePrimary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        isSale ? loc.homeFilterSale : loc.homeFilterRent,
        style: AppTextStyles.textBold12.copyWith(color: textColor),
      ),
    );
  }
}



