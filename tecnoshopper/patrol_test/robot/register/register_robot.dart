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
    expect($(find.text(mensaje)), findsAtLeastNWidgets(1));
  }

  Future<void> verificarRegistroFallido(String mensaje) async {
    await $(mensaje).waitUntilVisible();
    expect($(find.text(mensaje)), findsAtLeastNWidgets(1));
    expect($(find.text('OK')), findsOneWidget);
  }

  Future<void> presionarOk() async {
    expect($(find.text('OK')), findsOneWidget);
    await $('OK').tap();
    await $.pumpAndSettle();
  }

  Future<void> verificarPantallaLogin() async {
    await $(find.byKey(const ValueKey('login_button'))).waitUntilVisible();
    expect($(find.byKey(const ValueKey('login_button'))), findsOneWidget);
  }
}
