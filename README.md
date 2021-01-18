# integration_test
A new Flutter project to try test integration (https://pub.dev/packages/integration_test) on basic project

## File Structure
- We have the driver entrypoint in file `test_driver/app.dart`
- We have the test in file `integration_test/counter_test.dart`

## Run test
To launch test on local device:
```bash
flutter drive \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/foo_test.dart
```

## Android Testing

Add file

```java
package com.example.myapp;

import androidx.test.rule.ActivityTestRule;
import dev.flutter.plugins.integration_test.FlutterTestRunner;
import org.junit.Rule;
import org.junit.runner.RunWith;

@RunWith(FlutterTestRunner.class)
public class MainActivityTest {
  @Rule
  public ActivityTestRule<MainActivity> rule = new ActivityTestRule<>(MainActivity.class, true, false);
}
```

Add dependency on *gradle* file
```
android {
  ...
  defaultConfig {
    ...
    testInstrumentationRunner "androidx.test.runner.AndroidJUnitRunner"
  }
}

dependencies {
    testImplementation 'junit:junit:4.12'

    androidTestImplementation 'androidx.test:runner:1.2.0'
    androidTestImplementation 'androidx.test.espresso:espresso-core:3.2.0'
}
```

## Firebase Test Lab:
Generate apk for Firebase Test Lab 
```bash
pushd android
flutter build apk
./gradlew app:assembleAndroidTest
./gradlew app:assembleDebug -Ptarget=`pwd`/../integration_test/counter_test.dart
popd
```

launch test on Firebase with bash command
```bash
gcloud firebase test android run --type instrumentation \
  --app build/app/outputs/apk/debug/app-debug.apk \
  --test build/app/outputs/apk/androidTest/debug/app-debug-androidTest.apk\
  --timeout 2m
```