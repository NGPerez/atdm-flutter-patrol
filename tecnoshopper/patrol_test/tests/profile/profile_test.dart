import 'package:flutter_ces/main.dart';
import 'package:patrol/patrol.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../robot/profile/profile_robot.dart';
import '../../robot/login/login_robot.dart';

void main() {
  const testEmail = 'test@tecnoshopper.com';
  const testPassword = 'password123';
  const testNombre = 'Juan';
  const testTelefono = '099123456';

  group('Perfil de usuario:', () {

    group('Actualizar datos personales:', () {
      patrolTest(
        'configurar y guardar información personal',
        tags: ['profile','medium_priority', 'regression'],
        ($) async {
          await $.pumpWidgetAndSettle(const MyApp());

          final login_robot = LoginRobot($);
          await login_robot.ingresarEmail(testEmail);
          await login_robot.ingresarPassword(testPassword);
          await login_robot.presionarBotonLogin();
          await login_robot.verificarInicioDeSesionExitoso();

          final profile_robot = ProfileRobot($);
          await profile_robot.presionarBotonPerfil();
          await profile_robot.verificarPantalla('Datos de Cuenta');
          await profile_robot.ingresarNombre(testNombre);
          await profile_robot.ingresarTelefono(testTelefono);
          await profile_robot.presionarBotonGuardar();
          await profile_robot.verificarActualizacionExitosa('Perfil actualizado correctamente');
          await profile_robot.volver();
          await $.pumpAndSettle();
        },
      );
    });

    group('Validaciones de campos:', () {
      patrolTest(
        'guardar perfil con campos vacíos',
        tags: ['profile','low_priority'],
        ($) async {
          await $.pumpWidgetAndSettle(const MyApp());

          final login_robot = LoginRobot($);
          await login_robot.ingresarEmail(testEmail);
          await login_robot.ingresarPassword(testPassword);
          await login_robot.presionarBotonLogin();
          await login_robot.verificarInicioDeSesionExitoso();

          final profile_robot = ProfileRobot($);
          await profile_robot.presionarBotonPerfil();
          await profile_robot.verificarPantalla('Datos de Cuenta');
          await profile_robot.ingresarNombre('');
          await profile_robot.ingresarApellido('');
          await profile_robot.ingresarTelefono('');
          await profile_robot.ingresarFechaNacimiento('');
          await profile_robot.ingresarDireccion('');
          await profile_robot.ingresarPais('');
          await profile_robot.presionarBotonGuardar();
          // no hay validacion por campos vacios
          await profile_robot.verificarMensajeResultado('Perfil actualizado correctamente');
          await $.pumpAndSettle();
        },
      );
    });
  });
}
