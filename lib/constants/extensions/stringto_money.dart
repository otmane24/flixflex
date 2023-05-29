extension NumberFormatExtension on String {
  String formatCurrency() {
    if (isEmpty) return '';

    final number = double.tryParse(this);
    if (number == null) return '';

    final parts = split('.');
    final wholePart = parts[0];
    final decimalPart = parts.length > 1 ? parts[1] : '00';

    final formattedWholePart = _formatWithCommas(wholePart);

    return '\$$formattedWholePart.$decimalPart';
  }

  String _formatWithCommas(String value) {
    final buffer = StringBuffer();
    final length = value.length;

    for (var i = 0; i < length; i++) {
      if (i != 0 && (length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(value[i]);
    }

    return buffer.toString();
  }
}
