import '../entities/usage_record.dart';

/// Repository del tracker costi (SRD §5, §9).
abstract interface class UsageRepository {
  Future<void> record(UsageRecord record);
  Future<List<UsageRecord>> getAll();
  Stream<List<UsageRecord>> watchAll();

  /// Totale stimato del mese corrente (SRD §9).
  Future<double> currentMonthTotalUsd();

  /// Totale complessivo.
  Future<double> allTimeTotalUsd();

  Future<List<UsageRecord>> getForMeeting(String meetingId);
  Future<List<UsageRecord>> getForProject(String projectId);
}
