// https://dart.dev/language/patterns
//  dart 2_language/patterns.dart

// Patterns (require sdk >= 3.0.0)

import 'dart:math' show pi, pow;

void main(List<String> args) {
  whatPatternsDo();
  placesPatternsCanAppear();
  usesCasesForPatterns();
}

void whatPatternsDo() {
  print('\n----- whatPatternsDo -----');

  // Matching
  {
    var number = 1;

    switch (number) {
      // Constant pattern matches if 1 == number.
      case 1:
        print('one');
    }
  }
  {
    var obj = [1, 2];
    const a = 1, b = 2;

    switch (obj) {
      // List pattern [a, b] matches obj first if obj is a list with two fields,
      // then if its fields match the constant subpatterns 'a' and 'b'.
      case [a, b]:
        print('$a, $b');
    }
  }

  // Destructuring
  {
    var numList = [1, 2, 3];
    // List pattern [a, b, c] destructures the three elements from numList...
    var [a, b, c] = numList;
    // ...and assigns them to new variables.
    print(a + b + c);
  }
  {
    var list = ['b', 'c'];

    switch (list) {
      case ['a' || 'b', var c]:
        print(c);
    }
  }
}

enum Color { red, yellow, blue }

/*
abstract class Shape {
  num get size;
}

class Square extends Shape {
  num side;

  Square(this.side);

  @override
  num get size => side * side;
}

class Circle extends Shape {
  num radius;

  Circle(this.radius);

  @override
  num get size => pi * pow(radius, 2);
}
*/

void placesPatternsCanAppear() {
  print('\n----- placesPatternsCanAppear -----');

  // Variable declaration
  {
    // Declares new variables a, b, and c.
    var (a, [b, c]) = ('str', [1, 2]);
  }

  // Variable assignment
  {
    var (a, b) = ('left', 'right');
    (b, a) = (a, b); // Swap.
    print('$a $b'); // Prints "right left".
  }

  // Switch statements and expressions
  {
    var obj = (1, 2);

    switch (obj) {
      // Matches if 1 == obj.
      case 1:
        print('one');

      // Matches if the value of obj is between the constant values of 'first' and 'last'.
      // case >= first && <= last:
      //   print('in range');

      // Matches if obj is a record with two fields, then assigns the fields to 'a' and 'b'.
      case (var a, var b):
        print('a = $a, b = $b');

      default:
    }
  }
  {
    var color = Color.red;

    var isPrimary = switch (color) {
      Color.red || Color.yellow || Color.blue => true,
      _ => false
    };
  }
  {
    var shape = Circle(2);

    switch (shape) {
      case Square(size: var s) || Circle(size: var s) when s > 0:
        print('Non-empty symmetric shape');
    }
  }

  // For and for-in loops
  {
    Map<String, int> hist = {
      'a': 23,
      'b': 100,
    };

    for (var MapEntry(key: key, value: count) in hist.entries) {
      print('$key occurred $count times');
    }

    for (var MapEntry(:key, value: count) in hist.entries) {
      print('$key occurred $count times');
    }
  }
}

class Foo {
  var one;
  var two;

  Foo({this.one, this.two});
}

sealed class Shape {}

class Square implements Shape {
  final double length;
  Square(this.length);

  num get size => length * length;
}

class Circle implements Shape {
  final double radius;
  Circle(this.radius);

  num get size => pi * pow(radius, 2);
}

void usesCasesForPatterns() {
  print('\n----- usesCasesForPatterns -----');

  // Destructuring multiple returns
  {
    (String, int) userInfo(Map<String, dynamic> json) {
      return (json['name'] as String, json['age'] as int);
    }

    final json = <String, dynamic>{
      'name': 'Dash',
      'age': 10,
      'color': 'blue',
    };

    var (name, age) = userInfo(json);
  }

  // Destructuring class instances
  {
    final Foo myFoo = Foo(one: 'one', two: 2);
    var Foo(:one, :two) = myFoo;
    print('one $one, two $two');
  }

  // Algebraic data types
  {
    double calculateArea(Shape shape) => switch (shape) {
          Square(length: var l) => l * l,
          Circle(radius: var r) => pi * r * r
        };
  }

  // Validating incoming JSON
  {
    var json = {
      'user': ['Lily', 13]
    };
    var {'user': [name, age]} = json;

    if (json case {'user': [String name, int age]}) {
      print('User $name is $age years old.');
    }
  }
}

// Pattern types
//  https://dart.dev/language/pattern-types
