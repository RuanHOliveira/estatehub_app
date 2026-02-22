import 'package:estatehub_app/src/config/l10n/gen/app_localizations.dart';
import 'package:estatehub_app/src/routing/routes.dart';
import 'package:estatehub_app/src/ui/core/widgets/buttons/multi_text_button.dart';
import 'package:estatehub_app/src/ui/core/widgets/buttons/primary_button.dart';
import 'package:estatehub_app/src/ui/core/widgets/inputs/custom_text_form_field.dart';
import 'package:estatehub_app/src/ui/core/widgets/inputs/password_form_field.dart';
import 'package:estatehub_app/src/ui/core/widgets/useful/custom_toast.dart';
import 'package:estatehub_app/src/ui/core/themes/app_text_styles.dart';
import 'package:estatehub_app/src/ui/features/auth/register/ui/register_viewmodel.dart';
import 'package:estatehub_app/src/utils/error_mapper.dart';
import 'package:estatehub_app/src/utils/result.dart';
import 'package:estatehub_app/src/utils/validators/credentials_model.dart';
import 'package:estatehub_app/src/utils/validators/credentials_validator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  final RegisterViewModel registerViewModel;

  const RegisterScreen({super.key, required this.registerViewModel});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _confirmEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final CredentialsModel credentialsModel = CredentialsModel();
  final CredentialsValidator credentialsValidator = CredentialsValidator();
  final CustomToast _customToast = CustomToast();

  @override
  void initState() {
    super.initState();
    widget.registerViewModel.register.addListener(_listener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.registerViewModel.register.clearResult();
    });
  }

  @override
  void didUpdateWidget(covariant RegisterScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.registerViewModel.register.removeListener(_listener);
    widget.registerViewModel.register.addListener(_listener);
  }

  @override
  void dispose() {
    widget.registerViewModel.register.removeListener(_listener);
    _nameController.dispose();
    _emailController.dispose();
    _confirmEmailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    final ColorScheme cs = Theme.of(context).colorScheme;
    final AppLocalizations loc = AppLocalizations.of(context)!;

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: cs.surface,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_rounded, color: cs.primary),
              onPressed: () => context.go(Routes.login),
            ),
          ),
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
                  Icon(
                    Icons.lock_open,
                    size: deviceSize.width * 0.12,
                    color: cs.onPrimary,
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      loc.registerYourAccount,
                      style: AppTextStyles.textBold22.copyWith(
                        color: cs.onPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Form
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: credentialsModel.setName,
                          controller: _nameController,
                          hintText: loc.name,
                          validator: credentialsValidator.byField(
                            credentialsModel,
                            'name',
                          ),
                        ),
                        CustomTextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: credentialsModel.setEmail,
                          controller: _emailController,
                          hintText: loc.email,
                          validator: credentialsValidator.byField(
                            credentialsModel,
                            'email',
                          ),
                        ),
                        CustomTextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: credentialsModel.setConfirmEmail,
                          controller: _confirmEmailController,
                          hintText: loc.confirmEmail,
                          validator: credentialsValidator.byField(
                            credentialsModel,
                            'confirmEmail',
                          ),
                        ),
                        PasswordFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: credentialsModel.setRegisterPassword,
                          controller: _passwordController,
                          hintText: loc.password,
                          validator: credentialsValidator.byField(
                            credentialsModel,
                            'registerPassword',
                          ),
                        ),
                        PasswordFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: credentialsModel.setConfirmPassword,
                          controller: _confirmPasswordController,
                          hintText: loc.confirmPassword,
                          validator: credentialsValidator.byField(
                            credentialsModel,
                            'confirmPassword',
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListenableBuilder(
                      listenable: widget.registerViewModel.register,
                      builder: (context, _) {
                        return PrimaryButton(
                          text: loc.signUp,
                          isLoading: widget.registerViewModel.register.running,
                          disable: widget.registerViewModel.register.running,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await widget.registerViewModel.register.execute({
                                'email': _emailController.text,
                                'password': _passwordController.text,
                                'name': _nameController.text,
                              });
                            }
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 40),
                  MultiTextButton(
                    onPressed: () async => context.go(Routes.login),
                    children: [
                      Text(
                        '${loc.alreadyHaveAccount} ',
                        style: AppTextStyles.text14.copyWith(color: cs.primary),
                      ),
                      Text(
                        loc.signIn,
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
    switch (widget.registerViewModel.register.result) {
      case Success():
        _customToast.showToast(
          context,
          message: loc.registrationCompleted,
          toastType: 'success',
        );
        widget.registerViewModel.register.clearResult();
        context.go(Routes.mainNavigation);
        break;
      case Error(error: final e):
        _customToast.showToast(
          context,
          message: ErrorMapper.map(e.errorCode, loc),
          toastType: 'error',
        );
        widget.registerViewModel.register.clearResult();
      default:
    }
  }
}
