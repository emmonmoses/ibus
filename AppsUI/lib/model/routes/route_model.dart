class CarType {
  final String name;
  final String image;
  final double price;

  CarType({required this.name, required this.image, required this.price});

  factory CarType.fromJson(Map<String, dynamic> json) {
    return CarType(
      name: json['name'],
      image: json['image'],
      price: json['price'],
    );
  }
}

class TripDetail {
  final String name;
  final String image;
  final String startTime;
  final double price;
  final int availableSeats;
  final List<CarType> carTypes;

  TripDetail({
    required this.name,
    required this.image,
    required this.startTime,
    required this.price,
    required this.availableSeats,
    required this.carTypes,
  });

  factory TripDetail.fromJson(Map<String, dynamic> json) {
    var carTypesList = json['carTypes'] as List;
    List<CarType> carTypes = carTypesList.map((i) => CarType.fromJson(i)).toList();

    return TripDetail(
      name: json['name'],
      image: json['image'],
      startTime: json['startTime'],
      price: json['price'],
      availableSeats: json['availableSeats'],
      carTypes: carTypes,
    );
  }
}

class TripResponse {
  final int page;
  final int pages;
  final int pageSize;
  final int rows;
  final List<TripDetail> data;

  TripResponse({
    required this.page,
    required this.pages,
    required this.pageSize,
    required this.rows,
    required this.data,
  });

  factory TripResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<TripDetail> dataList = list.map((i) => TripDetail.fromJson(i)).toList();

    return TripResponse(
      page: json['page'],
      pages: json['pages'],
      pageSize: json['pageSize'],
      rows: json['rows'],
      data: dataList,
    );
  }
}
