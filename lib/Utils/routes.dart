
class Routes {

  static const String apiRoute = 'https://edva-39tyo.ondigitalocean.app/v1/places';

  static const String getPlacesFromRegion = '$apiRoute/region';

  static const String postFeedback = '$apiRoute/feedback';

  static const String postExperience = '$apiRoute/experience';

  static const String getScore = '$apiRoute/experience/get_score';

}