import 'dart:developer';

dynamic testMap(
    Map<String, dynamic> documentsData, String key, dynamic replacement) {
  if (documentsData.containsKey(key)) {
    dynamic value = documentsData[key];
    if (value != null) {
      if (value.runtimeType == replacement.runtimeType) {
        return value;
      } else {
        log('''
╔══════════════════════════════════════════════════════════════════════════════════════════
║   Key Error:
║   Key: $key - Expected Type: ${replacement.runtimeType} - Received Type: ${value.runtimeType} - Value: $value
╚══════════════════════════════════════════════════════════════════════════════════════════
''');
        return replacement;
      }
    } else {
      return replacement;
    }
  } else {
    return replacement;
  }
}
