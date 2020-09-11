class Casting {
  List<Actor> actores = new List();
  Casting.fromJsonList( List<dynamic> jsonList  ){
    if ( jsonList == null ) return;
    jsonList.forEach( (item) {
      final actor = Actor.fromJsonMap(item);
      actores.add(actor);
    });
  }
}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Actor.fromJsonMap( Map<String, dynamic> json ) {

    castId      = json['cast_id'];
    character   = json['character'];
    creditId    = json['credit_id'];
    gender      = json['gender'];
    id          = json['id'];
    name        = json['name'];
    order       = json['order'];
    profilePath = json['profile_path'];

  }

   getFotoActor() {

    if ( profilePath == null ) {
      return 'https://res.cloudinary.com/dqaqts0kn/image/upload/v1599804784/Pedidos/aipy8nbm61unmswoolty.jpg';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}