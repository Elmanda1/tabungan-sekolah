import 'package:flutter/material.dart';

class NavBarItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isActive;
  final Color activeColor;
  final Color inactiveColor;
  final Color backgroundColor;

  const NavBarItem({
    Key? key,
    required this.label,
    required this.icon,
    required this.isActive,
    required this.activeColor,
    required this.inactiveColor,
    required this.backgroundColor,
  }) : super(key: key);

  BottomNavigationBarItem toBottomNavBarItem() {
    return BottomNavigationBarItem(
      icon: _AnimatedNavIcon(
        icon: icon,
        isActive: isActive,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        backgroundColor: backgroundColor,
      ),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _AnimatedNavIcon(
      icon: icon,
      isActive: isActive,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      backgroundColor: backgroundColor,
    );
  }
}

class _AnimatedNavIcon extends StatefulWidget {
  final IconData icon;
  final bool isActive;
  final Color activeColor;
  final Color inactiveColor;
  final Color backgroundColor;

  const _AnimatedNavIcon({
    Key? key,
    required this.icon,
    required this.isActive,
    required this.activeColor,
    required this.inactiveColor,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  State<_AnimatedNavIcon> createState() => _AnimatedNavIconState();
}

class _AnimatedNavIconState extends State<_AnimatedNavIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _sizeAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _colorAnimation = ColorTween(
      begin: widget.inactiveColor,
      end: widget.activeColor,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    if (widget.isActive) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(_AnimatedNavIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive != oldWidget.isActive) {
      if (widget.isActive) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: widget.isActive
                ? widget.backgroundColor.withOpacity(0.2)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Icon(
            widget.icon,
            size: 24.0 * _sizeAnimation.value,
            color: _colorAnimation.value,
          ),
        );
      },
    );
  }
}
