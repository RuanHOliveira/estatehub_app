import 'package:flutter/material.dart';

class CredentialsModel extends ChangeNotifier {
  String name;
  String email;
  String confirmEmail;
  String password;
  String registerPassword;
  String confirmPassword;

  CredentialsModel({
    this.name = '',
    this.email = '',
    this.confirmEmail = '',
    this.password = '',
    this.registerPassword = '',
    this.confirmPassword = '',
  });

  void setName(String name) {
    this.name = name;
    notifyListeners();
  }

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void setConfirmEmail(String confirmEmail) {
    this.confirmEmail = confirmEmail;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  void setRegisterPassword(String registerPassword) {
    this.registerPassword = registerPassword;
    notifyListeners();
  }

  void setConfirmPassword(String confirmPassword) {
    this.confirmPassword = confirmPassword;
    notifyListeners();
  }
}
