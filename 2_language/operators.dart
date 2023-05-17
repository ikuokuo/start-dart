// https://dart.dev/language/operators
//  dart 2_language/operators.dart

void main(List<String> args) {
  // Arithmetic operators
  {
    assert(5 / 2 == 2.5); // Result is a double
    assert(5 ~/ 2 == 2); // Result is an int
    assert(5 % 2 == 1); // Remainder

    assert('5/2 = ${5 ~/ 2} r ${5 % 2}' == '5/2 = 2 r 1');
  }
  // Equality and relational operators
  {
    // Here’s how the == operator works:
    // 1. If x or y is null, return true if both are null, and false if only one is null.
    // 2. Return the result of invoking the == method on x with the argument y.

    var o = new Object();
    // Check whether two object references are to the same object.
    assert(identical(o, o));
  }
  // Type test operators
  {}
  // Assignment operators
  {
    int a = 2;
    int? b;
    int value = 5;

    // Assign value to a
    a = value;
    // Assign value to b if b is null; otherwise, b stays the same
    b ??= value;

    assert(a == b);
  }
  // Logical operators
  {}
  // Bitwise and shift operators
  {
    final value = 0x22;
    final bitmask = 0x0f;

    assert((value & bitmask) == 0x02); // AND
    assert((value & ~bitmask) == 0x20); // AND NOT
    assert((value | bitmask) == 0x2f); // OR
    assert((value ^ bitmask) == 0x2d); // XOR
    assert((value << 4) == 0x220); // Shift left
    assert((value >> 4) == 0x02); // Shift right
    assert((value >>> 4) == 0x02); // Unsigned shift right
    assert((-value >> 4) == -0x03); // Shift right
    assert((-value >>> 4) > 0); // Unsigned shift right
  }
  // Conditional expressions
  {
    var isPublic = true;

    // condition ? expr1 : expr2
    var visibility = isPublic ? 'public' : 'private';

    // expr1 ?? expr2
    String playerName(String? name) => name ?? 'Guest';
    // Slightly longer version uses ?: operator.
    // String playerName(String? name) => name != null ? name : 'Guest';
  }
  // Cascade notation
  /*
    var paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;
  */
  /*
    querySelector('#confirm') // Get an object.
      ?..text = 'Confirm' // Use its members.
      ..classes.add('important')
      ..onClick.listen((e) => window.alert('Confirmed!'))
      ..scrollIntoView();
  */
  /*
    final addressBook = (AddressBookBuilder()
          ..name = 'jenny'
          ..email = 'jenny@example.com'
          ..phone = (PhoneNumberBuilder()
                ..number = '415-555-0100'
                ..label = 'home')
              .build())
        .build();
  */
  /*
    var sb = StringBuffer();
    sb.write('foo')
      ..write('bar'); // Error: method 'write' isn't defined for 'void'.
  */
}
