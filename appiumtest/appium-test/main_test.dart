import 'package:appium_driver/async_io.dart';
import 'package:test/test.dart';

void main() {
  late AppiumWebDriver driver;
//dart appium-test/main_test.dart
  setUpAll(() async {
    driver = await createDriver(
        uri: Uri.parse('http://127.0.0.1:4723/wd/hub/'),
        // desired: {
        //   'platformName': 'ios',
        //   'deviceName': 'iPhone 14 Pro Max',
        //   'browserName': 'Google Chrome',
        //   'automationName': 'xcuitest',
        //   'reduceMotion': true,
        // });

        desired: {
          'platformName': 'ios',
          'appium:automationName': 'xcuitest',
          'deviceName': 'iPhone 14 Pro Max',
         // 'appium:app': 'https://github.com/projectxyzio/webinar-20210630-appium-flutter-driver/blob/master/apps/app-release-with-key-no-ext.apk?raw=true',
          'appium:appPackage': 'com.example.appiumtest',
          'appium:fullReset': true,
          'reduceMotion': true,
        });
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