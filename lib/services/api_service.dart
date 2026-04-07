import 'package:dio/dio.dart';
import '../core/network/dio_handler.dart';
import '../models/meals.dart';

class ApiService {
  final Dio _dio = DioHandler().dio;

  /// Fetch meals from TheMealDB
  Future<List<Meal>> getMeals() async {
    try {
      final response = await _dio.get('search.php?s=');

      if (response.statusCode == 200) {
        final data = response.data;

        if (data['meals'] != null) {
          List meals = data['meals'];

          return meals.map((json) => Meal.fromJson(json)).toList();
        } else {
          return [];
        }
      } else {
        throw Exception('Failed to load meals');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
