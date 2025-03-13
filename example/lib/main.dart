import 'package:base_router/base_router_app.dart';
import 'package:example/test_router_have_bottom_tab_bar.dart';
import 'package:feature_1/router/first_feature_module_router.dart';
import 'package:feature_2/router/second_feature_module_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BaseRouterApp(
    modules: [
      FirstFeatureModuleRouter(),
      SecondFeatureModuleRouter(),
      RouterHaveBottomTabBar(),
    ],
  ));
}
