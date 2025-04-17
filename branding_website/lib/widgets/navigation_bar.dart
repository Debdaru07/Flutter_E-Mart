import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/navigation_provider.dart';
import 'button.dart';
import 'fontStyles.dart';

class NavigationBarWidget extends StatefulWidget implements PreferredSizeWidget {
  const NavigationBarWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);

  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  final Map<String, bool> _hoverStates = {
    '/features': false,
    '/how-it-works': false,
    '/pricing': false,
    '/faq': false,
  };

  @override
  Widget build(BuildContext context) {
    final navigationState = Provider.of<NavigationState>(context, listen: false);
    final currentScreen = navigationState.selectedScreen;

    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            const SizedBox(width: 15),
            InkWell(
              onTap: () {
                navigationState.setSelectedScreen('/home');
              },
              child: AppTextStyles.newsForgeHeader('NewsForge')),
            const Spacer(),
            ..._buildNavItems(context, navigationState),
            const Spacer(),
            const SizedBox(width: 10),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => log('shift'),
                child: const Text('Log in'),
              ),
            ),
            const SizedBox(width: 10),
            CustomButton(label: 'Join Waitlist', key: widget.key),
            const SizedBox(width: 10),
          ],
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: currentScreen == '/home' ? 1 : 0,
          child: Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey[300], // Bluish theme color
          ),
        ),
      ],
    );
  }

  List<Widget> _buildNavItems(BuildContext context, NavigationState navigationState) {
    final items = [
      {'label': 'Features', 'route': '/features'},
      {'label': 'How It Works', 'route': '/how-it-works'},
      {'label': 'Pricing', 'route': '/pricing'},
      {'label': 'FAQ', 'route': '/faq'},
    ];

    return items.map((item) {
      final label = item['label'] as String;
      final route = item['route'] as String;
      final isSelected = navigationState.selectedScreen == route;
      final isHovering = _hoverStates[route] ?? false;

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: isSelected ? 0 : 8), // Even spacing between items
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: isSelected || isHovering ? 1.0 : 0.6,
          child: MouseRegion(
            onEnter: (_) => setState(() => _hoverStates[route] = true),
            onExit: (_) => setState(() => _hoverStates[route] = false),
            child: InkWell(
              onTap: () {
                navigationState.setSelectedScreen(route);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  color: isHovering ? Colors.blue[900] : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        color: isHovering ? Colors.white : Colors.black,
                      ),
                    ),
                    if (isSelected)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      height: 2,
                      width: 80,
                      color: Colors.blue[900],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }).toList();
  }
}