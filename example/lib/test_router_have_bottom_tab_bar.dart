import 'package:base_router/module_router_interface.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

// Các màn hình
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
          body: Center(
              child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () => context.go('/Home/details'),
              child: Text('Go to Details')),
          SizedBox(
            height: 40,
          ),
          Text('Home'),
        ],
      )));
}

class HomeDetailsScreen extends StatelessWidget {
  const HomeDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: Center(child: Text('Home Details')));
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Profile Counter: $_counter'),
            ElevatedButton(
                onPressed: () => context.go('details'),
                child: Text('Go to Details')),
            ElevatedButton(
              onPressed: () => setState(() => _counter++),
              child: Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: Center(child: Text('Settings')));
}

// Widget vỏ (Shell) với Bottom Navigation Bar
class ScaffoldWithNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar(this.navigationShell, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell, // Hiển thị nhánh hiện tại
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(index), // Chuyển nhánh
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

// Cấu hình GoRouter

class RouterHaveBottomTabBar extends IModuleRouter {
  @override
  void init(GetIt service) {
    // TODO: implement init
  }

  @override
  List<RouteBase> router() {
    return [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            ScaffoldWithNavBar(navigationShell),
        branches: [
          // Nhánh Home
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/Home',
                builder: (context, state) => const HomeScreen(),
                routes: [
                  GoRoute(
                    path: 'details',
                    builder: (context, state) => const HomeDetailsScreen(),
                  ),
                ],
              ),
            ],
          ),
          // Nhánh Profile
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
          // Nhánh Settings
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ];
  }

  @override
  String getPrefixPath() {
    return 'testRouterHaveBottomTabBar';
  }
}
