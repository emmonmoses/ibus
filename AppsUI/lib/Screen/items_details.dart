import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';
import 'package:Weyeyet/utilities/colors.dart';
import 'package:Weyeyet/utilities/app_theme.dart';
import 'package:Weyeyet/utilities/item_details/confirmation_messages.dart';
import 'package:Weyeyet/utilities/item_details/detail_image.dart';
import 'package:Weyeyet/utilities/item_details/detail_items_header.dart';
import 'package:Weyeyet/model/items_model.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.trip, required this.carType,this.selectedIndex = 0});
  final TripDetail trip;
  final CarType carType;
    final int selectedIndex; // Index of the specific image to display, default to 0


  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  void showDriverDetails(BuildContext context, String driverName) {
    // Show driver details (mocked data for now)
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Driver Details'),
          content: Text(
            'Driver Name: $driverName\nExperience: 5 years\nRating: 4.8/5.0',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showCarDetails(BuildContext context, String carType) {
    // Show car details (mocked data for now)
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Car Details'),
          content: Text(
            'Car Type: $carType\nModel: 2023\nColor: Black\nLicense Plate: XYZ 1234',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColors,
      body: ListView(
        children: [
          const SizedBox(height: 20),
          // Detail header
          const DetailItemsHeader(),
          // For image with Hero animation
     Hero(
            tag: widget.trip.id, // Use an identifier here
            child: DetailImage(carTypes: widget.trip.carTypes, selectedIndex: widget.selectedIndex), // Pass carTypes from the model
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // For name
                          FadeInDown(
                            delay: const Duration(milliseconds: 100),
                            child: Text(
                              widget.trip.name,
                              maxLines: 1,
                              style: GoogleFonts.lato(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          // For price
                          FadeInDown(
                            delay: const Duration(milliseconds: 200),
                            child: Text(
                              '\$${widget.carType.price}', // Use carType price
                              style: GoogleFonts.lato(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: primaryColors,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Display available seats
                    Material(
                      color: primaryColors,
                      borderRadius: BorderRadius.circular(30),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: Text(
                          'Available Seats: ${widget.trip.availableSeats}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 27),
                Row(
                  children: [
                    // For pickup location
                    FadeInDown(
                      delay: const Duration(milliseconds: 300),
                      child: const Icon(
                        Icons.my_location,
                        color: Colors.amber,
                      ),
                    ),
                    const SizedBox(width: 4),
                    FadeInDown(
                      delay: const Duration(milliseconds: 300),
                      child: Text(
                        widget.trip.pickup,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Spacer(),
                    // For starting time
                    FadeInDown(
                      delay: const Duration(milliseconds: 400),
                      child: const Icon(
                        Icons.access_time_filled,
                        color: Colors.amber,
                      ),
                    ),
                    const SizedBox(width: 4),
                    FadeInDown(
                      delay: const Duration(milliseconds: 400),
                      child: Text(
                        widget.trip.startTime,
                        maxLines: 1,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    // For dropoff location
                    FadeInDown(
                      delay: const Duration(milliseconds: 500),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.amber,
                      ),
                    ),
                    const SizedBox(width: 4),
                    FadeInDown(
                      delay: const Duration(milliseconds: 500),
                      child: Text(
                        widget.trip.dropoff,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // For driving time
                FadeInDown(
                  delay: const Duration(milliseconds: 600),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.access_time_filled,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.trip.drivingTime,
                        maxLines: 1,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // For route and other details with icons
                FadeInDown(
                  delay: const Duration(milliseconds: 700),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.route,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Route: ${widget.trip.route}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                FadeInDown(
                  delay: const Duration(milliseconds: 800),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.stop_circle,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Stops: ${widget.trip.stops.join(", ")}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    showCarDetails(context, widget.carType.name); // Use carType name
                  },
                  child: FadeInDown(
                    delay: const Duration(milliseconds: 900),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.directions_car,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Vehicle Type: ${widget.carType.name}', // Use carType name
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    showDriverDetails(context, widget.trip.driverName);
                  },
                  child: FadeInDown(
                    delay: const Duration(milliseconds: 1000),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.person,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Driver: ${widget.trip.driverName}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                // For register button with custom style
                FadeInDown(
                  delay: const Duration(milliseconds: 1100),
                  child: Material(
                    color: primaryColors,
                    borderRadius: BorderRadius.circular(15),
                    child: InkWell(
                      onTap: () {
                        QuickAlert.show(
                          headerBackgroundColor: primaryColors,
                          context: context,
                          type: QuickAlertType.success,
                          title: "Congratulations!",
                          text: "You have successfully booked a trip with the ${widget.carType.name}!",
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Center(
                          child: Text(
                            'Book Now for \$${widget.carType.price}', // Use carType price
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
