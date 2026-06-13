enum TesterAccessRequestStatus {
  pending('pending'),
  approved('approved'),
  rejected('rejected');

  final String value;

  const TesterAccessRequestStatus(this.value);

  static TesterAccessRequestStatus fromString(String? status) {
    return TesterAccessRequestStatus.values.firstWhere(
      (e) => e.value == status,
      orElse: () => TesterAccessRequestStatus.pending,
    );
  }
}
