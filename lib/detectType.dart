String detectType(String value) {
  final trimmed = value.trim();

  if (trimmed.contains('@') && trimmed.contains('upi')) return "upi";
  if (trimmed.contains('@') && trimmed.contains('.')) return "email";

  final phoneRegex = RegExp(r'^\+?\d{10,15}$');
  if (phoneRegex.hasMatch(trimmed)) return "number";

  if (trimmed.startsWith('http://') ||
      trimmed.startsWith('https://') ||
      trimmed.contains('.')) {
    return "url";
  }

  return trimmed.isNotEmpty ? "text" : "unknown";
}
