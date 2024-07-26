enum LoanReasonTypes {
  business,
  education,
  travel,
  wedding,
  medical,
  shopping,
  houseBuying,
  carBuying,
  other;

  //parse
  static LoanReasonTypes parse(String value) {
    for (LoanReasonTypes type in LoanReasonTypes.values) {
      if (type.toString() == value) return type;
    }
    throw Exception(
        "Can't parse LoanReasonTypes! Your input value is \"$value\"");
  }

  //toString
  @override
  String toString() {
    switch (this) {
      case LoanReasonTypes.business:
        return "business";
      case LoanReasonTypes.education:
        return "education";
      case LoanReasonTypes.travel:
        return "travel";
      case LoanReasonTypes.wedding:
        return "wedding";
      case LoanReasonTypes.medical:
        return "medical";
      case LoanReasonTypes.shopping:
        return "shopping";
      case LoanReasonTypes.houseBuying:
        return "house-buying";
      case LoanReasonTypes.carBuying:
        return "car-buying";
      case LoanReasonTypes.other:
        return "other";
    }
  }

  //getStringVi
  String toStringVi() {
    switch (this) {
      case LoanReasonTypes.business:
        return "business";
      case LoanReasonTypes.education:
        return "education";
      case LoanReasonTypes.travel:
        return "travel";
      case LoanReasonTypes.wedding:
        return "wedding";
      case LoanReasonTypes.medical:
        return "medical";
      case LoanReasonTypes.shopping:
        return "shopping";
      case LoanReasonTypes.houseBuying:
        return "house-buying";
      case LoanReasonTypes.carBuying:
        return "car-buying";
      case LoanReasonTypes.other:
        return "other";
    }
  }

  //toMap
  static Map<LoanReasonTypes, String> toMap() {
    return {
      LoanReasonTypes.business: " business",
      LoanReasonTypes.education: "education ",
      LoanReasonTypes.travel: "travel ",
      LoanReasonTypes.wedding: "wedding ",
      LoanReasonTypes.medical: "medical ",
      LoanReasonTypes.shopping: "shopping ",
      LoanReasonTypes.houseBuying: "houseBuying ",
      LoanReasonTypes.carBuying: "carBuying ",
      LoanReasonTypes.other: "other",
    };
  }
}
