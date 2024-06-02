import 'dart:math';
import 'package:amiriy/bloc/auth/auth_bloc.dart';
import 'package:amiriy/bloc/auth/auth_state.dart';
import 'package:amiriy/bloc/form_status/form_status.dart';
import 'package:amiriy/bloc/user/user_bloc.dart';
import 'package:amiriy/screens/routes.dart';
import 'package:amiriy/screens/tabs/audio_books/audio_books_screen.dart';
import 'package:amiriy/screens/tabs/home/home_screen.dart';
import 'package:amiriy/utils/utility_functions/utility_functions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    _init();
    screens = const [
      HomeScreen(),
      AudioBooksScreen(),
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

  _init() {
    Future.microtask(
      () => context.read<UserBloc>().add(
            GetUserEvent(
              userId: FirebaseAuth.instance.currentUser!.uid,
            ),
          ),
    );
    // await Future.delayed(
    //   const Duration(
    //     seconds: 1,
    //   ),
    // );
    // if (mounted) {
    //   UtilityFunctions.methodPrint(
    //     'ON TAB SCREEN USER IS: ${context.read<UserBloc>().state.userModel.username}',
    //   );
    // }
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
              ...List.generate(3, (i) {
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
              color: Theme.of(context).primaryColor,
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
      body: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (p, c) {
              if (c.status == FormStatus.unauthenticated) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouteNames.loginRoute,
                  (context) => false,
                );
              }
            },
          ),
          BlocListener<UserBloc, UserState>(
            listener: (BuildContext context, UserState state) {
              if (state.formStatus == FormStatus.success) {
                UtilityFunctions.methodPrint(
                  'ON TAB SCREEN USER IS: ${context.read<UserBloc>().state.userModel.username}',
                );
              }
            },
          ),
        ],
        child: IndexedStack(
          index: _selectedIndex,
          children: screens,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        showSelectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: _buildAnimatedIcon(Icons.home, 0),
            label: 'home'.tr(),
            tooltip: 'home'.tr(),
          ),
          // BottomNavigationBarItem(
          //   icon: _buildAnimatedIcon(Icons.book, 1),
          //   label: 'category'.tr(),
          //   tooltip: 'category'.tr(),
          // ),
          BottomNavigationBarItem(
            icon: _buildAnimatedIcon(Icons.audio_file, 1),
            label: 'audio_books'.tr(),
            tooltip: 'audio_books'.tr(),
          ),
          BottomNavigationBarItem(
            icon: _buildAnimatedIcon(Icons.settings, 2),
            label: 'settings'.tr(),
            tooltip: 'settings'.tr(),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
