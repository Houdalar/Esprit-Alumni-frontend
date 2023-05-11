import 'package:esprit_alumni_frontend/presentation/core/login.dart';
import 'package:esprit_alumni_frontend/presentation/routes/app_router.dart';
import 'package:flutter/material.dart';

class WebDashboardApp extends StatelessWidget {
  final _appRouter = AppRouter();

  WebDashboardApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Web dashboard',
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}

class WebDashboardApp1 extends StatelessWidget {
  final _appRouter = AppRouter();

  WebDashboardApp1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) {
          return LoginPageW();
        },
      },
    );
  }
}
