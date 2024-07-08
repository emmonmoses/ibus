import 'package:Weyeyet/utilities/app_theme.dart';
import 'package:flutter/material.dart';

class InviteFriendPage extends StatefulWidget {
  const InviteFriendPage({super.key});

  @override
  _InviteFriendPageState createState() => _InviteFriendPageState();
}

class _InviteFriendPageState extends State<InviteFriendPage> {
  final TextEditingController _emailController = TextEditingController();
  final List<String> _invitedFriends = [];

  void _inviteFriend() {
    final String email = _emailController.text;
    if (email.isNotEmpty) {
      setState(() {
        _invitedFriends.add(email);
        _emailController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.deepBlue,
        title: const Text('Invite a Friend'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Friend\'s Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _inviteFriend,
                child: const Text('Invite'),
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Already Invited Friends:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _invitedFriends.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_invitedFriends[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
