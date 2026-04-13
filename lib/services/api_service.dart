import 'package:dio/dio.dart';
import 'package:week8/core/utils/error_handler.dart';
import 'package:week8/core/utils/results.dart';
import '../core/network/dio_handler.dart';
import '../models/meals.dart';

class ApiService {
  final Dio _dio = DioHandler().dio;

  /// Fetch meals from TheMealDB
  Future<Results<List<Meal>>> getMeals() async {
    try {
      final response = await _dio.get('search.php?s=');

      if (response.statusCode == 200) {
        final data = response.data;

        if (data['meals'] != null) {
          List meals = data['meals'];
          final parsed = meals.map((json) => Meal.fromJson(json)).toList();
          return Success(parsed);
        } else {
          return const Success([]);
        }
      } else {
        return Failure('Failed with status code ${response.statusCode}');
      }
    } on DioException catch (e) {
      return Failure(handleDioError(e)); // 🔥 using your handler
    } catch (e) {
      return const Failure('Unexpected error occurred');
    }
  }
}
