///Place's Model. Factory to create an object from API
///name to referer place, like "Estadio Santa Laura"
///region, Chile is demographically separated on fifteen regions
///city, city on region
///address, street's name
///hours, operation hours
class Place {
  int placeId = 0;
  String name = '';
  String region = '';
  String city = '';
  String address = '';
  String time = '';
  double score = 0;
  int amount = 0;
  double lat = 0;
  double long = 0;

  Place({
    required this.placeId,
    required this.name,
    required this.address,
    required this.region,
    required this.city,
    required this.time,
    required this.score,
    required this.amount,
    required this.lat,
    required this.long
  });

  factory Place.fromJson(Map<String, dynamic> object){
    return Place(
        placeId: object['place_id'] ?? 0,
        name: object['placeName'] ?? '',
        address: object['address'] ?? '',
        region: object['region'] ?? '',
        city: object['commune'] ?? '',
        time: object['time'] ?? 'sin información',
        score: object['score'] ?? 0,
        amount: object['amount'] ?? 0,
        lat: object['lat'] ?? 0,
        long: object['long'] ?? 0
    );
  }

  @override
  toString(){
    return '$name / $address';
  }

}