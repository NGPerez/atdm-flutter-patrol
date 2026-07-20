# Configuración de Allure Reports

El proyecto genera reportes visuales con **Allure** a partir de los tests de Patrol ejecutados en Android.

## 1. Instalar Allure CLI

**macOS**

```bash
brew install allure
```

**Windows**

```bash
scoop install allure
```

**Linux**

```bash
sudo apt-add-repository ppa:qameta/allure
sudo apt-get update
sudo apt-get install allure
```

O descarga manual desde: https://github.com/allure-framework/allure2/releases

---

## 2. Ejecutar Tests y Generar Reportes (Automatizado)

**Recomendado:** Usar el script automatizado que ejecuta todo el proceso:

```powershell
.\run_tests_and_report.ps1
```

Este script realiza automáticamente:
1. Limpia directorios anteriores de Allure
2. Ejecuta tests de Patrol
3. Extrae resultados de Allure del dispositivo
4. Genera reporte de Allure
5. Genera informe HTML personalizado con organización por suites

### Ejecución Manual (Paso a Paso)

Si prefieres ejecutar cada paso manualmente:

Los tests ya están configurados para emitir resultados Allure automáticamente gracias a `AllurePatrolJUnitRunner`.

Los resultados se escriben vía **TestStorage** (`allure.results.useTestStorage=true`),
en almacenamiento compartido del dispositivo. Esto los hace **inmunes a la
desinstalación de la app** y al `clearPackageData` del orchestrator, así que ya
**no** hace falta `--no-uninstall`:

```bash
# Con Patrol CLI
patrol test

# Directamente con Gradle
./gradlew :app:connectedDebugAndroidTest
```

---

## 3. Extraer Resultados del Dispositivo

Con TestStorage los archivos quedan en almacenamiento compartido, en:
`/sdcard/googletest/test_outputfiles/allure-results`

Se extraen directamente con `tar` (sin `run-as`, la app ya no importa):

```bash
rm -rf allure-results
mkdir -p allure-results

adb exec-out sh -c 'cd /sdcard/googletest/test_outputfiles && tar cf - allure-results' \
  | tar xf - -C .

  adb pull /sdcard/googletest/test_outputfiles/allure-results ./allure-results
```

> Nota: los resultados **se acumulan** entre ejecuciones. Para una corrida limpia,
> borra el directorio en el dispositivo antes:
>
> ```bash
> adb shell rm -rf /sdcard/googletest/test_outputfiles/allure-results
> ```

---

## 4. Generar y Ver el Reporte

```bash
# Generar reporte HTML estático
allure generate ./allure-results --clean

# Servir en http://localhost:8080
allure serve ./allure-results

# Abrir reporte ya generado
allure open ./allure-report
```

### Generar Informe Personalizado

```bash
# Generar informe HTML organizado por suites y tags
python generate_test_report.py

# Abrir informe
start test_report.html
```

---

## Estructura de Salida

```
allure-results/             # Datos brutos (generados por los tests)
├── *.json                  # Resultado de cada test
├── *.txt                   # Attachments: logs, screenshots
└── environment.properties  # Variables de entorno del dispositivo

allure-report/              # Reporte HTML (generado por allure generate)
├── index.html
└── data/
```

---

## Configuración Android

### Runner personalizado

`android/app/src/androidTest/kotlin/com/example/flutter_ces/AllurePatrolJUnitRunner.kt`

```kotlin
package com.example.flutter_ces

import pl.leancode.patrol.PatrolJUnitRunner

class AllurePatrolJUnitRunner : PatrolJUnitRunner()
```

Extiende `PatrolJUnitRunner` para que Allure intercepte los resultados JUnit y los serialice en su formato.

### `android/app/build.gradle` — secciones relevantes

```groovy
defaultConfig {
    testInstrumentationRunner "com.example.flutter_ces.AllurePatrolJUnitRunner"
    testInstrumentationRunnerArguments clearPackageData: "false"
}

testOptions {
    execution "ANDROIDX_TEST_ORCHESTRATOR"
}

dependencies {
    androidTestImplementation "io.qameta.allure:allure-kotlin-model:2.4.0"
    androidTestImplementation "io.qameta.allure:allure-kotlin-commons:2.4.0"
    androidTestImplementation "io.qameta.allure:allure-kotlin-junit4:2.4.0"
    androidTestImplementation "io.qameta.allure:allure-kotlin-android:2.4.0"
    androidTestUtil "androidx.test:orchestrator:1.5.1"
}
```

---

## Qué Registra Allure Automáticamente

- Screenshots en fallos de test
- Logs de la aplicación durante la ejecución
- Pasos y tiempos de cada operación
- Variables de entorno del dispositivo

---

## Solución de Problemas

### Reporte vacío después de ejecutar tests

Si el reporte de Allure se genera vacío:

1. **Verificar que los resultados se extraen del dispositivo:**
   ```bash
   adb shell ls -la /sdcard/googletest/test_outputfiles/allure-results/
   ```

2. **Usar el script automatizado** que limpia directorios automáticamente:
   ```powershell
   .\run_tests_and_report.ps1
   ```

3. **Limpiar manualmente si hay corrupción:**
   ```powershell
   Remove-Item -Recurse -Force allure-results,allure-report
   ```

### Resultados no se generan en el dispositivo

- Verificar que el dispositivo/emulador esté conectado: `adb devices`
- Asegurarse que los tests se ejecutan completamente
- Revisar que `AllurePatrolJUnitRunner` esté correctamente configurado

### Acumulación de resultados entre ejecuciones

Los resultados de Allure se acumulan en el dispositivo. Para una corrida limpia:

```bash
# Borrar resultados del dispositivo antes de ejecutar tests
adb shell rm -rf /sdcard/googletest/test_outputfiles/allure-results
```
