import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:formvalidation/src/blocs/provider.dart';
import 'package:formvalidation/src/models/producto_model.dart';
import 'package:formvalidation/src/pages/providers/productos_providers.dart';


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final productosProvider = new ProductosProvider();

  @override
  Widget build(BuildContext context) {

    
    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Home'))
      ),
      body:  _crearListado(),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget  _crearListado(){

    return FutureBuilder(
      future: productosProvider.cargarProductos(),
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot){
        if (snapshot.hasData) {
          final productos = snapshot.data;
          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context,i) => _crearItem(productos[i],context)
          );

        }else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem( ProductoModel producto,BuildContext context){
    
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direccion){
        productosProvider.borrarProducto(producto.id);
      },
      child: ListTile(
        title: Text('${producto.titulo}'),
        subtitle: Text(producto.autor),
        onTap: () => Navigator.pushNamed(context, 'producto',arguments: producto ).then((value) =>  initState()),
    
      ),
    );
  }

  void initState() {
    setState(() {
      
    });
      super.initState();
  }

  _crearBoton(BuildContext context){
    return FloatingActionButton(
      onPressed: () => Navigator.pushNamed(context, 'producto') ,
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      
    );
  }
}
