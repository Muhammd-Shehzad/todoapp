import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  NavBar({
    super.key,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final name = '';

  final email = '';

  TextEditingController navBarController = TextEditingController();
  DatabaseReference db = FirebaseDatabase.instance.ref('Users');

  void getData() async {
    var snap = await db.child(FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFFEBEE), // Light pastel pink
                  Color(0xFFF8BBD0), // Medium pink tone
                  Color(0xFFF48FB1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            accountName: Text('hhhh'),
            accountEmail: Text('khan'),
            currentAccountPicture: CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/s.PNG'),
            ),
          )
        ],
      ),
    );
  }
}
