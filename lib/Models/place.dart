///Place's Model. Factory to create an object from API
///name to referer place, like "Estadio Santa Laura"
///region, Chile is demographically separated on fifteen regions
///city, city on region
///address, street's name
///hours, operation hours
class Place {
  String name = '';
  String region = '';
  String city = '';
  String address = '';

  Place({
    required this.name,
    required this.address,
    required this.region,
    required this.city,
  });

  factory Place.fromJson(Map<String, dynamic> object){
    return Place(
        name: object['placeName'] ?? '',
        address: object['address'] ?? '',
        region: object['region'] ?? '',
        city: object['commune'] ?? ''
    );
  }

  @override
  toString(){
    return '$name / $address';
  }

}