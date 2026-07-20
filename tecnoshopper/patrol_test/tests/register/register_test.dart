import 'package:flutter_ces/main.dart';
import 'package:patrol/patrol.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../robot/register/register_robot.dart';

void main() {
  final testEmail = 'test_${DateTime.now().millisecondsSinceEpoch}@gmail.com';
  const testPassword = '12345Test';

  group('Registro:', () {
    
    group('Registro exitoso:', () {
      patrolTest(
        'registro exitoso con credenciales validas',
        tags: ['register','happy_path', 'high_priority'],
        ($) async {
          await $.pumpWidgetAndSettle(const MyApp());

          final robot = RegisterRobot($);
          await robot.navegarARegistro();
          await robot.ingresarEmail(testEmail);
          await robot.ingresarPassword(testPassword);
          await robot.presionarBotonRegistro();
          await robot.verificarRegistroExitoso(
            '¡Tu cuenta ha sido registrada correctamente!');
          await robot.presionarOk();
          await $.pumpAndSettle();
        },
      );
    });

    group('Registro fallido:', () {
      patrolTest(
        'registro fallido con credenciales invalidas',
        tags: ['register','medium_priority'],
        ($) async {
          await $.pumpWidgetAndSettle(const MyApp());

          final robot = RegisterRobot($);

          // 1. registrar correo nuevo
          final duplicadoEmail = 'duplicado_${DateTime.now().millisecondsSinceEpoch}@gmail.com';
          await robot.navegarARegistro();
          await robot.ingresarEmail(duplicadoEmail);
          await robot.ingresarPassword('12345Test');
          await robot.presionarBotonRegistro();
          await robot.verificarRegistroExitoso('¡Tu cuenta ha sido registrada correctamente!');
          await robot.presionarOk();
          await $.pumpAndSettle();
          await robot.verificarPantallaLogin();

          // 2. volver a registrar correo paso 1
          await robot.navegarARegistro();
          await robot.ingresarEmail(duplicadoEmail);
          await robot.ingresarPassword('12345Test');
          await robot.presionarBotonRegistro();
          await robot.verificarRegistroFallido(
            'El correo electrónico ya está registrado.');
        },
      );
    });
  });
}