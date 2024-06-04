import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Weyeyet/utilities/colors.dart';
import 'package:Weyeyet/model/items_model.dart';

class MyTripHistoryPage extends StatelessWidget {
  final TripDetail trip;

  const MyTripHistoryPage({Key? key, required this.trip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking Confirmation"),
        backgroundColor: primaryColors,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildDriverDetails(),
              const SizedBox(height: 24),
              _buildSectionTitle('Trip Information'),
              _buildTripInformation(),
              const SizedBox(height: 24),
              _buildSectionTitle('Additional Information'),
              _buildAdditionalInformation(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDriverDetails() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(trip.driverDetail.image),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trip.driverDetail.name,
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    trip.driverDetail.phoneNumber,
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.phone, color: Colors.green),
              onPressed: () {
                // Implement call functionality here
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: GoogleFonts.lato(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: primaryColors,
        ),
      ),
    );
  }

  Widget _buildTripInformation() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow(Icons.attach_money, 'Price', '\$${trip.price}'),
            _buildDetailRow(Icons.location_on, 'Pickup', trip.pickup),
            _buildDetailRow(Icons.location_off, 'Dropoff', trip.dropoff),
            _buildDetailRow(Icons.directions_car, 'Vehicle Type', trip.vehicleType),
            _buildDetailRow(Icons.schedule, 'Start Time', trip.startTime),
            _buildDetailRow(Icons.access_time, 'Driving Time', trip.drivingTime),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalInformation() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow(Icons.map, 'Route', trip.route),
            _buildDetailRow(Icons.stop_circle, 'Stops', trip.stops.join(', ')),
            _buildDetailRow(Icons.payment, 'Payment Status', trip.paymentStatus),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: primaryColors,
            size: 28,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    color: Colors.grey[600],
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
