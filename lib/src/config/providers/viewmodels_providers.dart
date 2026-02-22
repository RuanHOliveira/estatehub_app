import 'package:estatehub_app/src/ui/features/auth/login/data/login_repository.dart';
import 'package:estatehub_app/src/ui/features/auth/login/ui/login_viewmodel.dart';
import 'package:estatehub_app/src/ui/features/auth/register/data/register_repository.dart';
import 'package:estatehub_app/src/ui/features/auth/register/ui/register_viewmodel.dart';
import 'package:estatehub_app/src/ui/features/home/home_viewmodel.dart';
import 'package:estatehub_app/src/ui/features/main/ui/main_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> buildViewModelsProviders() => [
  ChangeNotifierProvider<LoginViewModel>(
    create: (context) =>
        LoginViewModel(loginRepository: context.read<LoginRepository>()),
  ),

  ChangeNotifierProvider<RegisterViewModel>(
    create: (context) => RegisterViewModel(
      registerRepository: context.read<RegisterRepository>(),
    ),
  ),

  ChangeNotifierProvider<HomeViewModel>(create: (context) => HomeViewModel()),

  ChangeNotifierProvider<MainViewModel>(
    create: (context) =>
        MainViewModel(homeViewModel: context.read<HomeViewModel>()),
  ),
];
