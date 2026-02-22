import 'package:estatehub_app/src/config/l10n/gen/app_localizations.dart';
import 'package:estatehub_app/src/routing/routes.dart';
import 'package:estatehub_app/src/ui/core/widgets/buttons/multi_text_button.dart';
import 'package:estatehub_app/src/ui/core/widgets/buttons/primary_button.dart';
import 'package:estatehub_app/src/ui/core/widgets/inputs/custom_text_form_field.dart';
import 'package:estatehub_app/src/ui/core/widgets/inputs/password_form_field.dart';
import 'package:estatehub_app/src/ui/core/widgets/useful/custom_toast.dart';
import 'package:estatehub_app/src/ui/core/themes/app_text_styles.dart';
import 'package:estatehub_app/src/ui/features/auth/login/ui/login_viewmodel.dart';
import 'package:estatehub_app/src/utils/error_mapper.dart';
import 'package:estatehub_app/src/utils/result.dart';
import 'package:estatehub_app/src/utils/validators/credentials_model.dart';
import 'package:estatehub_app/src/utils/validators/credentials_validator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  final LoginViewModel loginViewModel;

  const LoginScreen({super.key, required this.loginViewModel});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final CredentialsModel _credentialsModel = CredentialsModel();
  final CredentialsValidator _credentialsValidator = CredentialsValidator();
  final CustomToast _customToast = CustomToast();

  @override
  void initState() {
    super.initState();
    widget.loginViewModel.login.addListener(_listener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.loginViewModel.login.clearResult();
    });
  }

  @override
  void didUpdateWidget(covariant LoginScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.loginViewModel.login.removeListener(_listener);
    widget.loginViewModel.login.addListener(_listener);
  }

  @override
  void dispose() {
    widget.loginViewModel.login.removeListener(_listener);
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    final ColorScheme cs = Theme.of(context).colorScheme;
    final AppLocalizations loc = AppLocalizations.of(context)!;

    return Scaffold(
      body: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: deviceSize.width * 0.02,
                vertical: deviceSize.height * 0.01,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Icon(
                    Icons.home_work_rounded,
                    size: deviceSize.width * 0.12,
                    color: cs.onPrimary,
                  ),
                  const SizedBox(height: 8),
                  // Título
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'EstateHub',
                      style: AppTextStyles.textBold24.copyWith(
                        color: cs.onPrimary,
                        letterSpacing: 3,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Form
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: _credentialsModel.setEmail,
                          controller: _emailController,
                          hintText: loc.email,
                          validator: _credentialsValidator.byField(
                            _credentialsModel,
                            'email',
                          ),
                        ),
                        PasswordFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: _credentialsModel.setPassword,
                          controller: _passwordController,
                          hintText: loc.password,
                          validator: _credentialsValidator.byField(
                            _credentialsModel,
                            'password',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  // Acessar
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListenableBuilder(
                      listenable: widget.loginViewModel.login,
                      builder: (context, _) {
                        return PrimaryButton(
                          text: loc.signIn,
                          isLoading: widget.loginViewModel.login.running,
                          disable: widget.loginViewModel.login.running,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await widget.loginViewModel.login.execute({
                                'email': _emailController.text,
                                'password': _passwordController.text,
                              });
                            }
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 40),
                  MultiTextButton(
                    onPressed: () async => context.go(Routes.register),
                    children: [
                      Text(
                        '${loc.dontHaveAccount} ',
                        style: AppTextStyles.text14.copyWith(color: cs.primary),
                      ),
                      Text(
                        loc.registerNow,
                        style: AppTextStyles.textBold14.copyWith(
                          color: cs.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _listener() {
    final loc = AppLocalizations.of(context)!;
    switch (widget.loginViewModel.login.result) {
      case Success():
        widget.loginViewModel.login.clearResult();
        context.go(Routes.mainNavigation);
        break;
      case Error(error: final e):
        _customToast.showToast(
          context,
          message: ErrorMapper.map(e.errorCode, loc),
          toastType: 'error',
        );
        widget.loginViewModel.login.clearResult();
      default:
    }
  }
}
