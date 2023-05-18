//
//  dart 2_language/control_flow.dart

import 'dart:math' as math;

void main(List<String> args) {
  tourLoops();
  tourBranches();
}

// Loops
//  https://dart.dev/language/loops

class Point {
  int x;
  int y;
  Point(this.x, this.y);
}

sealed class Shape {}

class Square implements Shape {
  final double length;
  Square(this.length);
}

class Circle implements Shape {
  final double radius;
  Circle(this.radius);
}

void tourLoops() {
  print('\n----- Loops -----');

  // For loops
  {
    var message = StringBuffer('Dart is fun');
    for (var i = 0; i < 5; i++) {
      message.write('!');
    }
  }
  {
    var callbacks = [];
    for (var i = 0; i < 2; i++) {
      callbacks.add(() => print(i));
    }

    for (final c in callbacks) {
      c();
    }
  }
  /*{
    for (final candidate in candidates) {
      candidate.interview();
    }
    for (final Candidate(:name, :yearsExperience) in candidates) {
      print('$name has $yearsExperience of experience.');
    }
  }*/
  {
    var collection = [1, 2, 3];
    collection.forEach(print); // 1 2 3
  }

  // While and do-while
  /*{
    while (!isDone()) {
      doSomething();
    }

    do {
      printLine();
    } while (!atEndOfPage());
  }*/

  // Break and continue
  /*{
    while (true) {
      if (shutDownRequested()) break;
      processIncomingRequests();
    }

    for (int i = 0; i < candidates.length; i++) {
      var candidate = candidates[i];
      if (candidate.yearsExperience < 5) {
        continue;
      }
      candidate.interview();
    }

    candidates
        .where((c) => c.yearsExperience >= 5)
        .forEach((c) => c.interview());
  }*/
}

// Branches
//  https://dart.dev/language/branches

void tourBranches() {
  print('\n----- Branches -----');

  // If
  /*{
    if (isRaining()) {
      you.bringRainCoat();
    } else if (isSnowing()) {
      you.wearJacket();
    } else {
      car.putTopDown();
    }
  }*/

  // If-case
  {
    var pair = [1, 2];

    if (pair case [int x, int y]) print(Point(x, y));

    if (pair case [int x, int y]) {
      print('Was coordinate array $x,$y');
    } else {
      throw FormatException('Invalid coordinates.');
    }
  }

  // Switch statements
  /*{
    var command = 'OPEN';
    switch (command) {
      case 'CLOSED':
        executeClosed();
      case 'PENDING':
        executePending();
      case 'APPROVED':
        executeApproved();
      case 'DENIED':
        executeDenied();
      case 'OPEN':
        executeOpen();
      default:
        executeUnknown();
    }
  }*/
  /*{
    switch (command) {
      case 'OPEN':
        executeOpen();
        continue newCase; // Continues executing at the newCase label.

      case 'DENIED': // Empty case falls through.
      case 'CLOSED':
        executeClosed(); // Runs for both DENIED and CLOSED,

      newCase:
      case 'PENDING':
        executeNowClosed(); // Runs for both OPEN and PENDING.
    }
  }*/

  // Switch expressions
  /*{
    var x = switch (y) { ... };

    print(switch (x) { ... });

    return switch (x) { ... };
  }*/
  /*{
    // Where slash, star, comma, semicolon, etc., are constant variables...

    switch (charCode) {
      case slash || star || plus || minus: // Logical-or pattern
        token = operator(charCode);
      case comma || semicolon: // Logical-or pattern
        token = punctuation(charCode);
      case >= digit0 && <= digit9: // Relational and logical-and patterns
        token = number();
      default:
        throw invalid();
    }
  }*/
  /*{
    token = switch (charCode) {
      slash || star || plus || minus => operator(charCode),
      comma || semicolon => punctuation(charCode),
      >= digit0 && <= digit9 => number(),
      _ => throw invalid()
    };
  }*/

  // Exhaustiveness checking
  {
    bool? b = false;
    // Non-exhaustive switch on bool?, missing case to match null possiblity:
    switch (b) {
      case true:
        print('yes');
      case false:
        print('no');
    }
  }
  {
    double calculateArea(Shape shape) => switch (shape) {
          Square(length: var l) => l * l,
          Circle(radius: var r) => math.pi * r * r
        };
  }

  // Guard clause
  {
    var pair = (1, 2);

    switch (pair) {
      case (int a, int b) when a > b:
        print('First element greater');
      case (int a, int b):
        print('First element not greater');
    }
  }
}
