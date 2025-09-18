import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home_animation/features/smart_room/screens/favorites.dart';
import 'package:smart_home_animation/features/smart_room/screens/profile.dart';
import 'package:smart_home_animation/features/smart_room/screens/sepet.dart';

class SmHomeBottomNavigationBar extends StatelessWidget {
  const SmHomeBottomNavigationBar({
    super.key,
    required this.roomSelectorNotifier,
  });

  final ValueNotifier<int> roomSelectorNotifier;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ValueListenableBuilder<int>(
        valueListenable: roomSelectorNotifier,
        builder: (_, value, child) => AnimatedOpacity(
          duration: kThemeAnimationDuration,
          opacity: value != -1 ? 0 : 1,
          child: AnimatedContainer(
            duration: kThemeAnimationDuration,
            transform: Matrix4.translationValues(0, value != -1 ? -30.0 : 0.0, 0),
            child: child,
          ),
        ),
        child: BottomNavigationBar(
          onTap: (index) {
            if (index == 0) {
              // profil tab'ın index'i
              Navigator.of(context).push(_animatedRoute(const ProfileScreen()));
            }
            if (index == 1) {
              // profil tab'ın index'i
              Navigator.of(context).push(_animatedRouteCart(const CartScreen()));
            }
            if (index == 2) {
              // profil tab'ın index'i
              Navigator.of(context).push(_animatedRouteFav(FavoritesScreen()));
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.all(8),
                child: Icon(CupertinoIcons.person),
              ),
              label: 'Profil',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.all(8),
                child: Icon(CupertinoIcons.cart),
              ),
              label: 'Sepet',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.all(8),
                child: Icon(CupertinoIcons.heart),
              ),
              label: 'Favoriler',
            ),
          ],
        ),
      ),
    );
  }

  Route<Object?> _animatedRoute(ProfileScreen profileScreen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => ProfileScreen(),
      transitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween<Offset>(begin: const Offset(0.1, 0), end: Offset.zero).animate(curved),
            child: child,
          ),
        );
      },
    );
  }

  Route<Object?> _animatedRouteCart(CartScreen cartScreen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => CartScreen(),
      transitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween<Offset>(begin: const Offset(0.1, 0), end: Offset.zero).animate(curved),
            child: child,
          ),
        );
      },
    );
  }

  Route<Object?> _animatedRouteFav(FavoritesScreen favoritesScreen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => FavoritesScreen(),
      transitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween<Offset>(begin: const Offset(0.1, 0), end: Offset.zero).animate(curved),
            child: child,
          ),
        );
      },
    );
  }
}
