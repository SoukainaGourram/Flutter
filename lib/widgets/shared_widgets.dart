import 'package:flutter/material.dart';
import '../main.dart';
import '../theme/app_theme.dart';

/// Reusable gradient background that adapts to light / dark mode.
class GradientBackground extends StatelessWidget {
  final Widget child;
  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? const [Color(0xFF12121F), Color(0xFF1E1E35), Color(0xFF12121F)]
              : const [Color(0xFF5C6BC0), Color(0xFF7C4DFF), Color(0xFF3949AB)],
        ),
      ),
      child: child,
    );
  }
}

/// Theme toggle icon button for AppBar.
class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return IconButton(
      tooltip: isDark ? 'Mode clair' : 'Mode sombre',
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Icon(
          isDark ? Icons.wb_sunny_rounded : Icons.nightlight_round,
          key: ValueKey(isDark),
          color: Colors.white,
        ),
      ),
      onPressed: () => AuthApp.of(context).toggleTheme(),
    );
  }
}

/// Logo widget used on all auth pages.
class AppLogo extends StatelessWidget {
  final double size;
  const AppLogo({super.key, this.size = 100});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * 0.25),
        boxShadow: [
          BoxShadow(
            color: AppTheme.accent.withAlpha(120),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size * 0.25),
        child: Image.asset(
          'assets/images/logo.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

/// Divider with "ou" text in the middle.
class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurface.withAlpha(60);
    return Row(children: [
      Expanded(child: Divider(color: color)),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text('ou',
            style: TextStyle(color: color, fontWeight: FontWeight.w600)),
      ),
      Expanded(child: Divider(color: color)),
    ]);
  }
}
