import 'package:gbp/models/actoresModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:gbp/models/movieModel.dart';

class PeliculasData{
  String _apikey = '0b92a99f8fffe2170127cd025f7302e0';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  //método que consulta el EndPoint de la API y retorna una lista de peliculas
  Future<List<Pelicula>> getCines(String ruta) async{
    final url = Uri.https(
      _url,
      '3/movie/' + ruta,
      {
        'api_key' : _apikey,
        'language' : _language,
      }
    ); 
    final resp = await http.get(url);
    final dataResponse = json.decode(resp.body);

    final peliculas = new Peliculas.fromJsonList(dataResponse['results']);
    return peliculas.items;
  }
  
  Future<List<Actor>> getCasting(String ruta) async{
    
    final url = Uri.https(
      _url,
      '3/movie/' + ruta,
      {
        'api_key' : _apikey,
        'language' : _language,
      }
    ); 
    final resp = await http.get(url);
    final dataResponse = json.decode(resp.body);

    final reparto = new Casting.fromJsonList(dataResponse['cast']);
    return reparto.actores;
  }
}