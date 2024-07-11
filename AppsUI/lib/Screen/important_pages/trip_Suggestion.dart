import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:Weyeyet/utilities/app_theme.dart';

class TripSuggestionPage extends StatefulWidget {
  const TripSuggestionPage({Key? key}) : super(key: key);

  @override
  _TripSuggestionPageState createState() => _TripSuggestionPageState();
}

class _TripSuggestionPageState extends State<TripSuggestionPage> {
  final TextEditingController pickUpAddressController = TextEditingController();
  final TextEditingController dropOffAddressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String tripType = 'One Time';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.deepBlue,
        title: const Text('Add Trip'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height, // Provide a height constraint
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 30,
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            FadeInDown(
              delay: const Duration(milliseconds: 200),
              child: TextFormField(
                controller: pickUpAddressController,
                decoration: InputDecoration(
                  labelText: 'Pick-Up Address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your pick-up address';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 20),
            FadeInDown(
              delay: const Duration(milliseconds: 300),
              child: TextFormField(
                controller: dropOffAddressController,
                decoration: InputDecoration(
                  labelText: 'Drop-Off Address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your drop-off address';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 20),
            FadeInDown(
              delay: const Duration(milliseconds: 400),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        tripType = 'One Time';
                      });
                    },
                    icon: const Icon(Icons.directions_car),
                    label: const Text('One Time'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tripType == 'One Time'
                          ? AppColor.deepBlue
                          : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        tripType = 'Round Trip';
                      });
                    },
                    icon: const Icon(Icons.loop),
                    label: const Text('Round Trip'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tripType == 'Round Trip'
                          ? AppColor.deepBlue
                          : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FadeInDown(
                  delay: const Duration(milliseconds: 500),
                  child: SizedBox(
                    width: 300, // Set the width of the button here
                    child: MaterialButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Handle trip suggestion submission
                        }
                      },
                      color: AppColor.deepBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 30,
                      ),
                      child: const Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20), // Add some spacing at the bottom
          ],
        ),
      ),
    );
  }
}
