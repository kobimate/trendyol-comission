import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() { WidgetsFlutterBinding.ensureInitialized(); runApp(const TrendyolApp()); }
class TrendyolApp extends StatelessWidget {
  const TrendyolApp({super.key});
  @override Widget build(BuildContext context) => MaterialApp(title: 'Trendyol Komisyon', debugShowCheckedModeBanner: false, theme: ThemeData(useMaterial3: true, colorSchemeSeed: const Color(0xfff27a1a), scaffoldBackgroundColor: const Color(0xfffafafa), inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder(), filled: true, fillColor: Colors.white)), home: const HomeScreen());
}
