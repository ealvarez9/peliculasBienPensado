import 'package:flutter/material.dart';
import 'package:gbp/data/movieData.dart';
import 'package:gbp/models/movieModel.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

final dataPeliculas  = new PeliculasData();

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(92, 160, 211, 1),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 35.0, left: 40.0, right: 40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, what do you want to watch?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.35),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(90.0)),
                          borderSide: BorderSide.none,
                        ),
                        labelText: ' Search',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        prefixIcon:  Icon(Icons.search, color: Colors.white,),
                        
                      )  // suffixStyle: const TextStyle(color: Colors.green)), 
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: size.height * 0.3, 
                ),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(44, 56, 72, 1),
                    borderRadius: new BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _tituloPrincipal('RECOMMENDED FOR YOU'),
                          _tituloSecundario('See all')
                        ],
                      ),
                      _imprimirPeliculas('popular'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _tituloPrincipal('TOP RATED'),
                          _tituloSecundario('See all')
                        ],
                      ),
                      _imprimirPeliculas('top_rated'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// #5CA0D3 Color azul
// Color.fromRGBO(92, 160, 211, 1),

// #3CAAD3 Color oscuro
// backgroundColor: Color.fromRGBO(44, 56, 72, 1),

Widget _imprimirPeliculas(String endpoint){
  return FutureBuilder(
    future: dataPeliculas.getCines(endpoint),
    builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
      if (snapshot.hasData ) {
        print(snapshot.data.length);
        return _mostrarCaratulasPeli(context, snapshot.data);
      }else{
        print('sin info... todavía');
        return Container(
          height: 300.0,
          child: Center(
            child: CircularProgressIndicator()
          ),
        );
      }
    }
  );
}

Widget _tituloPrincipal(String texto){
  return Container(
    margin: EdgeInsets.symmetric(vertical: 30.0),
    child: Text(
      texto,
      style: TextStyle(
        color: Colors.white,
        fontSize: 12.0,
        fontWeight: FontWeight.w500
      ),
    ),
  );
}

Widget _tituloSecundario(String texto){
  return Text(
    texto,
    style: TextStyle(
      color: Colors.white,
      fontSize: 11.0,
    ),
  );
}

Widget _nombrePelicula(String texto){
  return Text(
    texto,
    overflow: TextOverflow.ellipsis,
    maxLines: 1,
    style: TextStyle(
      color: Colors.white,
      fontSize: 11.0,
      fontWeight: FontWeight.w400
    ),
  );
}

Widget _mostrarCaratulasPeli(BuildContext context, List<Pelicula> data){
  return SizedBox(
    height: 250.0,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: data.length,
      itemBuilder: (BuildContext context, int i) {
        return InkWell(
          child: SizedBox(
            width: 150.0,
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: FadeInImage(
                      fit: BoxFit.fitHeight,
                      image: NetworkImage(data[i].getImagePelicula()),
                      placeholder: AssetImage('assets/images/asset.jpg')
                    ),
                  ),
                ),
                SizedBox(height: 5.0,),
                _nombrePelicula(data[i].title),
                SizedBox(height: 5.0,),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow[800],size: 14.0,),
                    Icon(Icons.star, color: Colors.yellow[800],size: 14.0,),
                    Icon(Icons.star, color: Colors.yellow[800],size: 14.0,),
                    Icon(Icons.star, color: Colors.yellow[800],size: 14.0,),
                    Icon(Icons.star, color: Colors.yellow[800],size: 14.0,),
                  ],
                )
              ],
            ),
          ),
          onTap: (){
            Navigator.pushNamed(context, 'DetailPage', arguments: data[i]);
          },
        );
      },
    ),
  );
}