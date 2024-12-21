import 'package:flutter/material.dart';

class CustomBottonNavigation extends StatelessWidget {
  const CustomBottonNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(items: const [
      BottomNavigationBarItem(
          icon: Icon(
            Icons.home_outlined,
          ),
          label: "Inicio"),
      BottomNavigationBarItem(
          icon: Icon(Icons.label_outlined), label: "Categorias"),
      BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border_outlined), label: "Favoritos"),
    ]);
  }
}
