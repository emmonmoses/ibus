import 'package:flutter/material.dart';
import 'package:Weyeyet/utilities/colors.dart';

class HeaderParts extends StatefulWidget {
  const HeaderParts({super.key});

  @override
  State<HeaderParts> createState() => _HeaderPartsState();
}

int indexCategory = 0;

class _HeaderPartsState extends State<HeaderParts> {
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
    // list of times
    List list = ["All", "Bole", "Piassa", "Megenagna"];
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: SizedBox(
        height: 35,
        child: ListView.builder(
            itemCount: list.length,
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
                      list[index],
                      style: TextStyle(
                        fontSize: 20,
                        color: indexCategory == index
                            ? primaryColors
                            : Colors.black45,
                        fontWeight:
                            indexCategory == index ? FontWeight.bold : null,
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  Container searchBar() {
    return Container(
      height: 55,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          color: Colors.green[50], borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          const Expanded(
              child: TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search,
                  color: primaryColors,
                ),
                hintText: "Search Trip or Location",
                hintStyle: TextStyle(color: Colors.black26)),
          )),
          Material(
            color: primaryColors,
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.commute,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding title() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hi Customer",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryColors,
                fontSize: 18),
          ),
          Text(
            "Safe and Affordable Rides for you!",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
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
          Material(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_open_rounded,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const Spacer(),
          // For location
          const Icon(
            Icons.sunny,
            color: Colors.amber,
            size: 18,
          ),

          const Text(
            "Good Morning, Usman",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black38,
            ),
          ),
          const Spacer(),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              "assets/images/usman.jpg",
              height: 40,
              width: 40,
            ),
          )
        ],
      ),
    );
  }
}
