extension NonNullCheck<T> on List<T> {
  // Method so that we can get an object out of a list based on the hashcode
  T? get(T object) {
    for (var item in this) {
      if (item == object) {
        return item;
      }
    }
    return null;
  }
}
