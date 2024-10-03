class Trip {
  String? message;
  String? tripId;
  String? userId;
  String? startDate;
  String? endDate;
  String? dayTravel;
  String? locationName;
  String? latitude;
  String? longitude;
  String? cost;
  String? trippicture;
  String? minCost;
  String? maxCost;
  String? createdAt;

  Trip(
      {this.message,
      this.tripId,
      this.userId,
      this.startDate,
      this.endDate,
      this.dayTravel,
      this.locationName,
      this.latitude,
      this.longitude,
      this.cost,
      this.trippicture,
      this.minCost,
      this.maxCost,
      this.createdAt});

  Trip.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    tripId = json['trip_id'];
    userId = json['user_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    dayTravel = json['dayTravel'];
    locationName = json['location_name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    cost = json['cost'];
    cost = json['trippicture'];
    minCost = json['min_cost'];
    maxCost = json['max_cost'];
    createdAt = json['created_at'];
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
    return data;
  }
}