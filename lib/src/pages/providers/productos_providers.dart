
import 'package:dio/dio.dart';
import 'package:formvalidation/src/models/producto_model.dart';
import 'dart:convert';

class ProductosProvider{

  final String _url = 'http://192.168.1.113:9000';
  Dio dio = Dio();
  ProductoModel producto = new ProductoModel();



  Future<bool>crearProducto(ProductoModel producto) async{

    final url = '$_url/api/books';

    final resp = await dio.post(url,data: productoModelToJson(producto));

      print(resp.data);
      return true;
  }

  Future<bool>editarProducto(ProductoModel producto) async{
    String idP = producto.id.toString();    


    final url = '$_url/api/books/$idP';

    print(url);

    final resp = await dio.put(url,data: productoModelToJson(producto));

      print(resp.data);
      return true;
  }

  
  Future<List<ProductoModel>> cargarProductos() async{
    final url = '$_url/api/books';

    final resp = await dio.get(url); 

    final List<ProductoModel> productos = [];
     
    final result =  resp.data.map((item){
          print(item);
          final prodTemp = ProductoModel.fromJson(item);


          productos.add(prodTemp);
    });

    print('Aquiiii');
    print(result);
    print(productos);

    return productos;

  }

  Future<int> borrarProducto( int id) async{
    String idP = id.toString();    
    final url = '$_url/api/books/$idP';

    final resp = await dio.delete(url);

    print(resp);

    return 1;

  }



  Future<bool>consultarProductos() async{
    final url = '$_url/api/books';

    final resp = await dio.get(url);

    print(resp.data);

    return true;

  }
}