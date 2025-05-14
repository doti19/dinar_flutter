enum InterestUnitTypes {
  month,
  year;

  static InterestUnitTypes parse(String value) {
    for (InterestUnitTypes type in InterestUnitTypes.values) {
      if (type.toString() == value) return type;
    }
    throw Exception(
        "Can't parse InterestUnitTypes! Your input value is \"$value\"");
  }

  // static InterestUnitTypes parseVi(String value) {
  //   for (InterestUnitTypes type in InterestUnitTypes.values) {
  //     if (type.getStringVi() == value) return type;
  //   }
  //   throw Exception(
  //       "Can't parse InterestUnitTypes! Your input value is \"$value\"");
  // }

  @override
  String toString() {
    switch (this) {
      case InterestUnitTypes.month:
        return "month";
      case InterestUnitTypes.year:
        return "year";
    }
  }

  // String getStringVi() {
  //   switch (this) {
  //     case InterestUnitTypes.month:
  //       return "Tháng";
  //     case InterestUnitTypes.year:
  //       return "Năm";
  //   }
  // }
}
