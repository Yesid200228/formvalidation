
import 'dart:async';

class LoginBLoc{

  final _emailController = StreamController<String>.broadcast();
  final _passwordController = StreamController<String>.broadcast();

  //Recuperar los datos del stream
  Stream<String> get emailStream => _emailController.stream;
  Stream<String> get  passwordStream => _passwordController.stream;


  //Insertar valores al Stream
  Function(String) get changeEmail => _emailController.add;
  Function(String) get changePassword => _passwordController.add;

  dispose() {
    _emailController.close();
    _passwordController.close();

  }


}



