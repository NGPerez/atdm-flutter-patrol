import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'package:flutter_ces/pages/home_forms/productos_page.dart';

class LoginRobot {
  final PatrolIntegrationTester $;

  LoginRobot(this.$);

  Future<void> ingresarEmail(String email) async {
    await $(const ValueKey('email_field')).enterText(email);
  }

  Future<void> ingresarPassword(String password) async {
    await $(const ValueKey('password_field')).enterText(password);
  }

  Future<void> presionarBotonLogin() async {
    await $(const ValueKey('login_button')).tap();
  }

  Future<void> verificarInicioDeSesionExitoso() async {
    await $(find.byIcon(Icons.shopping_cart_outlined)).waitUntilVisible();

    expect(
      find.byIcon(Icons.shopping_cart_outlined),
      findsAtLeastNWidgets(1),
    );

    expect(
      find.byType(ProductosList),
      findsOneWidget,
    );
  }

  Future<void> verificarMensajeDeError(String mensaje) async {
    await $(mensaje).waitUntilVisible();
    expect($(find.text(mensaje)), findsAtLeastNWidgets(1));
  }
}
