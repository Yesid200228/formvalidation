import 'package:flutter/material.dart';
import 'package:formvalidation/src/utlis/utils.dart' as utils;

class ProductPage extends StatefulWidget {

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Producto'),
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.photo_size_select_actual)),
          IconButton(onPressed: () {}, icon: Icon(Icons.camera_alt)),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _crearNombre(),
                _crearPrecio(),
                _crearBoton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Producto'),
      validator: (value){
        if (value.length < 3) {
          return 'Ingrese el nombre del producto';
        }else{
          return null;
        }
      },
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Precio'),
      validator: (value){
        if (utils.isNumeric(value)) {
          return null;
        }else{
          return 'Solo numeros';
        }
      }
    );
  }

  Widget _crearBoton() {
    return
      Container(
        width: 120,
        child: RaisedButton(
          color: Colors.deepPurple,
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          onPressed: _submit,
          child: Row(
            children: [Icon(Icons.save),SizedBox(width: 5,),  Text('Guardar')],
          ),
          ),
      );
  }

  void _submit(){
    if(!formKey.currentState.validate()) return;

    print('Todo Ok');

  }
}
