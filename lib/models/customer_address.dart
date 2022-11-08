import 'dart:convert';

class Rating {
  final String userId;
  final String recieverName;
  final String house;
  final String area;
  final String town;
  final String state;
  final int pincode;

  Rating(this.userId, this.recieverName, this.house, this.area, this.town, this.state, this.pincode);

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'userId': userId});
    result.addAll({'recieverName': recieverName});
    result.addAll({'house': house});
    result.addAll({'area': area});
    result.addAll({'town': town});
    result.addAll({'state': state});
    result.addAll({'pincode': pincode});
  
    return result;
  }

  factory Rating.fromMap(Map<String, dynamic> map) {
    return Rating(
      map['userId'] ?? '',
      map['recieverName'] ?? '',
      map['house'] ?? '',
      map['area'] ?? '',
      map['town'] ?? '',
      map['state'] ?? '',
      map['pincode']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Rating.fromJson(String source) => Rating.fromMap(json.decode(source));
}
