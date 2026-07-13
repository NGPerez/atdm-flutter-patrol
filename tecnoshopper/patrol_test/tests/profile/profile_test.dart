import 'package:flutter_ces/main.dart';
import 'package:patrol/patrol.dart';

import '../../robot/profile/profile_robot.dart';
import '../../robot/login/login_robot.dart';

void main() {
  const testEmail = 'test@tecnoshopper.com';
  const testPassword = 'password123';
  const testNombre = 'Juan';
  const testTelefono = '099123456';

  patrolTest(
    'configurar y guardar información personal',
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
      await profile_robot.verificarGuardadoExitoso('Perfil actualizado correctamente');
      await profile_robot.volver();
      await $.pumpAndSettle();
    },
  );

  patrolTest(
    'guardar perfil con campos vacíos',
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
      await profile_robot.verificarGuardadoExitoso('Perfil actualizado correctamente');
      await $.pumpAndSettle();
    },
  );
}
