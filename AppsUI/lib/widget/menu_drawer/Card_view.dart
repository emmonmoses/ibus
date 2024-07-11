import 'package:Weyeyet/helper/color.dart';
import 'package:Weyeyet/helper/text.dart';
import 'package:Weyeyet/utilities/app_theme.dart';
import 'package:flutter/material.dart';

double defaultRadius = 8.0;
const double _cardWidth = 115;

class CardBasicRoute extends StatefulWidget {
  const CardBasicRoute({super.key});

  @override
  CardBasicRouteState createState() => CardBasicRouteState();
}

class CardBasicRouteState extends State<CardBasicRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        scrollDirection: Axis.vertical,
        child: Stack(
          children: [
            Container(
              height: 800,
              //  color: AppColor.deepBlue,
              child: Column(
                children: <Widget>[
                  Container(height: 25),
                  //..................................................................card view 1
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Image.asset(
                                ImgSample.get("usman.jpg"),
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const SizedBox(height: 5),
                                    const SizedBox(width: 5),
                                    Text(
                                      "Driver Info",
                                      style: MyTextSample.title(context)!
                                          .copyWith(
                                              color:
                                                  MyColorsSample.grey_80),
                                    ),
                                    const SizedBox(height: 5),
                                    const Divider(),
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.person,
                                          color: MyColorsSample.grey_80,
                                          size: 20,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "Usman Umer",
                                         style: TextStyle(
                                            color: MyColorsSample.grey_80,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.phone,
                                          color: MyColorsSample.grey_80,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 5),
                                        const Text(
                                          "+1234567890", // Replace with actual phone number
                                          style: TextStyle(
                                            color: MyColorsSample.grey_80,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const Spacer(),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.phone,
                                            color: Colors.green,
                                          ),
                                          onPressed: () {
                                            // Implement your call functionality here
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(height: 5),
                  // New container wrapping remaining widgets
                  Container(
                    height: 600,
                    width: MediaQuery.of(context).size.width,
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 30),
                    decoration: BoxDecoration(
                      color: AppColor.deepBlue,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  //color: Colors.teal[800],
                                  color: AppColor.white,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding: const EdgeInsets.all(15),
                                        child: const Text(
                                          "From Bole ",
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.black),
                                        ),
                                      ),
                                      const Divider(
                                        color: Colors.white,
                                        thickness: 0.5,
                                        height: 0,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            width: 15,
                                          ),
                                          const Text(
                                            "pickup",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            icon: const Icon(Icons.location_on,
                                                color: Colors.black),
                                            onPressed: () {},
                                          ),
                                          Container(
                                            width: 4,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(width: 2),
                              Expanded(
                                flex: 1,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  //color: Colors.teal[800],
                                  color: AppColor.white,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding: const EdgeInsets.all(15),
                                        child: const Text(
                                          "To 4-Kilo ",
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.black),
                                        ),
                                      ),
                                      const Divider(
                                        color: Colors.white,
                                        thickness: 0.5,
                                        height: 0,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            width: 15,
                                          ),
                                          const Text(
                                            "Drop off ",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            icon: const Icon(Icons.location_on,
                                                color: Colors.black),
                                            onPressed: () {},
                                          ),
                                          Container(
                                            width: 4,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(height: 5),
                          //..................................................................card view row
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Card(
                                  elevation: 2,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                  ),
                                  child: InkWell(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16)),
                                    onTap: () {},
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 16, right: 16, top: 8),
                                          child: Text(
                                            "From",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const Divider(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const <Widget>[
                                              Text(
                                                'Feb 27, 2024',
                                              ),
                                              Icon(Icons.date_range),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(width: 2),
                              Expanded(
                                flex: 1,
                                child: Card(
                                  elevation: 2,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                  ),
                                  child: InkWell(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16)),
                                    onTap: () {},
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 16, right: 16, top: 8),
                                          child: Text(
                                            "To",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const Divider(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const <Widget>[
                                              Text(
                                                'Mar 27, 2024',
                                              ),
                                              Icon(Icons.date_range),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(height: 10),

                          //..................................................................divider card view
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const <Widget>[],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: const Divider(height: 1),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Pick up Time",
                                          style: MyTextSample.medium(context)
                                              .copyWith(
                                                  color:
                                                      MyColorsSample.grey_80)),
                                      Container(height: 5),
                                      Row(
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              backgroundColor:
                                                  MyColorsSample.primary,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                            onPressed: () {},
                                            child: const Text(
                                              '8:00 Am',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              backgroundColor: Colors.green,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                            onPressed: () {},
                                            child: const Text(
                                              '1:00 Pm',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(height: 10),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(
                                color: MyColorsSample.primary,
                                width: 2,
                              ),
                            ),
                            elevation: 0,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Subscribe Type",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.grey[800]),
                                  ),
                                  Container(height: 10),
                                  const Text('Round Trip',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.redAccent)),
                                  Container(height: 10),
                                ],
                              ),
                            ),
                          ),

                          Container(height: 10),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(
                                color: MyColorsSample.primary,
                                width: 2,
                              ),
                            ),
                            elevation: 0,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Car Details",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.grey[800]),
                                  ),
                                  Container(height: 10),
                                  const Text('Toyota Corolla Silver',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.redAccent)),
                                  Container(height: 10),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
