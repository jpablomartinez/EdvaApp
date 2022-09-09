// ignore_for_file: curly_braces_in_flow_control_structures

class Score {

  double score = 0;
  int opinions = 0;

  Score({
    required this.score,
    required this.opinions
  });

  static double parseScore(dynamic value){
    if (value is int) return value.toDouble();
    else if(value is double){
      String tmp = value.toStringAsFixed(2);
      return double.parse(tmp);
    }
    else return 0.0;
  }

  factory Score.fromJson(Map<String, dynamic> obj){
    double s = parseScore(obj['score'] ?? 0.0);
    return Score(
      score: s,
      opinions: obj['opinions'] ?? 0
    );
  }

}