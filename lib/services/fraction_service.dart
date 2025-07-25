class Fraction {
  int n; // numerator
  int d; // denominator

  Fraction(this.n, this.d) {
    if (d == 0) throw ArgumentError('Denominator cannot be 0');
    _normalize();
    _reduce();
  }

  factory Fraction.fromMixed(int whole, int num, int den) {
    if (den == 0) throw ArgumentError('Denominator cannot be 0');
    final sign = whole < 0 ? -1 : 1;
    final absWhole = whole.abs();
    final totalNum = absWhole * den + num;
    return Fraction(sign * totalNum, den);
  }

  static Fraction parse(String input) {
    final s = input.trim();
    final mixed = RegExp(r'^(-?\d+)\s+(\d+)\s*/\s*(\d+)$');
    final proper = RegExp(r'^(-?\d+)\s*/\s*(\d+)$');
    final whole = RegExp(r'^-?\d+$');

    if (mixed.hasMatch(s)) {
      final m = mixed.firstMatch(s)!;
      final wholePart = int.parse(m.group(1)!);
      final num = int.parse(m.group(2)!);
      final den = int.parse(m.group(3)!);
      return Fraction.fromMixed(wholePart, num, den);
    } else if (proper.hasMatch(s)) {
      final m = proper.firstMatch(s)!;
      final num = int.parse(m.group(1)!);
      final den = int.parse(m.group(2)!);
      return Fraction(num, den);
    } else if (whole.hasMatch(s)) {
      final w = int.parse(s);
      return Fraction(w, 1);
    }
    throw FormatException('Cannot parse fraction: "$input"');
  }

  Fraction operator +(Fraction other) =>
      Fraction(n * other.d + other.n * d, d * other.d);

  Fraction operator -(Fraction other) =>
      Fraction(n * other.d - other.n * d, d * other.d);

  Fraction operator *(Fraction other) => Fraction(n * other.n, d * other.d);

  Fraction operator /(Fraction other) {
    if (other.n == 0) throw ArgumentError('Division by zero');
    return Fraction(n * other.d, d * other.n);
  }

  /// Snap/round to nearest 1/snapDen (default carpenter style = 16)
  Fraction snapToDen(int snapDen) {
    final value = n / d;
    final snappedNum = (value * snapDen).round();
    return Fraction(snappedNum, snapDen);
  }

  String toMixedString() {
    if (n == 0) return "0";
    final sign = n < 0 ? "-" : "";
    final absNum = n.abs();
    if (absNum < d) return "$sign$absNum/$d";
    final whole = absNum ~/ d;
    final rem = absNum % d;
    if (rem == 0) return "$sign$whole";
    return "$sign$whole $rem/$d";
  }

  double toDouble() => n / d;

  void _normalize() {
    if (d < 0) {
      d = -d;
      n = -n;
    }
  }

  void _reduce() {
    final g = _gcd(n.abs(), d);
    n ~/= g;
    d ~/= g;
  }

  static int _gcd(int a, int b) {
    while (b != 0) {
      final t = b;
      b = a % b;
      a = t;
    }
    return a == 0 ? 1 : a;
  }

  @override
  String toString() => "$n/$d";
}
