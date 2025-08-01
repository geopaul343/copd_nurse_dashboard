import 'dart:convert';

class AppHelper{

  dynamic cleanJsonResponse(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data.map((key, value) {
        if (value is String) {
          // Try to parse string values that might be JSON
          try {
            final decoded = jsonDecode(value);
            // Recursively clean the decoded JSON
            return MapEntry(key, cleanJsonResponse(decoded));
          } catch (_) {
            // Not a JSON string, return as is
            return MapEntry(key, value);
          }
        } else if (value is Map<String, dynamic>) {
          // Recursively clean nested maps
          return MapEntry(key, cleanJsonResponse(value));
        } else if (value is List) {
          // Handle lists by cleaning each item
          return MapEntry(key, value.map((item) => cleanJsonResponse(item)).toList());
        }
        return MapEntry(key, value);
      });
    } else if (data is List) {
      return data.map((item) => cleanJsonResponse(item)).toList();
    } else if (data is String) {
      // Handle cases where the input itself is a JSON string
      try {
        final decoded = jsonDecode(data);
        return cleanJsonResponse(decoded);
      } catch (_) {
        return data;
      }
    }
    return data;
  }
}