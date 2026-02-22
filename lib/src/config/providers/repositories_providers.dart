import 'package:estatehub_app/src/data/local/local_storage.dart';
import 'package:estatehub_app/src/ui/features/auth/login/data/login_repository.dart';
import 'package:estatehub_app/src/ui/features/auth/login/data/login_service.dart';
import 'package:estatehub_app/src/ui/features/auth/register/data/register_repository.dart';
import 'package:estatehub_app/src/ui/features/auth/register/data/register_service.dart';
import 'package:estatehub_app/src/ui/features/property_ads/data/property_ads_repository.dart';
import 'package:estatehub_app/src/ui/features/property_ads/data/property_ads_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> buildRepositoriesProviders() => [
  Provider<LocalStorage>(create: (_) => LocalStorage()),

  Provider<LoginRepository>(
    create: (context) => LoginRepository(
      loginService: context.read<LoginService>(),
      localStorage: context.read<LocalStorage>(),
    ),
  ),

  Provider<RegisterRepository>(
    create: (context) => RegisterRepository(
      registerService: context.read<RegisterService>(),
      localStorage: context.read<LocalStorage>(),
    ),
  ),

  Provider<PropertyAdsRepository>(
    create: (context) => PropertyAdsRepository(
      propertyAdsService: context.read<PropertyAdsService>(),
      localStorage: context.read<LocalStorage>(),
    ),
  ),
];
