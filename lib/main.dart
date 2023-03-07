import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fs_app/config/environment_config.dart';
import 'package:fs_app/routes/app_pages.dart';
import 'package:fs_app/routes/app_routes.dart';
import 'package:fs_app/theme/app_theme.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'bindings/app_binding.dart';
import 'constant/text_const.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  const env = String.fromEnvironment('env', defaultValue: 'dev');
  EnvironmentConfig.initConfig(env);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: TextConst.app_name,
      darkTheme: darkThemeData(context),
      theme: lightThemeData(context),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      initialBinding: AppBindings(),
      getPages: AppPages.routes,
      initialRoute: AppRoute.splashScreen,
    );
  }
}
