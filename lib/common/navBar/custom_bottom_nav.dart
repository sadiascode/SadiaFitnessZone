import 'package:flutter/material.dart';
import 'bottom_tab_item.dart';

class CustomBottomNav extends StatelessWidget {
  final List<BottomTabItem> tabs;
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.tabs,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    int centerIndex = tabs.indexWhere((e) => e.isCenter);
    if (centerIndex == -1) centerIndex = tabs.length ~/ 2;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 16, top: 12),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E24), // Dark theme background
            borderRadius: BorderRadius.circular(35), // Rounded pill shaped navbar
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 20,
                spreadRadius: 2,
                offset: const Offset(0, 10), // Soft shadow
              ),
              BoxShadow(
                color: Colors.white.withValues(alpha: 0.05),
                blurRadius: 2,
                offset: const Offset(0, -1),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(tabs.length, (i) {
              if (i == centerIndex) {
                return _buildCenterTab(i);
              }
              return _buildTab(i);
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildTab(int index) {
    final isActive = currentIndex == index;

    Widget iconWidget = SizedBox(
      width: 24,
      height: 24,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: tabs[index].icon,
      ),
    );

    if (isActive) {
      iconWidget = ShaderMask(
        shaderCallback: (bounds) => const LinearGradient(
          colors: [Color(0xFF86CC55), Color(0xFF1E6BD1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(bounds),
        blendMode: BlendMode.srcIn,
        child: iconWidget,
      );
    } else {
      iconWidget = ColorFiltered(
        colorFilter: const ColorFilter.mode(Color(0xFFA0A0A0), BlendMode.srcIn),
        child: iconWidget,
      );
    }

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutQuint,
              transform: Matrix4.translationValues(0, isActive ? -2 : 0, 0),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: isActive ? 1.0 : 0.6,
                child: iconWidget,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterTab(int index) {
    final isActive = currentIndex == index;
    
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 75,
        alignment: Alignment.center,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Positioned(
              top: -10,
              child: AnimatedScale(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutBack,
                scale: isActive ? 1.05 : 1.0,
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    // Gradient color #86CC55 #1E6BD1 #3CB189
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF86CC55),
                        Color(0xFF3CB189),
                        Color(0xFF1E6BD1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF3CB189).withValues(alpha: 0.5),
                        blurRadius: 16,
                        spreadRadius: 2,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Center(
                    child: ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                      child: SizedBox(
                        width: 28,
                        height: 28,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: tabs[index].icon,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}