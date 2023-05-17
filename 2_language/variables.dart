// https://dart.dev/language/variables
//  dart 2_language/variables.dart

void main(List<String> args) {
  // Default value
  {
    int? lineCount;
    assert(lineCount == null);
  }

  // Late variables
  {
    late String description;
    Future.delayed(Duration(microseconds: 100), () => description = "hi~")
        .then((value) => print(description));
  }

  // Final and const
  {
    final name = 'Bob'; // Without a type annotation
    final String nickname = 'Bobby';

    const bar = 1000000; // Unit of pressure (dynes/cm2)
    const double atm = 1.01325 * bar; // Standard atmosphere
  }
  {
    // The const keyword isn’t just for declaring constant variables.
    // You can also use it to create constant values, as well as to declare constructors that create constant values.
    var foo = const [];
    final bar = const [];
    const baz = []; // Equivalent to `const []`

    foo = [1, 2, 3]; // Was const []
  }
  {
    const Object i = 3; // Where i is a const Object with an int value...
    const list = [i as int]; // Use a typecast.
    const map = {if (i is int) i: 'int'}; // Use is and collection if.
    const set = {if (list is List<int>) ...list}; // ...and a spread.
  }
}
