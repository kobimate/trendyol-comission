import 'package:flutter/material.dart';
import 'search_screen.dart';
import 'categories_screen.dart';
import 'history_screen.dart';

class HomeScreen extends StatefulWidget { const HomeScreen({super.key}); @override State<HomeScreen> createState() => _HomeScreenState(); }
class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  final pages = const [SearchScreen(), CategoriesScreen(), HistoryScreen()];
  @override Widget build(BuildContext context) => Scaffold(body: SafeArea(child: pages[index]), bottomNavigationBar: NavigationBar(selectedIndex: index, onDestinationSelected: (i) => setState(() => index = i), destinations: const [NavigationDestination(icon: Icon(Icons.search), label: 'Ürün Arama'), NavigationDestination(icon: Icon(Icons.account_tree_outlined), label: 'Kategoriler'), NavigationDestination(icon: Icon(Icons.history), label: 'Geçmiş')]));
}
