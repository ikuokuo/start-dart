// https://dart.dev/language/functions
//  dart 2_language/functions.dart

void main(List<String> args) {
  print(args);

  tourParameters();
  tourAsFirstClassObjects();
  tourAnonymous();
  tourLexicalScope();
  tourLexicalClosures();
  tourTestingForEquality();
  tourReturnValues();
  tourGenerators();
}

/*
bool isNoble(int atomicNumber) {
  return _nobleGases[atomicNumber] != null;
}

isNoble(atomicNumber) {
  return _nobleGases[atomicNumber] != null;
}

bool isNoble(int atomicNumber) => _nobleGases[atomicNumber] != null;
*/

void tourParameters() {
  print('\n----- Parameters -----');

  // Named parameters
  {
    /// Sets the [bold] and [hidden] flags ...
    void enableFlags({bool? bold, bool? hidden}) {}

    enableFlags(bold: true, hidden: false);
  }
  {
    /// Sets the [bold] and [hidden] flags ...
    void enableFlags({bool bold = false, bool hidden = false}) {}

    // bold will be true; hidden will be false.
    enableFlags(bold: true);
  }
  /*{
    const Scrollbar({super.key, required Widget child});

    const Scrollbar({super.key, required Widget? child});
  }*/
  // Dart allows named arguments to be placed anywhere in the argument list.
  /*{
    repeat(times: 2, () {});
  }*/

  // Optional positional parameters
  {
    String say(String from, String msg, [String? device]) {
      var result = '$from says $msg';
      if (device != null) {
        result = '$result with a $device';
      }
      return result;
    }

    assert(say('Bob', 'Howdy') == 'Bob says Howdy');

    assert(say('Bob', 'Howdy', 'smoke signal') ==
        'Bob says Howdy with a smoke signal');
  }
  {
    String say(String from, String msg, [String device = 'carrier pigeon']) {
      var result = '$from says $msg with a $device';
      return result;
    }

    assert(say('Bob', 'Howdy') == 'Bob says Howdy with a carrier pigeon');
  }
}

void tourAsFirstClassObjects() {
  print('\n----- Functions as first-class objects -----');

  {
    void printElement(int element) {
      print(element);
    }

    var list = [1, 2, 3];

    // Pass printElement as a parameter.
    list.forEach(printElement);
  }

  {
    var loudify = (msg) => '!!! ${msg.toUpperCase()} !!!';
    assert(loudify('hello') == '!!! HELLO !!!');
  }
}

void tourAnonymous() {
  print('\n----- Anonymous functions -----');

  const list = ['apples', 'bananas', 'oranges'];
  list.map((item) {
    return item.toUpperCase();
  }).forEach((item) {
    print('$item: ${item.length}');
  });

  list
      .map((item) => item.toUpperCase())
      .forEach((item) => print('$item: ${item.length}'));
}

bool topLevel = true;

void tourLexicalScope() {
  print('\n----- Lexical scope -----');

  var insideMain = true;

  void myFunction() {
    var insideFunction = true;

    void nestedFunction() {
      var insideNestedFunction = true;

      assert(topLevel);
      assert(insideMain);
      assert(insideFunction);
      assert(insideNestedFunction);
    }
  }
}

void tourLexicalClosures() {
  print('\n----- Lexical closures -----');

  /// Returns a function that adds [addBy] to the
  /// function's argument.
  Function makeAdder(int addBy) {
    return (int i) => addBy + i;
  }

  // Create a function that adds 2.
  var add2 = makeAdder(2);

  // Create a function that adds 4.
  var add4 = makeAdder(4);

  assert(add2(3) == 5);
  assert(add4(3) == 7);
}

void foo() {} // A top-level function

class A {
  static void bar() {} // A static method
  void baz() {} // An instance method
}

void tourTestingForEquality() {
  print('\n----- Testing functions for equality -----');

  Function x;

  // Comparing top-level functions.
  x = foo;
  assert(foo == x);

  // Comparing static methods.
  x = A.bar;
  assert(A.bar == x);

  // Comparing instance methods.
  var v = A(); // Instance #1 of A
  var w = A(); // Instance #2 of A
  var y = w;
  x = w.baz;

  // These closures refer to the same instance (#2),
  // so they're equal.
  assert(y.baz == x);

  // These closures refer to different instances,
  // so they're unequal.
  assert(v.baz != w.baz);
}

void tourReturnValues() {
  print('\n----- Return values -----');

  {
    foo() {}

    assert(foo() == null);
  }

  {
    (String, int) foo() {
      return ('something', 42);
    }
  }
}

void tourGenerators() {
  print('\n----- Generators -----');

  // Synchronous generator: Returns an Iterable object.
  {
    Iterable<int> naturalsTo(int n) sync* {
      int k = 0;
      while (k < n) yield k++;
    }
  }
  {
    Iterable<int> naturalsDownFrom(int n) sync* {
      if (n > 0) {
        yield n;
        yield* naturalsDownFrom(n - 1);
      }
    }
  }

  // Asynchronous generator: Returns a Stream object.
  {
    Stream<int> asynchronousNaturalsTo(int n) async* {
      int k = 0;
      while (k < n) yield k++;
    }
  }
}
