class DataVerifier {
  bool validateInputData({required List<Object?> inputs}) {
    late bool verified;
    inputs.forEach((element) {
      if (element != null &&
          element.toString().isNotEmpty &&
          !element.toString().contains(" ")) {
        verified = true;
      } else {
        verified = false;
      }
    });
    return verified;
  }
}
