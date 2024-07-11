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

final List<CarType> carTypes = [
  CarType(name: 'Sedan', image: 'assets/sedan.png', price: 25.0),
  CarType(name: 'SUV', image: 'assets/suv.png', price: 35.0),
  CarType(name: 'Truck', image: 'assets/truck.png', price: 45.0),
];
