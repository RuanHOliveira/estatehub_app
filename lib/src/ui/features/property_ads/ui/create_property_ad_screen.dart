import 'package:brasil_fields/brasil_fields.dart';
import 'package:estatehub_app/src/config/l10n/gen/app_localizations.dart';
import 'package:estatehub_app/src/routing/routes.dart';
import 'package:estatehub_app/src/ui/core/themes/app_text_styles.dart';
import 'package:estatehub_app/src/ui/core/widgets/buttons/primary_button.dart';
import 'package:estatehub_app/src/ui/core/widgets/inputs/custom_text_form_field.dart';
import 'package:estatehub_app/src/ui/core/widgets/navigation/custom_sliver_app_bar.dart';
import 'package:estatehub_app/src/ui/core/widgets/useful/custom_toast.dart';
import 'package:estatehub_app/src/ui/features/property_ads/data/property_ad_input.dart';
import 'package:estatehub_app/src/ui/features/property_ads/ui/create_property_ad_viewmodel.dart';
import 'package:estatehub_app/src/utils/error_mapper.dart';
import 'package:estatehub_app/src/utils/result.dart';
import 'package:estatehub_app/src/utils/validators/custom_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class CreatePropertyAdScreen extends StatefulWidget {
  final CreatePropertyAdViewModel _createPropertyAdViewModel;

  const CreatePropertyAdScreen({
    super.key,
    required CreatePropertyAdViewModel createPropertyAdViewModel,
  }) : _createPropertyAdViewModel = createPropertyAdViewModel;

  @override
  State<CreatePropertyAdScreen> createState() => _CreatePropertyAdScreenState();
}

