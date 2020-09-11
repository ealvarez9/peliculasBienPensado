import 'package:flutter/material.dart';
import 'package:gbp/data/movieData.dart';
import 'package:gbp/models/actoresModel.dart';
import 'package:gbp/models/movieModel.dart';

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}
class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    final Pelicula movie = ModalRoute.of(context).settings.arguments;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(44, 56, 72, 1),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0.0,
            pinned: true,
            expandedHeight: size.height * 0.4,
            flexibleSpace: FlexibleSpaceBar(
              background: FadeInImage(
              fit: BoxFit.cover,
              image: NetworkImage(movie.getImagePelicula()),
              placeholder: AssetImage('assets/images/asset.jpg')
            ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 25.0,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              movie.title,
                              overflow: TextOverflow.ellipsis, 
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.4
                              ),
                            ),
                          ),
                          Icon(
                            Icons.image,
                            color: Color.fromRGBO(107, 115, 127, 1),
                            size: 16.0,
                          )
                        ],
                      ),
                      //
                      SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              ),
                            color: Color.fromRGBO(107, 115, 127, 1),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text(
                                'WATCH NOW',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                            onPressed: (){}, 
                          ),
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
                      SizedBox(height: 15.0,),
                      Text(
                        movie.overview,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.white38,
                        ),
                      ),
                      SizedBox(height: 15.0,),
                      _conocerActores( movie.id.toString() + '/credits'),
                    ],
                  ),
                )
              ]
            )
          ) 
        ],
      )
    );
  }
}

Widget _conocerActores(String endpoint){
  final dataActores  = new PeliculasData();
  dataActores.getCasting(endpoint);
  return FutureBuilder(
    future: dataActores.getCasting(endpoint),
    builder: (BuildContext context, AsyncSnapshot<List<Actor>> snapshot) {
      if (snapshot.hasData ) {
        print(snapshot.data.length);
        return _mostrarActoresPeli(context, snapshot.data);
      }else{
        print('sin info... todavía');
        return CircularProgressIndicator();
      }
    }
  );
}

Widget _mostrarActoresPeli(BuildContext context, List<Actor> data){
  return SizedBox(
    height: 150.0,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: data.length,
      itemBuilder: (BuildContext context, int i) {
        return SizedBox(
          width: 100.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipOval(
                  // borderRadius: BorderRadius.circular(1000.0),
                  child: FadeInImage(
                    height: 60.0,
                    width: 60,
                    fit: BoxFit.cover,
                    image: NetworkImage(data[i].getFotoActor()),
                    placeholder: AssetImage('assets/images/asset.jpg')
                  ),
                ),
                SizedBox(height: 10.0,),
                Text(
                  data[i].name,
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11.0
                  ),
                )
              
            ],
          ),
        );
      },
    ),
  );
}