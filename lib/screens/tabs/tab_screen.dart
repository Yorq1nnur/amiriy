import 'dart:math';
import 'package:amiriy/bloc/auth/auth_bloc.dart';
import 'package:amiriy/bloc/auth/auth_state.dart';
import 'package:amiriy/bloc/form_status/form_status.dart';
import 'package:amiriy/screens/routes.dart';
import 'package:amiriy/screens/tabs/book/books_screen.dart';
import 'package:amiriy/screens/tabs/books/books_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'search/search_screen.dart';
import 'settings/settings_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _controller;
  late Animation<double> _animation;

  late List<Widget> screens;

  @override
  void initState() {
    screens = const [
      BooksScreen(),
      SearchScreen(),
      BookScreen(),
      SettingsScreen(),
    ];
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    // Start the animation when the app enters
    if (_selectedIndex == 0) {
      _controller.forward();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildAnimatedIcon(IconData icon, int index) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        double animationValue = _animation.value;
        return Stack(
          alignment: Alignment.center,
          children: [
            if (_selectedIndex == index)
              ...List.generate(4, (i) {
                double angle = (i * 90.0) * (pi / 180.0);
                return Transform.translate(
                  offset: Offset(
                    animationValue * 20 * cos(angle),
                    animationValue * 20 * sin(angle),
                  ),
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                );
              }),
            Icon(
              icon,
              color: Theme.of(context).iconTheme.color,
              size: Theme.of(context).iconTheme.size,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (p, c) {
          if (c.status == FormStatus.unauthenticated) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RouteNames.loginRoute,
                  (context) => false,
            );
          }
        },
        child: IndexedStack(
          index: _selectedIndex,
          children: screens,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: _buildAnimatedIcon(Icons.home, 0),
            // label: 'home'.tr(),
          ),
          BottomNavigationBarItem(
            icon: _buildAnimatedIcon(Icons.search, 1),
            // label: 'search'.tr(),
          ),
          BottomNavigationBarItem(
            icon: _buildAnimatedIcon(Icons.book, 2),
            // label: 'category'.tr(),
          ),
          BottomNavigationBarItem(
            icon: _buildAnimatedIcon(Icons.settings, 3),
            // label: 'settings'.tr(),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
