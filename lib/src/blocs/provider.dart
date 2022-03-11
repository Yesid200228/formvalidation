import 'package:flutter/material.dart';
import 'package:formvalidation/src/blocs/login_bloc.dart';
export 'package:formvalidation/src/blocs/login_bloc.dart';


class Provider  extends InheritedWidget{

  final loginBloc = LoginBLoc();
  Provider({Key key, Widget child})
    :super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBLoc of (BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }
  
}