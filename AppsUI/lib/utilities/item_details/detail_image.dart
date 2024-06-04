import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:Weyeyet/model/items_model.dart'; // Import the model

class DetailImage extends StatelessWidget {
  const DetailImage({Key? key, required this.carTypes, required this.selectedIndex}) : super(key: key);
  
  final List<CarType> carTypes; // List of CarType objects
  final int selectedIndex; // Index of the specific image to display

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: false, // Disable auto-play
          enlargeCenterPage: true,
          initialPage: selectedIndex, // Set initial page to the selected index
          viewportFraction: 1.0, // Show only one item at a time
        ),
        items: carTypes.map((carType) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                    image: AssetImage(carType.image), // Use imageUrl from CarType
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
