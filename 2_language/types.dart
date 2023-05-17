// https://dart.dev/language/built-in-types
//  dart 2_language/types.dart
//  dart --enable-experiment=records 2_language/types.dart

void main(List<String> args) {
  tourRecords();
  tourCollections();
  tourGenerics();
  tourTypedefs();
}

// Records (require sdk >= 3.0.0)
//  https://dart.dev/language/records

void tourRecords() {
  print('\n----- Records -----');

  // Record syntax
  {
    var record = ('first', a: 2, b: true, 'last');

    (int, int) swap((int, int) record) {
      var (a, b) = record;
      return (b, a);
    }
  }
  {
    // Record type annotation in a variable declaration:
    (String, int) record;

    // Initialize it with a record expression:
    record = ('A string', 123);
  }
  {
    // Record type annotation in a variable declaration:
    ({int a, bool b}) record;

    // Initialize it with a record expression:
    record = (a: 123, b: true);
  }

  {
    ({int a, int b}) recordAB = (a: 1, b: 2);
    ({int x, int y}) recordXY = (x: 3, y: 4);

    // Compile error! These records don't have the same type.
    // recordAB = recordXY;
  }
  {
    (int a, int b) recordAB = (1, 2);
    (int x, int y) recordXY = (3, 4);

    recordAB = recordXY; // OK.
  }

  // Record fields
  {
    var record = ('first', a: 2, b: true, 'last');

    print(record.$1); // Prints 'first', maybe $0 if experiment when sdk < 3.0.0
    print(record.a); // Prints 2
    print(record.b); // Prints true
    print(record.$2); // Prints 'last'
  }

  // Record types
  {
    (num, Object) pair = (42, 'a');

    var first = pair.$1; // Static type `num`, runtime type `int`.
    var second = pair.$2; // Static type `Object`, runtime type `String`.
  }

  // Record equality
  {
    (int x, int y, int z) point = (1, 2, 3);
    (int r, int g, int b) color = (1, 2, 3);

    print(point == color); // Prints 'true'.
  }
  {
    ({int x, int y, int z}) point = (x: 1, y: 2, z: 3);
    ({int r, int g, int b}) color = (r: 1, g: 2, b: 3);

    print(point == color); // Prints 'false'. Lint: Equals on unrelated types.
  }

  // Multiple returns
  {
    // Returns multiple values in a record:
    (String, int) userInfo(Map<String, dynamic> json) {
      return (json['name'] as String, json['age'] as int);
    }

    final json = <String, dynamic>{
      'name': 'Dash',
      'age': 10,
      'color': 'blue',
    };

    // Destructures using a record pattern:
    var (name, age) = userInfo(json);

    /* Equivalent to:
      var info = userInfo(json);
      var name = info.$1;
      var age  = info.$2;
    */
  }
}

// Collections
//  https://dart.dev/language/collections

