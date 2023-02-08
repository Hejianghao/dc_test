import 'package:auto_route/auto_route.dart';
import 'package:dc_test/screens/search_screen/search_screen.dart';
import 'package:dc_test/screens/webview_screen/webview_screen.dart';
import 'package:flutter/material.dart';
part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SearchScreen, initial: true),
    AutoRoute(page: WebviewScreen)
  ],
)
// extend the generated private router
class AppRouter extends _$AppRouter {}
