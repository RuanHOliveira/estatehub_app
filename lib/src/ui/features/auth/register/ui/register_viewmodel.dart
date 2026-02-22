import 'package:estatehub_app/src/ui/features/auth/register/data/register_repository.dart';
import 'package:estatehub_app/src/utils/command.dart';
import 'package:estatehub_app/src/utils/result.dart';
import 'package:flutter/material.dart';

class RegisterViewModel extends ChangeNotifier {
  final RegisterRepository _registerRepository;

  RegisterViewModel({required RegisterRepository registerRepository})
    : _registerRepository = registerRepository;

  late final register = Command1<void, Map<String, String>>(
    (params) => _register(params),
  );

  Future<Result<void>> _register(Map<String, String> credentials) async {
    return await _registerRepository.register(
      name: credentials['name']!,
      email: credentials['email']!,
      password: credentials['password']!,
    );
  }
}
