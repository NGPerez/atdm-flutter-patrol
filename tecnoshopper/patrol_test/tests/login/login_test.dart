import 'package:flutter_ces/main.dart';
import 'package:patrol/patrol.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../robot/login/login_robot.dart';

void main() {
  const testEmail = 'test@tecnoshopper.com';
  const testPassword = 'password123';

  group('Autenticación:', () {

    group('Inicio de sesión válido:', () {
      patrolTest(
        'login exitoso con credenciales validas',
        tags: ['login','happy_path', 'high_priority', 'regression'],
      ($) async {
        await $.pumpWidgetAndSettle(const MyApp());

        final robot = LoginRobot($);
        await robot.ingresarEmail(testEmail);
        await robot.ingresarPassword(testPassword);
        await robot.presionarBotonLogin();
        await robot.verificarInicioDeSesionExitoso();
      },
    );
    });

    group('Inicio de sesión inválido:', () {
      patrolTest(
        'login fallido con credenciales invalidas',
        tags: ['login','medium_priority', 'regression'],
        ($) async {
        await $.pumpWidgetAndSettle(const MyApp());

          final robot = LoginRobot($);
          await robot.ingresarEmail('incorrecto@test.com');
          await robot.ingresarPassword('claveincorrecta');
          await robot.presionarBotonLogin();
          await robot.verificarMensajeDeError('Error de inicio de sesión');
        },
      );
    });    
  });
}