abstract class NavigationService {
  Future<void> navigateTo(String routeName, {dynamic arguments});

  Future<void> replaceTo(String routeName, {dynamic arguments});

  Future<void> removeUntil(String routeName, {dynamic arguments});

  void popUntil(String routeName, {dynamic arguments, bool safety = true});

  Future<void> popAndNavigateTo(String routeName, {dynamic arguments});

  Future<void>? pushNamedAndRemoveUntilSafety(
    String newRouteName,
    String predicateRouteName, {
    Object? arguments,
  });

  void goBack<T extends Object?>([T? result]);
}
