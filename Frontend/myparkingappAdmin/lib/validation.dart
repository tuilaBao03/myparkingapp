class Validator {
  // Kiểm tra trường dữ liệu không được bỏ trống
  static String? requiredField(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  // Kiểm tra độ dài tối thiểu của chuỗi
  static String? minLength(String? value, int minLength, String fieldName) {
    if (value != null && value.length < minLength) {
      return '$fieldName must be at least $minLength characters';
    }
    return null;
  }

  // Kiểm tra email hợp lệ
  static String? email(String? value) {
    if (value != null && !RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  // Kiểm tra số điện thoại hợp lệ
  static String? phone(String? value) {
    if (value != null && !RegExp(r'^\+?[0-9]{10,13}').hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  // Kiểm tra giá trị phải là số nguyên và trong khoảng cho phép
  static String? integerInRange(String? value, int min, int max, String fieldName) {
    if (value != null && int.tryParse(value) == null) {
      return '$fieldName must be an integer';
    }
    int intValue = int.parse(value!);
    if (intValue < min || intValue > max) {
      return '$fieldName must be between $min and $max';
    }
    return null;
  }

  // Kiểm tra giá trị phải là số thực (double) và trong khoảng cho phép
  static String? doubleInRange(String? value, double min, double max, String fieldName) {
    if (value != null && double.tryParse(value) == null) {
      return '$fieldName must be a valid number';
    }
    double doubleValue = double.parse(value!);
    if (doubleValue < min || doubleValue > max) {
      return '$fieldName must be between $min and $max';
    }
    return null;
  }

  // Kiểm tra giá trị là một số (int hoặc double)
  static String? isNumber(String? value, String fieldName) {
    if (value != null && (int.tryParse(value) == null && double.tryParse(value) == null)) {
      return '$fieldName must be a valid number';
    }
    return null;
  }
}