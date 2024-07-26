enum PostTypes {
  inCash,
  inKind;

  //parse string to enum
  static PostTypes parse(String value) {
    for (PostTypes type in PostTypes.values) {
      if (type.toString() == value) return type;
    }
    throw Exception("Can't parse PostTypes! Your input value is \"$value\"");
  }

  static PostTypes parseVi(String value) {
    for (PostTypes type in PostTypes.values) {
      if (type.getStringVi() == value) return type;
    }
    throw Exception("Can't parse PostTypes! Your input value is \"$value\"");
  }

  @override
  String toString() {
    switch (this) {
      case PostTypes.inCash:
        return "inCash";
      case PostTypes.inKind:
        return "inKind";
    }
  }

  // to string vi getStringVi
  String getStringVi() {
    switch (this) {
      case PostTypes.inCash:
        return "Cash";
      case PostTypes.inKind:
        return "Kind";
    }
  }
}
