class Category {
  final int id;
  final int? parentId;
  final String name;
  final double commission;
  const Category({required this.id, this.parentId, required this.name, required this.commission});
  factory Category.fromMap(Map<String, Object?> m) => Category(id: m['id'] as int, parentId: m['parent_id'] as int?, name: m['name'] as String, commission: (m['commission'] as num).toDouble());
}
