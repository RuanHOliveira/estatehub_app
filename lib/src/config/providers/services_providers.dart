import 'package:estatehub_app/src/data/remoto/api_service.dart';
import 'package:estatehub_app/src/ui/features/auth/login/data/login_service.dart';
import 'package:estatehub_app/src/ui/features/auth/register/data/register_service.dart';
import 'package:estatehub_app/src/ui/features/exchange_rates/data/exchange_rate_service.dart';
import 'package:estatehub_app/src/ui/features/property_ads/data/property_ads_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> buildServicesProviders() => [
  Provider<ApiService>(create: (_) => ApiService()),

  Provider<LoginService>(
    create: (context) => LoginService(apiService: context.read<ApiService>()),
  ),

  Provider<RegisterService>(
    create: (context) =>
        RegisterService(apiService: context.read<ApiService>()),
  ),

  Provider<PropertyAdsService>(
    create: (context) =>
        PropertyAdsService(apiService: context.read<ApiService>()),
  ),

  Provider<ExchangeRateService>(
    create: (context) =>
        ExchangeRateService(apiService: context.read<ApiService>()),
  ),
];
