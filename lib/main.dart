import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:jgarden/admin/pages/admin_main_page.dart';
import 'package:jgarden/pages/auth/auth_screen.dart';
import 'package:jgarden/pages/mainPage.dart';
import 'package:jgarden/pages/profile/profile_main.dart';
import 'package:jgarden/providers/user_provider.dart';
import 'package:jgarden/router.dart';
import 'package:jgarden/services/auth_service.dart';
import 'package:jgarden/utils/colors.dart';
import 'package:jgarden/utils/dimensions.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    print('Built from scratch');
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme:
              ColorScheme.fromSwatch().copyWith(primary: AppColors.mainColor),
          // primarySwatch: AppColors.mainColor,
          backgroundColor: Colors.white,
          scaffoldBackgroundColor: Colors.white),
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: MainPage.routeName,
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context).user.type == 'user'
              ? const MainPage()
              : const AdminMainPage()
          : const MainPage(),
    );
  }
}
