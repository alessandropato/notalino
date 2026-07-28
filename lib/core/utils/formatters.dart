/// Formattatori condivisi (durata, valuta, date).
abstract final class Formatters {
  /// Secondi → "hh:mm" (SRD §8ter.1 "Durata totale").
  static String hhmm(int? totalSeconds) {
    if (totalSeconds == null || totalSeconds <= 0) return '—';
    final int hours = totalSeconds ~/ 3600;
    final int minutes = (totalSeconds % 3600) ~/ 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }

  /// Secondi → "1h 05m" / "12m 30s" per etichette compatte.
  static String humanDuration(int? totalSeconds) {
    if (totalSeconds == null || totalSeconds <= 0) return '—';
    final int h = totalSeconds ~/ 3600;
    final int m = (totalSeconds % 3600) ~/ 60;
    final int s = totalSeconds % 60;
    if (h > 0) return '${h}h ${m.toString().padLeft(2, '0')}m';
    if (m > 0) return '${m}m ${s.toString().padLeft(2, '0')}s';
    return '${s}s';
  }

  /// Byte → "12,3 MB".
  static String bytes(int b) {
    if (b < 1024) return '$b B';
    final double kb = b / 1024;
    if (kb < 1024) return '${kb.toStringAsFixed(0)} KB';
    final double mb = kb / 1024;
    return '${mb.toStringAsFixed(1)} MB';
  }

  /// USD stimato (SRD §9): sempre chiarito come stima nella UI.
  static String usd(double amount) => '\$${amount.toStringAsFixed(amount < 1 ? 4 : 2)}';

  static String date(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

  static String isoDate(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}
