class DriverDetail {
  final String name;
  final String phoneNumber;
  final String image;

  DriverDetail({
    required this.name,
    required this.phoneNumber,
    required this.image,
  });
}

class CarType {
  final String name;
  final String image;
  final double price;

  CarType({
    required this.name,
    required this.image,
    required this.price,
  });
}

class TripDetail {
  String id;
  String image;
  String name;
  double price;
  String pickup;
  String dropoff;
  int availableSeats;
  String drivingTime;
  String route;
  List<String> stops;
  String vehicleType;
  String driverName;
  String startTime;
  final DriverDetail driverDetail;
  final String paymentStatus;
  final List<CarType> carTypes;

  TripDetail({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.pickup,
    required this.dropoff,
    required this.availableSeats,
    required this.drivingTime,
    required this.route,
    required this.stops,
    required this.vehicleType,
    required this.driverName,
    required this.startTime,
    required this.driverDetail,
    required this.paymentStatus,
    required this.carTypes,
  });
}

List<TripDetail> tripsItems = [
  TripDetail(
    id: '1',
    image: 'assets/images/car.png',
    name: 'Bole - Saris',
    price: 12,
    pickup: 'Bole',
    dropoff: '4 kilo',
    availableSeats: 1,
    drivingTime: '20min',
    route: 'Route 1',
    stops: ['Stop 1', 'Stop 2'],
    vehicleType: 'Van',
    driverName: 'John Doe',
    startTime: '8:00 am',
    driverDetail: DriverDetail(
      name: 'John Doe',
      phoneNumber: '+1234567890',
      image: 'assets/images/usman.jpg',
    ),
    paymentStatus: 'Paid',
    carTypes: [
      CarType(name: 'Sedan', image: 'assets/images/sedan.png', price: 12),
      CarType(name: 'Midsize', image: 'assets/images/midsize.png', price: 12),
      CarType(name: 'Minivan', image: 'assets/images/minivan.jpg', price: 15),
      CarType(name: 'Minibus', image: 'assets/images/car.png', price: 10),
      CarType(name: 'Lada', image: 'assets/images/lada.PNG', price: 10),
    ],
  ),
  TripDetail(
    id: '2',
    image: 'assets/images/car.png',
    name: 'Saris - Megenagna ',
    price: 12,
    pickup: 'Bole',
    dropoff: '4 kilo',
    availableSeats: 1,
    drivingTime: '20min',
    route: 'Route 1',
    stops: ['Stop 1', 'Stop 2'],
    vehicleType: 'Van',
    driverName: 'John Doe',
    startTime: '8:00 am',
    driverDetail: DriverDetail(
      name: 'John Doe',
      phoneNumber: '+1234567890',
      image: 'assets/images/usman.jpg',
    ),
    paymentStatus: 'Paid',
    carTypes: [
      CarType(name: 'Sedan', image: 'assets/images/sedan.png', price: 12),
      CarType(name: 'Midsize', image: 'assets/images/midsize.png', price: 12),
      CarType(name: 'Minivan', image: 'assets/images/minivan.jpg', price: 15),
      CarType(name: 'Minibus', image: 'assets/images/car.png', price: 10),
      CarType(name: 'Lada', image: 'assets/images/lada.PNG', price: 10),
    ],
  ),

  TripDetail(
    id: '3',
    image: 'assets/images/car.png',
    name: 'Bole - Hayat',
    price: 12,
    pickup: 'Bole',
    dropoff: '4 kilo',
    availableSeats: 1,
    drivingTime: '20min',
    route: 'Route 1',
    stops: ['Stop 1', 'Stop 2'],
    vehicleType: 'Van',
    driverName: 'John Doe',
    startTime: '8:00 am',
    driverDetail: DriverDetail(
      name: 'John Doe',
      phoneNumber: '+1234567890',
      image: 'assets/images/usman.jpg',
    ),
    paymentStatus: 'Paid',
    carTypes: [
       CarType(name: 'Sedan', image: 'assets/images/sedan.png', price: 12),
      CarType(name: 'Midsize', image: 'assets/images/midsize.png', price: 12),
      CarType(name: 'Minivan', image: 'assets/images/minivan.jpg', price: 15),
      CarType(name: 'Minibus', image: 'assets/images/car.png', price: 10),
      CarType(name: 'Lada', image: 'assets/images/lada.PNG', price: 10),
    ],
  ),

  TripDetail(
    id: '4',
    image: 'assets/images/car.png',
    name: 'Kazanchis - Goro',
    price: 12,
    pickup: 'Bole',
    dropoff: '4 kilo',
    availableSeats: 1,
    drivingTime: '20min',
    route: 'Route 1',
    stops: ['Stop 1', 'Stop 2'],
    vehicleType: 'Van',
    driverName: 'John Doe',
    startTime: '8:00 am',
    driverDetail: DriverDetail(
      name: 'John Doe',
      phoneNumber: '+1234567890',
      image: 'assets/images/usman.jpg',
    ),
    paymentStatus: 'Paid',
    carTypes: [
        CarType(name: 'Sedan', image: 'assets/images/sedan.png', price: 12),
      CarType(name: 'Midsize', image: 'assets/images/midsize.png', price: 12),
      CarType(name: 'Minivan', image: 'assets/images/minivan.jpg', price: 15),
      CarType(name: 'Minibus', image: 'assets/images/car.png', price: 10),
      CarType(name: 'Lada', image: 'assets/images/lada.PNG', price: 10),
    ],
  ),
  TripDetail(
    id: '5',
    image: 'assets/images/car.png',
    name: 'Bole - Asko',
    price: 12,
    pickup: 'Bole',
    dropoff: '4 kilo',
    availableSeats: 1,
    drivingTime: '20min',
    route: 'Route 1',
    stops: ['Stop 1', 'Stop 2'],
    vehicleType: 'Van',
    driverName: 'John Doe',
    startTime: '8:00 am',
    driverDetail: DriverDetail(
      name: 'John Doe',
      phoneNumber: '+1234567890',
      image: 'assets/images/usman.jpg',
    ),
    paymentStatus: 'Paid',
    carTypes: [
      CarType(name: 'Sedan', image: 'assets/images/sedan.png', price: 12),
      CarType(name: 'Midsize', image: 'assets/images/midsize.png', price: 12),
      CarType(name: 'Minivan', image: 'assets/images/minivan.jpg', price: 15),
      CarType(name: 'Minibus', image: 'assets/images/car.png', price: 10),
      CarType(name: 'Lada', image: 'assets/images/lada.PNG', price: 10),
    ],
  ),
  TripDetail(
    id: '6',
    image: 'assets/images/car.png',
    name: 'Tafo - Mexico',
    price: 12,
    pickup: 'Bole',
    dropoff: '4 kilo',
    availableSeats: 1,
    drivingTime: '20min',
    route: 'Route 1',
    stops: ['Stop 1', 'Stop 2'],
    vehicleType: 'Van',
    driverName: 'John Doe',
    startTime: '8:00 am',
    driverDetail: DriverDetail(
      name: 'John Doe',
      phoneNumber: '+1234567890',
      image: 'assets/images/usman.jpg',
    ),
    paymentStatus: 'Paid',
    carTypes: [
      CarType(name: 'Sedan', image: 'assets/images/sedan.png', price: 12),
      CarType(name: 'Midsize', image: 'assets/images/midsize.png', price: 12),
      CarType(name: 'Minivan', image: 'assets/images/minivan.jpg', price: 15),
      CarType(name: 'Minibus', image: 'assets/images/car.png', price: 10),
      CarType(name: 'Lada', image: 'assets/images/lada.PNG', price: 10),
    ],
  ),

  // Add more TripDetail instances...
];