void tourCollections() {
  print('\n----- Collections -----');

  // Lists
  {
    var list = [1, 2, 3];
    assert(list.length == 3);
    assert(list[1] == 2);

    list[1] = 1;
    assert(list[1] == 1);
  }
  {
    var list = [
      'Car',
      'Boat',
      'Plane', // trailing comma
    ];
  }
  {
    var constantList = const [1, 2, 3];
    // constantList[1] = 1; // This line will cause an error.
  }

  // Sets
  {
    var halogens = {'fluorine', 'chlorine', 'bromine', 'iodine', 'astatine'};

    var elements = <String>{};
    elements.add('fluorine');
    elements.addAll(halogens);
    assert(elements.length == 5);
  }
  {
    var names = <String>{};
    // Set<String> names = {}; // This works, too.
    // var names = {}; // Creates a map, not a set.
  }
  {
    final constantSet = const {
      'fluorine',
      'chlorine',
      'bromine',
      'iodine',
      'astatine',
    };
    // constantSet.add('helium'); // This line will cause an error.
  }

  // Maps
  {
    var gifts = {
      // Key:    Value
      'first': 'partridge',
      'second': 'turtledoves',
      'fifth': 'golden rings'
    };

    var nobleGases = {
      2: 'helium',
      10: 'neon',
      18: 'argon',
    };
  }
  {
    var gifts = Map<String, String>();
    gifts['first'] = 'partridge';
    gifts['second'] = 'turtledoves';
    gifts['fifth'] = 'golden rings';

    var nobleGases = Map<int, String>();
    nobleGases[2] = 'helium';
    nobleGases[10] = 'neon';
    nobleGases[18] = 'argon';
  }
  {
    var gifts = {'first': 'partridge'};

    assert(gifts['first'] == 'partridge');
    assert(gifts['fifth'] == null);

    gifts['fourth'] = 'calling birds'; // Add a key-value pair
    assert(gifts.length == 2);
  }
  {
    final constantMap = const {
      2: 'helium',
      10: 'neon',
      18: 'argon',
    };
    // constantMap[2] = 'Helium'; // This line will cause an error.
  }

  // Spread operators
  {
    var list = [1, 2, 3];
    var list2 = [0, ...list];
    assert(list2.length == 4);
  }
  {
    List<int>? list;
    var list2 = [0, ...?list];
    assert(list2.length == 1);
  }

  // Control-flow operators
  {
    var promoActive = true;
    var nav = ['Home', 'Furniture', 'Plants', if (promoActive) 'Outlet'];
  }
  /*{
    var login = 'Manager';
    var nav = ['Home', 'Furniture', 'Plants', if (login case 'Manager') 'Inventory'];
  }*/
  {
    var listOfInts = [1, 2, 3];
    var listOfStrings = ['#0', for (var i in listOfInts) '#$i'];
    assert(listOfStrings[1] == '#1');
  }
}

// Generics
//  https://dart.dev/language/generics

void tourGenerics() {
  print('\n----- Generics -----');

  {
    var names = <String>[];
    names.addAll(['Seth', 'Kathy', 'Lars']);
    // names.add(42); // Error
  }

  // Using collection literals
  {
    var names = <String>['Seth', 'Kathy', 'Lars'];
    var uniqueNames = <String>{'Seth', 'Kathy', 'Lars'};
    var pages = <String, String>{
      'index.html': 'Homepage',
      'robots.txt': 'Hints for web robots',
      'humans.txt': 'We are people, not machines'
    };
  }

  // Using parameterized types with constructors
  {
    var names = <String>['Seth', 'Kathy', 'Lars'];

    var nameSet = Set<String>.from(names);

    var views = Map<int, Object /*View*/ >();
  }

  // Generic collections and the types they contain
  {
    var names = <String>[];
    names.addAll(['Seth', 'Kathy', 'Lars']);
    print(names is List<String>); // true
  }

  // Restricting the parameterized type
  {
    var someBaseClassFoo = Foo<SomeBaseClass>();
    var extenderFoo = Foo<Extender>();

    var foo = Foo();
    print(foo);
  }

  // Using generic methods
  {
    T first<T>(List<T> ts) {
      // Do some initial work or error checking, then...
      T tmp = ts[0];
      // Do some additional checking or processing...
      return tmp;
    }
  }
}

// Reduce code duplication
abstract class Cache<T> {
  T getByKey(String key);
  void setByKey(String key, T value);
}

class SomeBaseClass {}

class Extender extends SomeBaseClass {}

class Foo<T extends SomeBaseClass> {
  // Implementation goes here...
  String toString() => "Instance of 'Foo<$T>'";
}

// Typedefs
//  https://dart.dev/language/typedefs

typedef IntList = List<int>;
typedef ListMapper<X> = Map<X, List<X>>;
typedef Compare<T> = int Function(T a, T b);

void tourTypedefs() {
  print('\n----- Typedefs -----');

  IntList il = [1, 2, 3];

  Map<String, List<String>> m1 = {}; // Verbose.
  ListMapper<String> m2 = {}; // Same thing but shorter and clearer.

  int sort(int a, int b) => a - b;
  assert(sort is Compare<int>); // True!
}
