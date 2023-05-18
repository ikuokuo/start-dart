// https://dart.dev/language/error-handling
//  dart 2_language/error_handling.dart

void main(List<String> args) {
  // Exceptions

  // Throw
  try {
    throw FormatException('Expected at least 1 section');

    throw 'Out of llamas!';

    // void distanceTo(Point other) => throw UnimplementedError();
  } catch (e) {
    print(e);
  }

  // Catch
  /*{
    try {
      breedMoreLlamas();
    } on OutOfLlamasException {
      buyMoreLlamas();
    }

    try {
      breedMoreLlamas();
    } on OutOfLlamasException {
      // A specific exception
      buyMoreLlamas();
    } on Exception catch (e) {
      // Anything else that is an exception
      print('Unknown exception: $e');
    } catch (e) {
      // No specified type, handles all
      print('Something really unknown: $e');
    }

    try {
      // ···
    } on Exception catch (e) {
      print('Exception details:\n $e');
    } catch (e, s) {
      print('Exception details:\n $e');
      print('Stack trace:\n $s');
    }
  }*/
  {
    void misbehave() {
      try {
        dynamic foo = true;
        print(foo++); // Runtime error
      } catch (e) {
        print('misbehave() partially handled ${e.runtimeType}.');
        rethrow; // Allow callers to see the exception.
      }
    }

    try {
      misbehave();
    } catch (e) {
      print('main() finished handling ${e.runtimeType}.');
    }
  }

  // Finally
  /*{
    try {
      breedMoreLlamas();
    } finally {
      // Always clean up, even if an exception is thrown.
      cleanLlamaStalls();
    }

    try {
      breedMoreLlamas();
    } catch (e) {
      print('Error: $e'); // Handle the exception first.
    } finally {
      cleanLlamaStalls(); // Then clean up.
    }
  }*/

  // Assert
  /*{
    // Make sure the variable has a non-null value.
    assert(text != null);

    // Make sure the value is less than 100.
    assert(number < 100);

    // Make sure this is an https URL.
    assert(urlString.startsWith('https'));

    assert(urlString.startsWith('https'),
        'URL ($urlString) should start with "https".');
  }*/
}
