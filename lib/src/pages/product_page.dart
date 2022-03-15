import 'package:flutter/material.dart';
import 'package:formvalidation/src/models/producto_model.dart';
import 'package:formvalidation/src/pages/providers/productos_providers.dart';
import 'package:formvalidation/src/utlis/utils.dart' as utils;

class ProductPage extends StatefulWidget {

  @override
  _ProductPageState createState() => _ProductPageState();
}



class _ProductPageState extends State<ProductPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final productosProvider = new ProductosProvider();

  ProductoModel producto = new ProductoModel();



  bool _guardando = false;

  @override
  Widget build(BuildContext context) {

    final ProductoModel prodData = ModalRoute.of(context).settings.arguments;

    if (prodData != null) {
      producto = prodData;
    }

    return Scaffold(
      key: scaffoldkey,
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
                _crearTitulo(),
                _crearAutor(),
                _crearEdicion(),

                _crearBoton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearTitulo() {
    return TextFormField(
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Titulo'),
      onSaved: (value) => producto.titulo = value,
      validator: (value){
        if (value.length < 3) {
          return 'Ingrese el nombre del producto';
        }else{
          return null;
        }
      },
    );
  }
    Widget _crearAutor() {
    return TextFormField(
      initialValue: producto.autor,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Autor'),
      onSaved: (value) => producto.autor = value,
      validator: (value){
        if (value.length < 1) {
          return 'Ingrese el nombre del producto';
        }else{
          return null;
        }
      },
    );
  }

  Widget _crearEdicion() {
    return TextFormField(
      initialValue: producto.edicion.toString(),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Edicion'),
      onSaved: (value) => producto.edicion = int.parse(value),
      validator: (value){
        if (utils.isNumeric(value)) {
          return null;
        }else{
          return 'Solo numeros';
        }
      }
    );
  }

  // Widget _crearDisponible(){
  //   return SwitchListTile(
  //     value: producto.disponible ==1 ? true :false,
  //     title: Text('disponible'),
  //     activeColor: Colors.deepPurple,

  //     onChanged: (value) => setState((){  
  //       producto.disponible =  (producto.disponible == 1 ? value = true: value=false) as int;
  //     })
  //   );
  // }

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
          onPressed: (_guardando) ? null : _submit,
          child: Row(
            children: [Icon(Icons.save),SizedBox(width: 5,),  Text('Guardar')],
          ),
          ),
      );
  }

  void _submit(){
    if(!formKey.currentState.validate()) return;
    formKey.currentState.save();

    
    setState(() {_guardando= true;});

    if (producto.id == null) {
      productosProvider.crearProducto(producto);
    }else{
      productosProvider.editarProducto(producto);
    }

    // setState(() {_guardando= false;});

    mostrarSnacbar('Registro guardado');

    Navigator.pop(context);

  }



  void mostrarSnacbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    ); 
    // ignore: deprecated_member_use
    scaffoldkey.currentState.showSnackBar(snackbar);
  }
}
