import 'package:flutter/material.dart';
import '../main.dart';
import '../theme/app_theme.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  final String userEmail;
  const HomePage({super.key, required this.userEmail});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Map<String, dynamic>> _items = List.generate(
    8,
    (i) => {
      'title': 'Élément ${i + 1}',
      'subtitle': 'Description de l\'élément ${i + 1}',
      'icon': [
        Icons.star_outline,
        Icons.favorite_outline,
        Icons.bookmark_outline,
        Icons.notifications_outlined,
        Icons.cloud_outlined,
        Icons.photo_outlined,
        Icons.music_note_outlined,
        Icons.videocam_outlined,
      ][i % 8],
    },
  );

  void _logout() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Déconnexion'),
        content: const Text('Voulez-vous vraiment vous déconnecter ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade400,
                foregroundColor: Colors.white),
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pushAndRemoveUntil(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 400),
                  pageBuilder: (_, __, ___) => const LoginPage(),
                  transitionsBuilder: (_, anim, __, child) =>
                      FadeTransition(opacity: anim, child: child),
                ),
                (r) => false,
              );
            },
            child: const Text('Déconnexion'),
          ),
        ],
      ),
    );
  }

  String get _initials {
    final parts = widget.userEmail.split('@');
    return parts[0].isNotEmpty ? parts[0][0].toUpperCase() : '?';
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      // ── AppBar ──────────────────────────────────────────────────────────
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppTheme.primaryDark, AppTheme.accent],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        title: const Text('Accueil'),
        actions: [
          // Theme toggle
          IconButton(
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
          ),
          const SizedBox(width: 4),
        ],
      ),

      // ── Drawer ──────────────────────────────────────────────────────────
      drawer: Drawer(
        backgroundColor: isDark ? const Color(0xFF1E1E2E) : Colors.white,
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.primaryDark, AppTheme.accent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: Colors.white.withAlpha(40),
                    child: Text(
                      _initials,
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text('Utilisateur',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text(widget.userEmail,
                      style: TextStyle(
                          color: Colors.white.withAlpha(200), fontSize: 13)),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Menu items
            _drawerItem(
              context,
              icon: Icons.home_rounded,
              label: 'Accueil',
              index: 0,
            ),
            _drawerItem(
              context,
              icon: Icons.explore_outlined,
              label: 'Explorer',
              index: 1,
            ),
            _drawerItem(
              context,
              icon: Icons.bookmark_outline_rounded,
              label: 'Favoris',
              index: 2,
            ),
            _drawerItem(
              context,
              icon: Icons.settings_outlined,
              label: 'Paramètres',
              index: 3,
            ),

            const Spacer(),
            const Divider(),

            ListTile(
              leading: const Icon(Icons.logout_rounded, color: Colors.red),
              title: const Text('Déconnexion',
                  style: TextStyle(
                      color: Colors.red, fontWeight: FontWeight.w600)),
              onTap: () {
                Navigator.pop(context);
                _logout();
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),

      // ── Body ────────────────────────────────────────────────────────────
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final item = _items[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1E2E) : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                if (!isDark)
                  BoxShadow(
                    color: Colors.indigo.withAlpha(18),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
              ],
            ),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppTheme.primary, AppTheme.accent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(item['icon'] as IconData,
                    color: Colors.white, size: 22),
              ),
              title: Text(item['title'] as String,
                  style: tt.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w600)),
              subtitle: Text(item['subtitle'] as String,
                  style: tt.bodyMedium),
              trailing: Icon(Icons.chevron_right_rounded,
                  color: cs.primary),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    content: Text('${item['title']} sélectionné'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
            ),
          );
        },
      ),

      // ── FAB ─────────────────────────────────────────────────────────────
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Ajouter',
            style: TextStyle(fontWeight: FontWeight.w700)),
        onPressed: () {
          final n = _items.length + 1;
          final icons = [
            Icons.star_outline,
            Icons.favorite_outline,
            Icons.bookmark_outline,
            Icons.notifications_outlined,
          ];
          setState(() => _items.add({
                'title': 'Élément $n',
                'subtitle': 'Description de l\'élément $n',
                'icon': icons[n % icons.length],
              }));
        },
      ),
    );
  }

  Widget _drawerItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required int index,
  }) {
    final selected = _selectedIndex == index;
    final cs = Theme.of(context).colorScheme;
    return ListTile(
      leading: Icon(icon, color: selected ? cs.primary : null),
      title: Text(label,
          style: TextStyle(
              fontWeight:
                  selected ? FontWeight.w700 : FontWeight.normal,
              color: selected ? cs.primary : null)),
      selected: selected,
      selectedTileColor: cs.primary.withAlpha(20),
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onTap: () {
        setState(() => _selectedIndex = index);
        Navigator.pop(context);
      },
    );
  }
}
