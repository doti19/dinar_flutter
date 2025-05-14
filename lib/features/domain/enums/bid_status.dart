enum BidStatus {
  pending,
  approved,
  rejected;

  static BidStatus parse(String value) {
    for (BidStatus status in BidStatus.values) {
      if (status.toString() == value) return status;
    }
    throw Exception("Can't parse BidStatus! Your input value is \"$value\"");
  }

  @override
  String toString() {
    switch (this) {
      case BidStatus.pending:
        return "pending";
      case BidStatus.approved:
        return "approved";
      case BidStatus.rejected:
        return "rejected";
    }
  }
}