class _CreatePropertyAdScreenState extends State<CreatePropertyAdScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CustomToast _customToast = CustomToast();
  final CustomValidators _validators = CustomValidators();
  final ImagePicker _imagePicker = ImagePicker();

  final _priceController = TextEditingController();
  final _zipController = TextEditingController();
  final _streetController = TextEditingController();
  final _numberController = TextEditingController();
  final _neighborhoodController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _complementController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget._createPropertyAdViewModel.fetchCepCommand.addListener(
      _onFetchCepResult,
    );
    widget._createPropertyAdViewModel.createAdCommand.addListener(
      _onCreateAdResult,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget._createPropertyAdViewModel.fetchCepCommand.clearResult();
      widget._createPropertyAdViewModel.createAdCommand.clearResult();
      widget._createPropertyAdViewModel.resetSelectedImage();
    });
  }

  @override
  void dispose() {
    widget._createPropertyAdViewModel.fetchCepCommand.removeListener(
      _onFetchCepResult,
    );
    widget._createPropertyAdViewModel.createAdCommand.removeListener(
      _onCreateAdResult,
    );
    _priceController.dispose();
    _zipController.dispose();
    _streetController.dispose();
    _numberController.dispose();
    _neighborhoodController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _complementController.dispose();
    super.dispose();
  }

  void _onFetchCepResult() {
    final loc = AppLocalizations.of(context)!;
    final vm = widget._createPropertyAdViewModel;
    final result = vm.fetchCepCommand.result;
    if (result == null) return;

    switch (result) {
      case Success():
        final address = vm.lastFetchedAddress;
        if (address != null) {
          _streetController.text = address.street;
          _neighborhoodController.text = address.neighborhood;
          _cityController.text = address.city;
          _stateController.text = address.state;
          if (address.complement.isNotEmpty) {
            _complementController.text = address.complement;
          }
        }
        break;
      case Error(error: final e):
        _customToast.showToast(
          context,
          message: ErrorMapper.map(e.errorCode, loc),
          toastType: 'warning',
        );
        break;
    }

    vm.fetchCepCommand.clearResult();
  }

  void _onCreateAdResult() {
    final loc = AppLocalizations.of(context)!;
    final vm = widget._createPropertyAdViewModel;
    final result = vm.createAdCommand.result;
    if (result == null) return;

    switch (result) {
      case Success():
        _customToast.showToast(
          context,
          message: loc.createAdSuccess,
          toastType: 'success',
        );
        if (context.mounted) {
          context.go(Routes.mainNavigation, extra: {'refreshHome': true});
        }
        break;
      case Error(error: final e):
        _customToast.showToast(
          context,
          message: ErrorMapper.map(e.errorCode, loc),
          toastType: 'error',
        );
        break;
    }

    vm.createAdCommand.clearResult();
  }

  void _onZipChanged(String value) {
    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length == 8) {
      widget._createPropertyAdViewModel.fetchCepCommand.execute(digits);
    }
  }

  Future<void> _pickImage() async {
    final file = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 90,
    );

    if (file != null) {
      widget._createPropertyAdViewModel.setSelectedImage(file);
    }
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final loc = AppLocalizations.of(context)!;
    final priceText = _priceController.text.trim();
    final priceRaw = priceText.replaceAll('.', '');
    final price = double.tryParse(priceRaw);
    if (price == null || price <= 0) {
      _customToast.showToast(
        context,
        message: loc.createAdInvalidPrice,
        toastType: 'warning',
      );
      return;
    }

    final vm = widget._createPropertyAdViewModel;
    Uint8List? imageBytes;
    String? imageName;
    if (vm.selectedImage != null) {
      imageBytes = await vm.selectedImage!.readAsBytes();
      imageName = vm.selectedImage!.name;
    }

    final input = PropertyAdInput(
      type: vm.adType,
      priceBrl: priceRaw,
      zipCode: _zipController.text.replaceAll(RegExp(r'\D'), ''),
      street: _streetController.text.trim(),
      number: _numberController.text.trim(),
      neighborhood: _neighborhoodController.text.trim(),
      city: _cityController.text.trim(),
      state: _stateController.text.trim(),
      complement: _complementController.text.trim().isEmpty
          ? null
          : _complementController.text.trim(),
      imageBytes: imageBytes,
      imageName: imageName,
    );

    await vm.createAdCommand.execute(input);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      body: ListenableBuilder(
        listenable: Listenable.merge([
          widget._createPropertyAdViewModel,
          widget._createPropertyAdViewModel.fetchCepCommand,
          widget._createPropertyAdViewModel.createAdCommand,
        ]),
        builder: (context, _) {
          final vm = widget._createPropertyAdViewModel;
          final isSubmitting = vm.createAdCommand.running;
          final isFetchingCep = vm.fetchCepCommand.running;

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              CustomSliverAppBar(
                title: loc.createAdTitle,
                showDrawerButton: false,
                showBackButton: true,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SectionHeader(title: loc.createAdSectionDetails),
                        const SizedBox(height: 8),

                        _TypeLabel(label: loc.createAdType),
                        const SizedBox(height: 8),

                        Row(
                          children: [
                            Expanded(
                              child: _TypeChip(
                                label: loc.createAdSale,
                                icon: Icons.sell_rounded,
                                selected: vm.adType == 'SALE',
                                onTap: () => vm.setAdType('SALE'),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _TypeChip(
                                label: loc.createAdRent,
                                icon: Icons.home_rounded,
                                selected: vm.adType == 'RENT',
                                onTap: () => vm.setAdType('RENT'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),

                        CustomTextFormField(
                          controller: _priceController,
                          hintText: loc.createAdPrice,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            _ThousandsSeparatorFormatter(),
                            LengthLimitingTextInputFormatter(15),
                          ],
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (v) => _validators.requiredFieldValidator(
                            v,
                            loc.requiredField,
                          ),
                        ),

                        const SizedBox(height: 12),
                        _SectionHeader(title: loc.createAdSectionAddress),
                        const SizedBox(height: 8),

                        CustomTextFormField(
                          controller: _zipController,
                          hintText: loc.createAdZipCode,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CepInputFormatter(),
                          ],
                          suffixIcon: isFetchingCep
                              ? Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: cs.primary,
                                    ),
                                  ),
                                )
                              : null,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: _onZipChanged,
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return loc.requiredField;
                            }
                            final digits = v.replaceAll(RegExp(r'\D'), '');
                            if (digits.length != 8) {
                              return loc.createAdInvalidZip;
                            }
                            return null;
                          },
                        ),

                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: CustomTextFormField(
                                controller: _streetController,
                                hintText: loc.createAdStreet,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (v) =>
                                    _validators.requiredFieldValidator(
                                      v,
                                      loc.requiredField,
                                    ),
                              ),
                            ),
                            Expanded(
                              child: CustomTextFormField(
                                controller: _numberController,
                                hintText: loc.createAdNumber,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (v) =>
                                    _validators.requiredFieldValidator(
                                      v,
                                      loc.requiredField,
                                    ),
                              ),
                            ),
                          ],
                        ),

                        CustomTextFormField(
                          controller: _neighborhoodController,
                          hintText: loc.createAdNeighborhood,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (v) => _validators.requiredFieldValidator(
                            v,
                            loc.requiredField,
                          ),
                        ),

                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: CustomTextFormField(
                                controller: _cityController,
                                hintText: loc.createAdCity,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (v) =>
                                    _validators.requiredFieldValidator(
                                      v,
                                      loc.requiredField,
                                    ),
                              ),
                            ),
                            Expanded(
                              child: CustomTextFormField(
                                controller: _stateController,
                                hintText: loc.createAdState,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(2),
                                  _UpperCaseTextFormatter(),
                                ],
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (v) =>
                                    _validators.requiredFieldValidator(
                                      v,
                                      loc.requiredField,
                                    ),
                              ),
                            ),
                          ],
                        ),

                        CustomTextFormField(
                          controller: _complementController,
                          hintText: loc.createAdComplementHint,
                        ),

                        const SizedBox(height: 16),

                        _SectionHeader(title: loc.createAdSectionImage),
                        const SizedBox(height: 8),

                        _ImagePickerCard(
                          selectedImage: vm.selectedImage,
                          onTap: _pickImage,
                          onTapRemoveImage: widget
                              ._createPropertyAdViewModel
                              .resetSelectedImage,
                          addLabel: loc.createAdAddImage,
                          changeLabel: loc.createAdChangeImage,
                          hintLabel: loc.createAdImageHint,
                        ),

                        const SizedBox(height: 24),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: PrimaryButton(
                            text: loc.createAdSubmit,
                            disable: isSubmitting,
                            isLoading: isSubmitting,
                            onPressed: _submit,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Text(
        title,
        style: AppTextStyles.textBold16.copyWith(color: cs.inversePrimary),
      ),
    );
  }
}

