import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:flutter_ces/pages/login_forms/signup_page.dart';

class RegisterRobot {
  final PatrolIntegrationTester $;

  RegisterRobot(this.$);

  Future<void> navegarARegistro() async {
    await $('¿Necesitás registrarte?').tap();
    await $.pumpAndSettle();
  }

  Future<void> ingresarEmail(String email) async {
    await $(SignupPage).$(TextField).at(0).enterText(email);
  }

  Future<void> ingresarPassword(String password) async {
    await $(SignupPage).$(TextField).at(1).enterText(password);
  }

  Future<void> presionarBotonRegistro() async {
    await $(SignupPage).$(ElevatedButton).tap();
  }

  Future<void> verificarRegistroExitoso(String mensaje) async {
    await $(mensaje).waitUntilVisible();
  }

  Future<void> verificarRegistroFallido(String mensaje) async {
    await $(mensaje).waitUntilVisible();
  }

  Future<void> presionarOk() async {
    await $('OK').tap();
  }
}
