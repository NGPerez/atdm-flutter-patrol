import 'package:flutter_ces/main.dart';
import 'package:patrol/patrol.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../robot/cart/cart_robot.dart';
import '../../robot/login/login_robot.dart';

void main() {
  const testEmail = 'test@tecnoshopper.com';
  const testPassword = 'password123';
  const testNombre = 'Juan';
  const testApellido = 'Perez';
  const testDireccion = 'Calle 123';
  const testApartamento = '123';
  const testCiudad = 'Bogota';
  const testCodigoPostal = '123456';
  const testNumeroDeCelular = '1234567890';
  const testTarjeta = '4111 4567 3456 2345';
  const testCodigoSeguridad = '123';
  const testNombreTarjeta = 'Juan Perez';
  const testFechaExpiracion = '1226';

  group('Carrito de compras:', () {

    group('Agregar y finalizar compra:', () {
      patrolTest(
        'crear carrito de compras con productos y finalizar compra',
        tags: ['carrito', 'happy_path', 'high_priority', 'regression'],
        ($) async {
          await $.pumpWidgetAndSettle(const MyApp());

          final login_robot = LoginRobot($);
          await login_robot.ingresarEmail(testEmail);
          await login_robot.ingresarPassword(testPassword);
          await login_robot.presionarBotonLogin();
          await login_robot.verificarInicioDeSesionExitoso();

          final cart_robot = CartRobot($);
          await cart_robot.seleccionarProducto();
          await cart_robot.presionarBotonAgregarAlCarrito();
          await cart_robot.verificarConfirmacionDeProductoAgregado('Producto agregado correctamente');
          await cart_robot.volverAlCatalogo();
          await cart_robot.presionarBotonCarrito();
          await cart_robot.presionarBotonFinalizarCompra();
          await cart_robot.presionarBotonSiguiente();
          await cart_robot.verificarPasoVisible('INFORMACIÓN');
          await cart_robot.ingresarEmail(testEmail);
          await cart_robot.seleccionarDireccionDeEntrega();
          await cart_robot.ingresarNombre(testNombre);
          await cart_robot.ingresarApellido(testApellido);
          await cart_robot.ingresarDireccion(testDireccion);
          await cart_robot.ingresarApartamento(testApartamento);
          await cart_robot.ingresarCiudad(testCiudad);
          await cart_robot.ingresarCodigoPostal(testCodigoPostal);
          await cart_robot.presionarNumeroDeCelular(testNumeroDeCelular);
          await cart_robot.presionarBotonContinuarAlPago();
          await cart_robot.verificarPasoVisible('PAGO');
          await cart_robot.ingresarNumeroTarjeta(testTarjeta);
          await cart_robot.ingresarNombreTarjeta(testNombreTarjeta);
          await cart_robot.ingresarFechaExpiracion(testFechaExpiracion);
          await cart_robot.ingresarCodigoSeguridad(testCodigoSeguridad);
          await cart_robot.presionarBotonComprar();
          await cart_robot.verificarPedidoExitoso('¡Tu pedido ha sido procesado con éxito!');
          await cart_robot.presionarVolverAlInicio();
          await $.pumpAndSettle();
        },
      );
    }); 

    group('Agregar y cancelar carrito:', () {
      patrolTest(
        'crear carrito de compras con productos y cancelarlo',
        tags: ['carrito', 'medium_priority'],
        ($) async {
          await $.pumpWidgetAndSettle(const MyApp());

          final login_robot = LoginRobot($);
          await login_robot.ingresarEmail(testEmail);
          await login_robot.ingresarPassword(testPassword);
          await login_robot.presionarBotonLogin();
          await login_robot.verificarInicioDeSesionExitoso();

          final cart_robot = CartRobot($);
          await cart_robot.seleccionarProducto();
          await cart_robot.presionarBotonAgregarAlCarrito();
          await cart_robot.verificarConfirmacionDeProductoAgregado('Producto agregado correctamente');
          await cart_robot.volverAlCatalogo();
          await cart_robot.presionarBotonCarrito();
          await cart_robot.presionarBotonDeMas();
          await cart_robot.presionarBotonBasura();
          await cart_robot.verificarBotonFinalizarCompraDeshabilitado();
          await $.pumpAndSettle();
        },
      );
    });
  });
}