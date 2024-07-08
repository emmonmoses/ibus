import 'package:Weyeyet/Screen/important_pages/invite_friend.dart';
import 'package:Weyeyet/Screen/important_pages/privacy_policy_page.dart';
import 'package:Weyeyet/Screen/important_pages/setting_page.dart';
import 'package:Weyeyet/Screen/important_pages/trip_Suggestion.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:Weyeyet/utilities/app_theme.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: Colors.white54,
          child: FadeIn(
            duration: const Duration(seconds: 2),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircleAvatar(
                      maxRadius: 65,
                      backgroundImage: AssetImage("assets/images/usman.jpg"),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Usman Umer",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 26,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Software Developer @Appliedline",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: ListView(
                    children: [
                      Card(
                        margin: const EdgeInsets.only(
                            left: 35, right: 35, bottom: 10),
                        color: Colors.white70,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PrivacyPolicyPage()),
                            );
                          },
                          child: ListTile(
                            leading: Icon(
                              Icons.privacy_tip_sharp,
                              color: AppColor.deepBlue,
                            ),
                            title: const Text(
                              'Privacy',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: AppColor.deepBlue,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Card(
                        color: Colors.white70,
                        margin: const EdgeInsets.only(
                            left: 35, right: 35, bottom: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const TripSuggestionPage()),
                            );
                          },
                          child: ListTile(
                            leading: Icon(
                              Icons.commute,
                              color: AppColor.deepBlue,
                            ),
                            title: const Text(
                              'suggest Trip',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: AppColor.deepBlue,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Card(
                        color: Colors.white70,
                        margin: const EdgeInsets.only(
                            left: 35, right: 35, bottom: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.help_outline,
                            color: AppColor.deepBlue,
                          ),
                          title: const Text(
                            'Help & Support',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: AppColor.deepBlue,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Card(
                        color: Colors.white70,
                        margin: const EdgeInsets.only(
                            left: 35, right: 35, bottom: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SettingsPage()),
                            );
                          },
                          child: ListTile(
                            leading: Icon(
                              Icons.settings,
                              color: AppColor.deepBlue,
                            ),
                            title: const Text(
                              'Settings',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: AppColor.deepBlue,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Card(
                        color: Colors.white70,
                        margin: const EdgeInsets.only(
                            left: 35, right: 35, bottom: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const InviteFriendPage()),
                            );
                          },
                          child: ListTile(
                            leading: Icon(
                              Icons.add_reaction_sharp,
                              color: AppColor.deepBlue,
                            ),
                            title: const Text(
                              'Invite a Friend',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: AppColor.deepBlue,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Card(
                      //   color: Colors.white70,
                      //   margin: const EdgeInsets.only(
                      //       left: 35, right: 35, bottom: 10),
                      //   shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(30),
                      //   ),
                      //   child: ListTile(
                      //     leading: Icon(
                      //       Icons.logout,
                      //       color: AppColor.deepBlue,
                      //     ),
                      //     title: const Text(
                      //       'Logout',
                      //       style: TextStyle(
                      //         fontSize: 18,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //     trailing: Icon(
                      //       Icons.arrow_forward_ios_outlined,
                      //       color: AppColor.deepBlue,
                      //     ),
                      //   ),
                      // ),
                    
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
