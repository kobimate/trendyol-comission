import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class SearchResult { final List<Product> products; final String? error; const SearchResult(this.products, [this.error]); }
class TrendyolService {
  static const _base = 'https://apigw.trendyol.com/discovery-sfint-search-service/api/search/products/';
  Future<SearchResult> search(String barcode) async {
    final uri = Uri.parse(_base).replace(queryParameters: {'q': barcode, 'os': '1', 'pathModel': 'sr', 'channelId': '1', 'countryCode': 'TR'});
    final response = await http.get(uri, headers: {'Accept': 'application/json'}).timeout(const Duration(seconds: 15));
    if (response.statusCode < 200 || response.statusCode >= 300) return SearchResult(const [], 'Ürün servisine ulaşılamadı (${response.statusCode}).');
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    if (data['appliedSearchStrategy'] != 'BARCODE') return const SearchResult([], 'Bu barkoda ait ürün bulunamadı.');
    final products = (data['products'] as List? ?? const []).whereType<Map>().map((p) => Product.fromJson(p.cast<String, dynamic>(), barcode)).toList();
    return products.isEmpty ? const SearchResult([], 'Bu barkoda ait ürün bulunamadı.') : SearchResult(products);
  }
}
