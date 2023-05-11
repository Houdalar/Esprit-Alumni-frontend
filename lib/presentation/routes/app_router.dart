import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:esprit_alumni_frontend/presentation/page/home_fragment/page.dart';
import 'package:esprit_alumni_frontend/presentation/page/dashboard_page/page.dart';
import 'package:esprit_alumni_frontend/presentation/page/main_page/page.dart';
import 'package:esprit_alumni_frontend/presentation/page/user_loyalty_and_rewards_page/download_app.dart';

part 'app_router.gr.dart';

const String renamePageToRoute = 'Page,Route';

@MaterialAutoRouter(
  replaceInRouteName: renamePageToRoute,
  routes: <AutoRoute>[
    CustomRoute(
      initial: true,
      page: MainPage,
      transitionsBuilder: TransitionsBuilders.noTransition,
      children: <AutoRoute>[
        CustomRoute(
          initial: true,
          path: 'dashboard',
          page: DashboardPage,
          durationInMilliseconds: 0,
          reverseDurationInMilliseconds: 1,
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
        CustomRoute(
          path: 'home-page',
          page: HomePage,
          durationInMilliseconds: 0,
          reverseDurationInMilliseconds: 1,
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
        CustomRoute(
          path: 'download-page',
          page: DownloadApp,
          durationInMilliseconds: 0,
          reverseDurationInMilliseconds: 1,
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
      ],
    ),
  ],
)
class AppRouter extends _$AppRouter {}
