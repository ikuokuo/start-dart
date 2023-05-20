// https://dart.dev/null-safety
//  dart 2_language/null_safety.dart

void main(List<String> args) {
  // Nullability in the type system
  {
    // Non-nullable and nullable types
    makeCoffee(String coffee, [String? dairy]) {
      if (dairy != null) {
        print('$coffee with $dairy');
      } else {
        print('Black $coffee');
      }
    }
  }
  {
    // Using nullable types
    requireStringNotObject(String definitelyString) {
      print(definitelyString.length);
    }

    Object maybeString = 'it is';
    // You’ll have to add the explicit downcast yourself:
    requireStringNotObject(maybeString as String);
  }

  // Ensuring correctness
  {
    // Invalid returns
    // Under null safety, you get a compile error if a function with a non-nullable return type doesn’t reliably return a value.
    String alwaysReturns(int n) {
      if (n == 0) {
        return 'zero';
      } else if (n < 0) {
        throw ArgumentError('Negative values not allowed.');
      } else {
        if (n > 1000) {
          return 'big';
        } else {
          return n.toString();
        }
      }
    }
  }
  {
    // Uninitialized variables
  }

  // Flow analysis
  {
    // With (or without) null safety:
    bool isEmptyList(Object object) {
      if (object is List) {
        return object.isEmpty; // <-- OK!
      } else {
        return false;
      }
    }
  }
  {
    // Reachability analysis

    // With null safety:
    bool isEmptyList(Object object) {
      if (object is! List) return false;
      return object.isEmpty; // <-- OK!
    }
  }
  {
    // Never for unreachable code

    // Using null safety:
    Never wrongType(String type, Object value) {
      throw ArgumentError('Expected $type, but was ${value.runtimeType}.');
    }
  }
  {
    // Definite assignment analysis

    // Using null safety:
    int tracingFibonacci(int n) {
      final int result;
      if (n < 2) {
        result = n;
      } else {
        result = tracingFibonacci(n - 2) + tracingFibonacci(n - 1);
      }

      print(result);
      return result;
    }
  }
  {
    // Type promotion on null checks

    // Using null safety:
    String makeCommand(String executable, [List<String>? arguments]) {
      var result = executable;
      if (arguments != null) {
        result += ' ' + arguments.join(' ');
      }
      return result;
    }
  }
  {
    // Using null safety:
    String makeCommand(String executable, [List<String>? arguments]) {
      var result = executable;
      if (arguments == null) return result;
      return result + ' ' + arguments.join(' ');
    }
  }
  {
    // Unnecessary code warnings

    // Using null safety:
    String checkList(List<Object> list) {
      if (list?.isEmpty ?? false) {
        // '?.' is unnecessary
        return 'Got nothing';
      }
      return 'Got something';
    }
  }
  {
    // Using null safety:
    String checkList(List<Object>? list) {
      if (list == null) return 'No list';
      if (list?.isEmpty ?? false) {
        // '?.' is unnecessary
        return 'Empty list';
      }
      return 'Got something';
    }
  }

  // Working with nullable types
  {
    // Smarter null-aware methods

    String? notAString = null;
    print(notAString?.length?.isEven); // second '?.' is unnecessary
  }
  {
    // Null assertion operator
    /*
    class HttpResponse {
      final int code;
      final String? error;

      HttpResponse.ok()
          : code = 200,
            error = null;
      HttpResponse.notFound()
          : code = 404,
            error = 'Not found';

      @override
      String toString() {
        if (code == 200) return 'OK';
        return 'ERROR $code ${error!.toUpperCase()}';
      }
    }
    */
  }
  {
    // Late variables
    /*
    class Coffee {
      late String _temperature;

      void heat() { _temperature = 'hot'; }
      void chill() { _temperature = 'iced'; }

      String serve() => _temperature + ' coffee';
    }
    */
  }
  {
    // Lazy initialization
    /*
    class Weather {
      late int _temperature = _readThermometer();
    }
    */
  }
  {
    // Late final variables
    /*
    class Coffee {
      late final String _temperature;

      void heat() { _temperature = 'hot'; }
      void chill() { _temperature = 'iced'; }

      String serve() => _temperature + ' coffee';
    }
    */
  }
  {
    // Required named parameters

    function({int? a, required int? b, int? c, required int? d}) {}
  }
  {
    // Abstract fields
    /*
    abstract class Cup {
      abstract Beverage contents; // explicit abstract getter/setter declarations
    }
    */
  }
  {
    // Working with nullable fields
    /*
    class Coffee {
      String? _temperature;

      void heat() {
        _temperature = 'hot';
      }

      void chill() {
        _temperature = 'iced';
      }

      void checkTemp() {
        if (_temperature != null) {
          print('Ready to serve ' + _temperature! + '!');
        }
      }

      String serve() => _temperature! + ' coffee';
    }
    */
  }
  {
    // Nullability and generics
    var box = Box<int?>.full(null);
    print(box.unbox());
  }

  // Core library changes
  {
    // The Map index operator is nullable

    var map = {'key': 'value'};
    print(map['key']!.length); // OK.
  }
  {
    // No unnamed List constructor
  }
  {
    // Cannot set a larger length on non-nullable lists
  }
  {
    // Cannot access Iterator.current before or after iteration
  }

  // FAQ
  //  https://dart.dev/null-safety/faq
}

class Box<T> {
  T? object;
  Box.empty();
  Box.full(this.object);

  T unbox() => object as T;
}

class Interval<T extends num?> {
  T min, max;

  Interval(this.min, this.max);

  bool get isEmpty {
    var localMin = min;
    var localMax = max;

    // No min or max means an open-ended interval.
    if (localMin == null || localMax == null) return false;
    return localMax <= localMin;
  }
}
