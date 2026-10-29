import 'package:flutter/material.dart';
import '../models/category.dart';
import '../services/database_service.dart';

class CategoriesScreen extends StatefulWidget { const CategoriesScreen({super.key}); @override State<CategoriesScreen> createState() => _CategoriesScreenState(); }
class _CategoriesScreenState extends State<CategoriesScreen> {
  final search = TextEditingController(); List<Category> categories = []; Category? selected; List<Category> children = [];
  @override void initState() { super.initState(); load(); }
  Future<void> load() async { categories = await DatabaseService.instance.roots(search.text); if (mounted) setState(() {}); }
  Future<void> choose(Category c) async { final nested = await DatabaseService.instance.children(c.id); setState(() { selected = c; children = nested; }); }
  @override Widget build(BuildContext context) => Padding(padding: const EdgeInsets.fromLTRB(18, 24, 18, 8), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Kategoriler', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)), const SizedBox(height: 18), TextField(controller: search, onChanged: (_) => load(), decoration: const InputDecoration(labelText: 'Kategori ara', prefixIcon: Icon(Icons.search))), const SizedBox(height: 14), Expanded(child: ListView(children: [if (categories.isEmpty) const Padding(padding: EdgeInsets.all(20), child: Text('Kategori bulunamadı.')), ...categories.map((c) => Card(child: ListTile(title: Text(c.name), subtitle: Text('Komisyon: %${c.commission.toStringAsFixed(1)}'), trailing: const Icon(Icons.chevron_right), onTap: () => choose(c)))), if (selected != null) Card(color: Theme.of(context).colorScheme.primaryContainer, child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(selected!.name, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold)), const SizedBox(height: 6), Text('Satış komisyonu: %${selected!.commission.toStringAsFixed(1)}'), if (children.isNotEmpty) ...[const Divider(), const Text('Alt kategoriler', style: TextStyle(fontWeight: FontWeight.bold)), ...children.map((c) => ListTile(contentPadding: EdgeInsets.zero, title: Text(c.name), trailing: Text('%${c.commission.toStringAsFixed(1)}')))] ])))]))]));
}
