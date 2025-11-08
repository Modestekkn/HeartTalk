import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/database_helper.dart';
import '../data/models/category_model.dart';

// ============================================
// CATEGORIES REPOSITORY
// ============================================
class CategoriesRepository {
  final DatabaseHelper _db = DatabaseHelper.instance;

  Future<List<CategoryModel>> getCategories() async {
    final maps = await _db.getCategories();
    return maps.map((map) => CategoryModel.fromMap(map)).toList();
  }
}

// ============================================
// PROVIDERS
// ============================================

// Repository provider
final categoriesRepositoryProvider = Provider<CategoriesRepository>((ref) {
  return CategoriesRepository();
});

// Liste de toutes les catégories
final categoriesProvider = FutureProvider<List<CategoryModel>>((ref) async {
  final repository = ref.read(categoriesRepositoryProvider);
  return await repository.getCategories();
});

// Catégorie sélectionnée
final selectedCategoryProvider = StateProvider<CategoryModel?>((ref) => null);

// ============================================
// HELPER PROVIDERS
// ============================================

// Provider pour obtenir une catégorie par ID
final categoryByIdProvider = Provider.family<CategoryModel?, String>((ref, id) {
  final categoriesAsync = ref.watch(categoriesProvider);

  return categoriesAsync.when(
    data: (categories) => categories.firstWhere(
      (cat) => cat.id == id,
      orElse: () => categories.first,
    ),
    loading: () => null,
    error: (error, stackTrace) => null,
  );
});

// Provider pour savoir si une catégorie est sélectionnée
final hasCategorySelectedProvider = Provider<bool>((ref) {
  return ref.watch(selectedCategoryProvider) != null;
});
