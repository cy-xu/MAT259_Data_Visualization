float bigger(float a, float b) {
  if (a != a) {
    if (b != b) {
      return 0;
    } else {
      return b;
    }
  } else {
    if (b != b) {
      return a;
    } else {
      if (a > b) {
        return a;
      } else {
        return b;
      }
    }
  }
}