class Phone {
  String? code;
  String? number;

  Phone({this.code, this.number});

  factory Phone.fromJson(Map<String, dynamic> json) {
    return Phone(
      code: json['code'],
      number: json['number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'number': number,
    };
  }
}


class Address {
  String? city;
  String? region;
  String? country;

  Address({this.city, this.region, this.country});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      city: json['city'],
      region: json['region'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'region': region,
      'country': country,
    };
  }
}

class CustomerRegistration {
  String? name;
  String? email;
  String? password;
  Phone? phone;
  Address? address;
  String? roleId;
  String? routeId;
  String? timingId;
  String? tripTypeId;

  CustomerRegistration({
    this.name,
    this.email,
    this.password,
    this.phone,
    this.address,
    this.roleId,
    this.routeId,
    this.timingId,
    this.tripTypeId,
  });

  factory CustomerRegistration.fromJson(Map<String, dynamic> json) {
    return CustomerRegistration(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      phone: Phone.fromJson(json['phone']),
      address: Address.fromJson(json['address']),
      roleId: json['roleId'],
      routeId: json['routeId'],
      timingId: json['timingId'],
      tripTypeId: json['tripTypeId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone?.toJson(),
      'address': address?.toJson(),
      'roleId': roleId,
      'routeId': routeId,
      'timingId': timingId,
      'tripTypeId': tripTypeId,
    };
  }
}
