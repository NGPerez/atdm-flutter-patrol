import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

class ProfileRobot {
  final PatrolIntegrationTester $;

  ProfileRobot(this.$);

  Future<void> presionarBotonPerfil() async {
    await $(Icons.account_circle_outlined).waitUntilVisible();
    await $(Icons.account_circle_outlined).tap();
    await $.pumpAndSettle();
  }

  Future<void> verificarPantalla(String titulo) async {
    await $(titulo).waitUntilVisible();
    expect($(find.text(titulo)), findsAtLeastNWidgets(1));
  }

  Future<void> ingresarNombre(String nombre) async {
    await $(find.widgetWithText(TextField, 'Nombre')).enterText(nombre);
    await $.pumpAndSettle();
  }

  Future<void> ingresarApellido(String nombre) async {
    await $(find.widgetWithText(TextField, 'Apellido')).enterText(nombre);
    await $.pumpAndSettle();
  }

  Future<void> ingresarTelefono(String telefono) async {
    await $(find.widgetWithText(TextField, 'Teléfono')).enterText(telefono);
    await $.pumpAndSettle();
  }

  Future<void> ingresarFechaNacimiento(String fechaNacimiento) async {
    await $(find.widgetWithText(TextField, 'Fecha de Nacimiento')).enterText(fechaNacimiento);
    await $.pumpAndSettle();
  }

  Future<void> ingresarDireccion(String direccion) async {
    await $(find.widgetWithText(TextField, 'Dirección')).enterText(direccion);
    await $.pumpAndSettle();
  }

  Future<void> ingresarPais(String pais) async {
    await $(find.widgetWithText(TextField, 'País')).enterText(pais);
    await $.pumpAndSettle();
  }

  Future<void> presionarBotonGuardar() async {
    await $('Guardar').tap();
    await $.pumpAndSettle();
  }

  Future<void> verificarActualizacionExitosa(String mensaje) async {
    await $(mensaje).waitUntilVisible();
    expect($(find.text(mensaje)), findsAtLeastNWidgets(1));
  }

  Future<void> verificarMensajeResultado(String mensaje) async {
    await $(mensaje).waitUntilVisible();
    expect($(find.text(mensaje)), findsAtLeastNWidgets(1));
  }

  Future<void> volver() async {
    await $(Icons.arrow_back).tap();
    await $.pumpAndSettle();
  }
}