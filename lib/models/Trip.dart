class Trip {
  String? message;
  String? tripId;
  String? userId;
  String? startDate;
  String? endDate;
  String? day_Travel;
  String? locationName;
  String? latitude;
  String? longitude;
  String? cost;
  String? trippicture;
  String? minCost;
  String? maxCost;
  String? createdAt;
  String? trippic;
  String? trippic2;
  String? trippic3;

  Trip(
      {this.message,
      this.tripId,
      this.userId,
      this.startDate,
      this.endDate,
      this.day_Travel,
      this.locationName,
      this.latitude,
      this.longitude,
      this.cost,
      this.trippicture,
      this.minCost,
      this.maxCost,
      this.createdAt,
      this.trippic,
      this.trippic2,
      this.trippic3
      });

  Trip.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    tripId = json['trip_id'];
    userId = json['user_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    day_Travel = json['day_Travel'];
    locationName = json['location_name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    cost = json['cost'];
    minCost = json['min_cost'];
    maxCost = json['max_cost'];
    createdAt = json['created_at'];
    trippic = json['trippic'];
    trippic2 = json['trippic2'];
    trippic3 = json['trippic3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['trip_id'] = this.tripId;
    data['user_id'] = this.userId;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['location_name'] = this.locationName;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['cost'] = this.cost;
    data['trippicture'] = this.trippicture;
    data['min_cost'] = this.minCost;
    data['max_cost'] = this.maxCost;
    data['created_at'] = this.createdAt;
    data['trippic'] = this.trippic;
    data['trippic2'] = this.trippic2;
    data['trippic3'] = this.trippic3;
    data['day_Travel'] = this.day_Travel;
    return data;
  }
}