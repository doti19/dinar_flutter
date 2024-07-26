extension BoolX on bool {
  String getStringVi() {
    if (this) {
      return "Have";
    }
    return "Are Not";
  }
}
