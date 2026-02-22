import 'package:estatehub_app/src/config/providers/repositories_providers.dart';
import 'package:estatehub_app/src/config/providers/services_providers.dart';
import 'package:estatehub_app/src/config/providers/viewmodels_providers.dart';
import 'package:estatehub_app/src/ui/core/themes/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> buildAppProviders() => [
  ChangeNotifierProvider(create: (_) => ThemeProvider()),
  ...buildServicesProviders(),
  ...buildRepositoriesProviders(),
  ...buildViewModelsProviders(),
];
