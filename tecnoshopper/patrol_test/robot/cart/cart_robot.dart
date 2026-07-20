import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:flutter_ces/pages/home_forms/productos_page.dart';

class CartRobot {
  final PatrolIntegrationTester $;

  CartRobot(this.$);

  Future<void> seleccionarProducto() async {
    await $(find.byKey(const Key('producto_card_1'))).waitUntilVisible();
    await $(find.byKey(const Key('producto_card_1'))).tap();
    await $.pumpAndSettle();
  }

  Future<void> presionarBotonAgregarAlCarrito() async {
    await $('Agregar').tap();
    await $.pumpAndSettle();
  }

  Future<void> verificarConfirmacionDeProductoAgregado(String mensaje) async {
  await $(mensaje).waitUntilVisible();

  expect(
    find.text(mensaje),
    findsAtLeastNWidgets(1),
  );
}

  Future<void> volverAlCatalogo() async {
    await $(find.byIcon(Icons.arrow_back_ios)).tap();
    await $.pumpAndSettle();
  }

  Future<void> presionarBotonCarrito() async {
    await $(find.byIcon(Icons.shopping_cart_outlined)).tap();
    await $.pumpAndSettle();
  }

  Future<void> presionarBotonFinalizarCompra() async {
    await $('Finalizar Compra').tap();
    await $.pumpAndSettle();
  }

  Future<void> verificarBotonFinalizarCompraDeshabilitado() async {
    await $('Finalizar Compra').waitUntilVisible();

    final boton = $.tester.widget<ElevatedButton>(
      find.widgetWithText(ElevatedButton, 'Finalizar Compra'),
    );

    expect(boton.onPressed, isNull);
  }

  Future<void> presionarBotonSiguiente() async {
    await $('Siguiente').tap();
    await $.pumpAndSettle();
  }

  Future<void> verificarPasoVisible(String paso) async {
    await $(paso).waitUntilVisible();
    expect(find.text(paso), findsAtLeastNWidgets(1));
  }

  Future<void> ingresarEmail(String email) async {
    await $(const ValueKey('email')).enterText(email);
  }

  Future<void> seleccionarDireccionDeEntrega() async {
    await $(const ValueKey('pais')).tap();
    await $.pumpAndSettle();
    await $('Uruguay').scrollTo().tap();
    await $.pumpAndSettle();
    await $('Listo').scrollTo().tap();
    await $.pumpAndSettle();
  }

  Future<void> ingresarNombre(String nombre) async {
    await $(const ValueKey('nombre')).scrollTo().enterText(nombre);
  }

  Future<void> ingresarApellido(String apellido) async {
    await $(const ValueKey('apellido')).scrollTo().enterText(apellido);
  }

  Future<void> ingresarDireccion(String direccion) async {
    await $(const ValueKey('direccion')).scrollTo().enterText(direccion);
  }

  Future<void> ingresarApartamento(String apartamento) async {
    await $(const ValueKey('apt')).scrollTo().enterText(apartamento);
  }

  Future<void> ingresarCiudad(String ciudad) async {
    await $(const ValueKey('ciudad')).scrollTo().enterText(ciudad);
  }

  Future<void> ingresarCodigoPostal(String codigoPostal) async {
    await $(const ValueKey('postal')).scrollTo().enterText(codigoPostal);
  }

  Future<void> presionarNumeroDeCelular(String celular) async {
    await $(const ValueKey('celular')).scrollTo().enterText(celular);
  }

  Future<void> presionarBotonContinuarAlPago() async {
    await $('Continuar al pago').scrollTo().tap();
    await $.pumpAndSettle();
  }

  Future<void> ingresarNumeroTarjeta(String tarjeta) async {
    final cleanTarjeta = tarjeta.replaceAll(' ', '');
    if (cleanTarjeta.length >= 2) {
      await $(const ValueKey('ccNumero')).scrollTo().enterText(cleanTarjeta.substring(0, 2));
      await $.pumpAndSettle();
    }
    await $(const ValueKey('ccNumero')).enterText(tarjeta);
    await $.pumpAndSettle();
  }

  Future<void> ingresarNombreTarjeta(String nombreTarjeta) async {
    await $(const ValueKey('ccNombre')).scrollTo().enterText(nombreTarjeta);
    await $.pumpAndSettle();
  }

  Future<void> ingresarFechaExpiracion(String fechaExpiracion) async {
    if (fechaExpiracion.length >= 2) {
      await $(const ValueKey('ccExpFecha')).scrollTo().enterText(fechaExpiracion.substring(0, 2));
      await $.pumpAndSettle();
    }
    await $(const ValueKey('ccExpFecha')).enterText(fechaExpiracion);
    await $.pumpAndSettle();
  }

  Future<void> ingresarCodigoSeguridad(String codigoSeguridad) async {
    if (codigoSeguridad.length >= 2) {
      await $(const ValueKey('ccCodigo')).scrollTo().enterText(codigoSeguridad.substring(0, 2));
      await $.pumpAndSettle();
    }
    await $(const ValueKey('ccCodigo')).enterText(codigoSeguridad);
    await $.pumpAndSettle();
  }

  Future<void> presionarBotonComprar() async {
    await $('Comprar').scrollTo().tap();
    await $.pump(const Duration(seconds: 2));
  }

  Future<void> verificarPedidoExitoso(String mensaje) async {
  await $(mensaje).waitUntilVisible();

  expect(
    find.text(mensaje),
    findsAtLeastNWidgets(1),
  );
}

  Future<void> presionarVolverAlInicio() async {
    await $('Volver al inicio').tap();
  }

  Future<void> presionarBotonDeMas() async {
    await $(Icons.add).tap();
    await $.pumpAndSettle();
  }

  Future<void> presionarBotonBasura() async {
    await $(Icons.delete).tap();
    await $.pumpAndSettle();
  }
}