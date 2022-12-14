import 'package:appium_driver/async_io.dart';
import 'package:test/test.dart';

void main() {
  late AppiumWebDriver driver;
//dart appium-test/main_test.dart
  setUpAll(() async {
    driver = await createDriver(
        uri: Uri.parse('http://127.0.0.1:4723/wd/hub/'),
        desired: {
          'platformVersion': '12',
          'deviceName': "Emulator_12",
          'platformName': 'Android',
          'useNewWDA': 'true',
          'appium:appPackage': 'com.example.appiumtest',
          'appium:automationName': 'uiautomator2',
          // 'appium:automationName': 'xcuitest',
         //'appium:app': 'https://github.com/projectxyzio/webinar-20210630-appium-flutter-driver/blob/master/apps/app-release-with-key-no-ext.apk?raw=true',
          'appium:fastReset': true,
          'reduceMotion': true,
        });
    print(driver.status);
  });

  tearDownAll(() async {
    await driver.quit();
  });

  test('connect to server', () async {
    expect(await driver.title, 'Appium/welcome');
  });

  test('connect to existing session', () async {
    var sessionId = driver.id;
    AppiumWebDriver newDriver = await fromExistingSession(sessionId);
    expect(await newDriver.title, 'Appium/welcome');
    expect(newDriver.id, sessionId);
  });

  test('find by appium element', () async {
    final title = 'Appium/welcome';
    try {
      await driver.findElement(AppiumBy.accessibilityId(title));
      throw 'expected Unsupported locator strategy: accessibility id error';
    } on UnknownException catch (e) {
      expect(
          e.message!.contains('Unsupported locator strategy: accessibility id'),
          true);
    }
  });
}