import 'package:flutter_test/flutter_test.dart';
import 'package:week8/core/utils/results.dart';
import 'package:week8/core/utils/validators.dart';

void main() {
  group('Validator Tests', () {
    group('required -', () {
      test('given null value should return error message', () {
        String? input;
        final result = Validator.required(input, 'Email');
        expect(result, 'Email is required');
      });
      test('given empty string should return error message', () {
        const input = '';
        final result = Validator.required(input, 'Email');
        expect(result, 'Email is required');
      });
      test('given whitespace string should return error message', () {
        const input = '     ';
        final result = Validator.required(input, 'Email');
        expect(result, 'Email is required');
      });
      test('given valid input should return null', () {
        const input = 'aayush';
        final result = Validator.required(input, 'Name');
        expect(result, null);
      });
    });

    group('name -', () {
      test('given null or empty name should return error message', () {
        const input = '';
        final result = Validator.name(input);
        expect(result, 'Name is required');
      });
      test('given name shorter than 2 characters should return error message',
          () {
        const input = 'a';
        final result = Validator.name(input);
        expect(result, 'Name must be at least 2 characters');
      });
      test('given name longer than 100 characters should return error message',
          () {
        final input = List.filled(101, 'a').join();
        final result = Validator.name(input);
        expect(result, 'Name must be less than 100 characters');
      });
      test('given name with invalid characters should return error message',
          () {
        const input = '333';
        final result = Validator.name(input);
        expect(result, 'Name can only contain letters and spaces');
      });
      test('given valid name should return null', () {
        const input = 'aayush';
        final result = Validator.name(input);
        expect(result, null);
      });
    });
    group('email -', () {
      test('given null email should return required error', () {
        String? input;
        final result = Validator.email(input);
        expect(result, 'Email is required');
      });
      test('given empty email should return required error', () {
        const input = '';
        final result = Validator.email(input);
        expect(result, 'Email is required');
      });
      test('given email without @ should return invalid format error', () {
        const input = 'abcgmail.com';
        final result = Validator.email(input);
        expect(result, 'Please enter a valid email');
      });
      test('given email with invalid domain should return invalid format error',
          () {
        const input = 'abc@com';
        final result = Validator.email(input);
        expect(result, 'Please enter a valid email');
      });
      test('given valid email should return null', () {
        const input = 'abc@gmail.com';
        final result = Validator.email(input);
        expect(result, null);
      });
    });
    ;
    group('noOfDishes -', () {
      test('given null value should return required error', () {
        const String? input = null;
        final result = Validator.noOfDishes(input);
        expect(result, 'No of dishes is required');
      });
      test('given empty value should return required error', () {
        const input = '';
        final result = Validator.noOfDishes(input);
        expect(result, 'No of dishes is required');
      });
      test('given non numeric input should return invalid number error', () {
        const input = 'abc';
        final result = Validator.noOfDishes(input);
        expect(result, 'Please enter a valid number');
      });
      test('given value less than 1 should return invalid number error', () {
        const input = '0';
        final result = Validator.noOfDishes(input);
        expect(result, 'Please enter a valid number');
      });
      test('given value greater than 20 should return max limit error', () {
        const input = '21';
        final result = Validator.noOfDishes(input);
        expect(result, 'Max guests is 20');
      });
      test('given valid number should return null', () {
        const input = '5';
        final result = Validator.noOfDishes(input);
        expect(result, null);
      });
    });
  });
}
