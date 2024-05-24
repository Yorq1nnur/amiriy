import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final List<CustomBottomNavigationBarItem> items;
  final ValueChanged<int> onTap;
  final int currentIndex;

  const CustomBottomNavigationBar({
    required this.items,
    required this.onTap,
    this.currentIndex = 0,
    super.key,
  });

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar>
    with SingleTickerProviderStateMixin {
  late double _indicatorPosition;
  late int _currentIndex;
  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _positionAnimation;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _colorAnimation = ColorTween(
      begin: widget.items[_currentIndex].activeColor,
      end: widget.items[_currentIndex].inactiveColor,
    ).animate(_animationController);

    _positionAnimation = Tween<double>(
      begin: 0,
      end: 0,
    ).animate(_animationController);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Calculate the actual indicator position now that MediaQuery is available
    _indicatorPosition = _calculateIndicatorPosition(_currentIndex);
    _positionAnimation = Tween<double>(
      begin: _indicatorPosition,
      end: _indicatorPosition,
    ).animate(_animationController);
  }

  double _calculateIndicatorPosition(int index) {
    return (index * (MediaQuery.of(context).size.width / widget.items.length));
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      _indicatorPosition = _calculateIndicatorPosition(index);
    });

    _positionAnimation = Tween<double>(
      begin: _positionAnimation.value,
      end: _indicatorPosition,
    ).animate(_animationController);

    _colorAnimation = ColorTween(
      begin: _colorAnimation.value,
      end: widget.items[index].activeColor,
    ).animate(_animationController);

    _animationController.forward(from: 0);

    widget.onTap(index);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: widget.items.map((item) {
              int index = widget.items.indexOf(item);
              return GestureDetector(
                onTap: () => _onItemTapped(index),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      item.icon,
                      color: _currentIndex == index
                          ? item.activeColor
                          : item.inactiveColor,
                    ),
                    Text(
                      item.label,
                      style: TextStyle(
                        color: _currentIndex == index
                            ? item.activeColor
                            : item.inactiveColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Positioned(
                left: _positionAnimation.value +
                    (MediaQuery.of(context).size.width / widget.items.length -
                            24) /
                        2,
                bottom: 0,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: _colorAnimation.value, // Use the animated color
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CustomBottomNavigationBarItem {
  final IconData icon;
  final String label;
  final Color activeColor;
  final Color inactiveColor;

  CustomBottomNavigationBarItem({
    required this.icon,
    required this.label,
    required this.activeColor,
    required this.inactiveColor,
  });
}
