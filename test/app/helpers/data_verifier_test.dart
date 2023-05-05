import 'package:cash_helper_app/app/helpers/data_verifier.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final dataverified = DataVerifier();
  String input = "";
  String? input1;
  String? input2;
  String input3 = "OK";
  test('ValidateInputData should return false for invalid inputs', () async {
    final result = dataverified.validateInputData(inputs: [input, input1,input2]);
    expect(result, equals(false));
  });
  test('ValidateInputData should return true for valid inputs', () async {
    final result = dataverified.validateInputData(inputs: [input3]);
    expect(result, equals(true));
  });
}
