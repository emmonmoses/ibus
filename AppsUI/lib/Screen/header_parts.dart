import 'package:Weyeyet/Screen/User/account_profile.dart';
import 'package:Weyeyet/utilities/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart'; // Import for date formatting

class HeaderParts extends StatefulWidget {
  const HeaderParts({Key? key}) : super(key: key);

  @override
  State<HeaderParts> createState() => _HeaderPartsState();
}

int indexCategory = 0;

class _HeaderPartsState extends State<HeaderParts> {
  String? name;
  late String greeting;
  late IconData weatherIcon;

  @override
  void initState() {
    super.initState();
    _loadUsername();
    _updateGreetingAndWeather();
  }

  Future<void> _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name');
    });
  }

  void _updateGreetingAndWeather() {
    // Get current time
    DateTime now = DateTime.now();

    // Set greeting based on time of day
    if (now.hour < 12) {
      greeting = 'Good Morning,';
    } else if (now.hour < 18) {
      greeting = 'Good Afternoon,';
    } else {
      greeting = 'Good Evening,';
    }

    // Set weather icon based on current time (for demonstration purpose)
    if (now.hour >= 6 && now.hour < 18) {
      weatherIcon = Icons.wb_sunny; // Daytime icon
    } else {
      weatherIcon = Icons.nightlight_round; // Nighttime icon
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        topHeader(),
        const SizedBox(
          height: 30,
        ),
        title(),
        const SizedBox(
          height: 21,
        ),
        searchBar(),
        const SizedBox(
          height: 30,
        ),
        categorySelection(),
      ],
    );
  }

  Padding categorySelection() {
    // list of locations
    List<String> locations = ["All", "Bole", "Piassa", "Megenagna"];
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: SizedBox(
        height: 35,
        child: ListView.builder(
          itemCount: locations.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  indexCategory = index;
                });
              },
              child: Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 10,
                  ),
                  child: Text(
                    locations[index],
                    style: TextStyle(
                      fontSize: 20,
                      color: indexCategory == index
                          ? AppColor.deepBlue // Change color as needed
                          : Colors.black45,
                      fontWeight: indexCategory == index
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Container searchBar() {
    return Container(
      height: 55,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColor.deepBlue, // Change color as needed
                ),
                hintText: "Search Trip or Location",
                hintStyle: const TextStyle(color: Colors.black26),
              ),
            ),
          ),
          Material(
            color: AppColor.deepBlue, // Change color as needed
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                child: Icon(
                  Icons.commute,
                  color: AppColor.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding title() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          Text(
            "Weyeyet Transport",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColor.deepBlue, // Change color as needed
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Safe and Affordable Rides for you!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Padding topHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          // For menu
          // Material(
          //   color: Colors.black12,
          //   borderRadius: BorderRadius.circular(10),
          //   child: InkWell(
          //     onTap: () {},
          //     borderRadius: BorderRadius.circular(10),
          //     child: Container(
          //       height: 40,
          //       width: 40,
          //       alignment: Alignment.center,
          //       child: const Icon(
          //         Icons.menu,
          //         color: Colors.black,
          //       ),
          //     ),
          //   ),
          // ),

          // const Spacer(),
          // Greeting and weather
          Row(
            children: [
              Icon(
                weatherIcon,
                color: Colors.amber,
                size: 18,
              ),
              const SizedBox(width: 5),
              Text(
                '$greeting $name',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
              ),
            ],
          ),
          const Spacer(),
          // Profile image
          GestureDetector(
            onTap: () {
              // Open menu (you can implement your logic here)
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const ProfilePage();
                },
              ));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                "assets/images/usman.jpg",
                height: 40,
                width: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // void _logout() {
  //   // Implement logout logic here, for example:
  //   // Clear user data from SharedPreferences and navigate to login page
  //   SharedPreferences.getInstance().then((prefs) {
  //     prefs.clear(); // Clear SharedPreferences
  //     Navigator.push(context, MaterialPageRoute(
  //       builder: (context) {
  //         return const LoginPage();
  //       },
  //     )); // Navigate to login page
  //   });
  // }
}
