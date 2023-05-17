// https://dart.dev/language/metadata
//  dart 2_language/metadata.dart
import 'dart:mirrors';

class Todo {
  final String who;
  final String what;

  const Todo(this.who, this.what);
}

@Todo('Dash', 'Implement this function')
void doSomething() {
  print('Do something');
}

void main(List<String> args) {
  getMetadata();
}

void getMetadata() {
  LibraryMirror currentLib = currentMirrorSystem().libraries.values.last;
  currentLib.declarations.forEach((Symbol s, DeclarationMirror mirror) {
    if (mirror.metadata.length > 0) {
      var todo = mirror.metadata
          .firstWhere((e) => e.hasReflectee && e.reflectee.runtimeType == Todo)
          .reflectee;
      print('$s has ${Todo}(who="${todo.who}" what="${todo.what}")');
    }
  });
}