class _TypeLabel extends StatelessWidget {
  final String label;

  const _TypeLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Text(
        label,
        style: AppTextStyles.text14.copyWith(
          color: cs.inversePrimary.withValues(alpha: 0.7),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _TypeChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _TypeChip({
    required this.label,
    required this.icon,
    required this.selected,
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
        height: 52,
        decoration: BoxDecoration(
          color: selected ? cs.inversePrimary : cs.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: selected ? cs.secondary : cs.inversePrimary,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: selected ? cs.secondary : cs.inversePrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImagePickerCard extends StatelessWidget {
  final XFile? selectedImage;
  final VoidCallback onTap;
  final String addLabel;
  final String changeLabel;
  final String hintLabel;
  final VoidCallback onTapRemoveImage;

  const _ImagePickerCard({
    required this.selectedImage,
    required this.onTap,
    required this.addLabel,
    required this.changeLabel,
    required this.hintLabel,
    required this.onTapRemoveImage,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 240,
        decoration: BoxDecoration(
          color: cs.secondary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: cs.primary.withValues(alpha: 0.15)),
        ),
        clipBehavior: Clip.antiAlias,
        child: selectedImage != null
            ? _ImagePreview(
                imageFile: selectedImage!,
                changeLabel: changeLabel,
                onTapRemoveImage: onTapRemoveImage,
              )
            : _ImagePlaceholder(addLabel: addLabel, hintLabel: hintLabel),
      ),
    );
  }
}

class _ImagePreview extends StatefulWidget {
  final XFile imageFile;
  final VoidCallback? onTapRemoveImage;
  final String changeLabel;

  const _ImagePreview({
    required this.imageFile,
    required this.changeLabel,
    this.onTapRemoveImage,
  });

  @override
  State<_ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<_ImagePreview> {
  late Future<Uint8List> _bytesFuture;

  @override
  void initState() {
    super.initState();
    _bytesFuture = widget.imageFile.readAsBytes();
  }

  @override
  void didUpdateWidget(covariant _ImagePreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imageFile.path != widget.imageFile.path) {
      _bytesFuture = widget.imageFile.readAsBytes();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Stack(
      fit: StackFit.expand,
      children: [
        FutureBuilder<Uint8List>(
          future: _bytesFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Image.memory(snapshot.data!, fit: BoxFit.cover);
            }
            return Center(child: CircularProgressIndicator(color: cs.primary));
          },
        ),
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: widget.onTapRemoveImage,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.45),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.delete_outline_rounded,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: cs.surface.withValues(alpha: 0.7),
            child: Text(
              widget.changeLabel,
              textAlign: TextAlign.center,
              style: AppTextStyles.text14.copyWith(
                color: cs.inversePrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  final String addLabel;
  final String hintLabel;

  const _ImagePlaceholder({required this.addLabel, required this.hintLabel});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.add_photo_alternate_outlined,
          size: 40,
          color: cs.primary.withValues(alpha: 0.4),
        ),
        const SizedBox(height: 8),
        Text(
          addLabel,
          style: AppTextStyles.text14.copyWith(
            color: cs.inversePrimary.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          hintLabel,
          style: AppTextStyles.text14.copyWith(
            color: cs.primary.withValues(alpha: 0.35),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(text: newValue.text.toUpperCase());
  }
}

class _ThousandsSeparatorFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    if (digits.isEmpty) return newValue.copyWith(text: '');
    final formatted = _format(digits);
    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  String _format(String digits) {
    final buffer = StringBuffer();
    final n = digits.length;
    for (int i = 0; i < n; i++) {
      if (i > 0 && (n - i) % 3 == 0) buffer.write('.');
      buffer.write(digits[i]);
    }
    return buffer.toString();
  }
}
