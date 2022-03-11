
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:formvalidation/src/blocs/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBLoc with Validators{

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();


  //Recuperar los datos del stream
  Stream<String> get emailStream => _emailController.stream.transform(validarEmail);
  Stream<String> get  passwordStream => _passwordController.stream.transform(validarPassword);

  Stream<bool> get formValidStream =>
       Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);

  //Insertar valores al Stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  //obtener el ultimo valor ingresar a los streams

  String get email => _emailController.value;
  
  String get password => _passwordController.value;
  

  dispose() {
    _emailController.close();
    _passwordController.close();

  }


}



